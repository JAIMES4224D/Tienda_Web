package Servlet;

import DAO.UsuarioDAO;
import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet(name = "LoginUsuario", urlPatterns = {"/LoginUsuario"})
public class LoginUsuario extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        this.usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigir POST o mostrar mensaje
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Método GET no permitido. Use POST.");
            response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            out.print(jsonResponse.toString());
        } catch (JSONException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generando respuesta");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        System.out.println("=== INICIO PROCESO LOGIN ===");
        
        try {
            // Leer el cuerpo de la solicitud JSON
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            String requestBody = sb.toString();
            
            System.out.println("Cuerpo de la solicitud: " + requestBody);
            
            if (requestBody == null || requestBody.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Cuerpo de la solicitud vacío");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Parsear JSON
            JSONObject jsonRequest = new JSONObject(requestBody);
            String correo = jsonRequest.optString("correo", "").trim().toLowerCase();
            String contrasena = jsonRequest.optString("contrasena", "").trim();
            String rol = jsonRequest.optString("rol", "cliente").trim().toLowerCase();
            
            System.out.println("Datos parseados - Correo: " + correo + ", Rol: " + rol);
            
            // Validar datos
            if (correo.isEmpty() || contrasena.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Correo y contraseña son obligatorios");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Validar formato de correo
            if (!isValidEmail(correo)) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Formato de correo electrónico inválido");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Buscar usuario por correo
            System.out.println("Buscando usuario con correo: " + correo);
            Usuario usuario = usuarioDAO.buscarPorCorreo(correo);
            
            if (usuario == null) {
                System.out.println("Usuario no encontrado en la base de datos");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Usuario no encontrado");
                out.print(jsonResponse.toString());
                return;
            }
            
            System.out.println("Usuario encontrado: " + usuario.getNombre() + " " + usuario.getApellido());
            System.out.println("Rol del usuario: " + usuario.getRol());
            System.out.println("Rol solicitado: " + rol);
            
            // Verificar contraseña (comparar hash)
            boolean contrasenaValida = verificarContrasena(contrasena, usuario.getContrasena());
            
            if (!contrasenaValida) {
                System.out.println("Contraseña incorrecta");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Credenciales incorrectas");
                out.print(jsonResponse.toString());
                return;
            }
            
            // Verificar rol - IMPORTANTE: Permitir admin acceder como cliente también
            if (!usuario.getRol().equalsIgnoreCase(rol)) {
                // Si el usuario es admin pero intenta acceder como cliente, permitirlo
                if (usuario.getRol().equalsIgnoreCase("admin") && rol.equalsIgnoreCase("cliente")) {
                    System.out.println("Admin accediendo como cliente - PERMITIDO");
                    
                    rol = "admin"; // Mantener rol admin pero permitir acceso
                } else {
                    System.out.println("Rol no coincide. Usuario: " + usuario.getRol() + ", Solicitado: " + rol);
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "No tienes permisos para acceder con este rol");
                    out.print(jsonResponse.toString());
                    return;
                }
            }
            
            // Login exitoso
            // Guardar usuario en sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("usuarioId", usuario.getId_usuario());
            session.setAttribute("usuarioRol", usuario.getRol());
            session.setAttribute("usuarioNombre", usuario.getNombre() + " " + usuario.getApellido());
            session.setAttribute("usuarioCorreo", usuario.getCorreo());
            
            // Configurar tiempo de expiración de sesión (30 minutos)
            session.setMaxInactiveInterval(30 * 60);
            
            System.out.println("Login exitoso para: " + usuario.getNombre() + " " + usuario.getApellido());
            System.out.println("Rol: " + usuario.getRol());
            
            response.setStatus(HttpServletResponse.SC_OK);
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Inicio de sesión exitoso");
            jsonResponse.put("rol", usuario.getRol());
            jsonResponse.put("nombre", usuario.getNombre() + " " + usuario.getApellido());
            jsonResponse.put("idUsuario", usuario.getId_usuario());
            
            // Agregar información adicional para debugging
            jsonResponse.put("debug", "Usuario autenticado correctamente");
            
        } catch (JSONException e) {
            System.err.println("Error parseando JSON: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error en el formato JSON de la solicitud: " + e.getMessage());
            } catch (JSONException ex) {
                // Fallback si no se puede crear el JSON de error
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error procesando solicitud");
                return;
            }
        } catch (Exception e) {
            System.err.println("Error interno del servidor: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error interno del servidor: " + e.getMessage());
            } catch (JSONException ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno del servidor");
                return;
            }
        }
        
        System.out.println("Respuesta JSON: " + jsonResponse.toString());
        out.print(jsonResponse.toString());
        out.flush();
        System.out.println("=== FIN PROCESO LOGIN ===");
    }

    @Override
    public String getServletInfo() {
        return "Servlet para autenticación de usuarios";
    }

    // Método para verificar contraseña (comparar hash)
    private boolean verificarContrasena(String contrasenaPlana, String contrasenaHash) {
        try {
            if (contrasenaHash == null || contrasenaHash.trim().isEmpty()) {
                return false;
            }
            
            String hashCalculado = hashPassword(contrasenaPlana);
            boolean resultado = hashCalculado.equals(contrasenaHash);
            
            System.out.println("Verificación contraseña - Resultado: " + resultado);
            System.out.println("Hash almacenado: " + contrasenaHash);
            System.out.println("Hash calculado: " + hashCalculado);
            
            return resultado;
        } catch (Exception e) {
            System.err.println("Error verificando contraseña: " + e.getMessage());
            return false;
        }
    }
    
    // Método para encriptar contraseña (mismo que en el registro)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar contraseña", e);
        }
    }
    
    // Método para validar formato de email
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        // Expresión regular básica para validar email
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    // Método para limpiar sesión (logout)
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Sesión cerrada correctamente");
            out.print(jsonResponse.toString());
            
        } catch (Exception e) {
            try {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error cerrando sesión");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print(jsonResponse.toString());
            } catch (JSONException ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }
}