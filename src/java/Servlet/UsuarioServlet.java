package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    public UsuarioServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if ("obtenerDatos".equals(accion)) {
                obtenerDatosUsuario(request, response, out);
            } else if ("verificarSesion".equals(accion)) {
                verificarSesion(request, response, out);
            } else {
                ErrorResponse error = new ErrorResponse("Acción no válida");
                out.print(gson.toJson(error));
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            ErrorResponse error = new ErrorResponse("Error interno del servidor: " + e.getMessage());
            out.print(gson.toJson(error));
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            if ("logout".equals(accion)) {
                cerrarSesion(request, response, out);
            } else {
                ErrorResponse error = new ErrorResponse("Acción no válida");
                out.print(gson.toJson(error));
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            ErrorResponse error = new ErrorResponse("Error interno del servidor: " + e.getMessage());
            out.print(gson.toJson(error));
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Obtiene los datos del usuario desde la sesión
     */
    private void obtenerDatosUsuario(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            // No hay sesión activa - devolver respuesta amigable
            UsuarioResponse usuarioResponse = new UsuarioResponse(
                "Invitado",
                "invitado@ejemplo.com",
                "invitado",
                0
            );
            usuarioResponse.setSuccess(false);
            usuarioResponse.setMensaje("No hay sesión activa");
            
            out.print(gson.toJson(usuarioResponse));
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }
        
        // Obtener datos del usuario de la sesión
        String nombre = (String) session.getAttribute("usuarioNombre");
        String email = (String) session.getAttribute("usuarioCorreo");
        String rol = (String) session.getAttribute("usuarioRol");
        Integer idUsuario = (Integer) session.getAttribute("usuarioId");
        
        // Si no hay datos en los atributos específicos, buscar en el objeto usuario
        if (nombre == null && email == null) {
            Object usuarioObj = session.getAttribute("usuario");
            
            if (usuarioObj != null) {
                // Usar reflexión para extraer datos del objeto Usuario
                try {
                    Class<?> usuarioClass = usuarioObj.getClass();
                    
                    // Obtener nombre
                    try {
                        java.lang.reflect.Method getNombre = usuarioClass.getMethod("getNombre");
                        String nombreTemp = (String) getNombre.invoke(usuarioObj);
                        java.lang.reflect.Method getApellido = usuarioClass.getMethod("getApellido");
                        String apellidoTemp = (String) getApellido.invoke(usuarioObj);
                        nombre = (nombreTemp != null ? nombreTemp : "") + " " + (apellidoTemp != null ? apellidoTemp : "");
                    } catch (Exception e) {
                        nombre = "Usuario";
                    }
                    
                    // Obtener email
                    try {
                        java.lang.reflect.Method getEmail = usuarioClass.getMethod("getEmail");
                        email = (String) getEmail.invoke(usuarioObj);
                    } catch (Exception e) {
                        try {
                            java.lang.reflect.Method getCorreo = usuarioClass.getMethod("getCorreo");
                            email = (String) getCorreo.invoke(usuarioObj);
                        } catch (Exception e2) {
                            email = "usuario@ejemplo.com";
                        }
                    }
                    
                    // Obtener rol
                    try {
                        java.lang.reflect.Method getRol = usuarioClass.getMethod("getRol");
                        rol = (String) getRol.invoke(usuarioObj);
                    } catch (Exception e) {
                        rol = "cliente";
                    }
                    
                    // Obtener ID
                    try {
                        java.lang.reflect.Method getId = usuarioClass.getMethod("getId");
                        Object idObj = getId.invoke(usuarioObj);
                        if (idObj instanceof Integer) {
                            idUsuario = (Integer) idObj;
                        }
                    } catch (Exception e) {
                        try {
                            java.lang.reflect.Method getIdUsuario = usuarioClass.getMethod("getId_usuario");
                            Object idObj = getIdUsuario.invoke(usuarioObj);
                            if (idObj instanceof Integer) {
                                idUsuario = (Integer) idObj;
                            }
                        } catch (Exception e2) {
                            idUsuario = 0;
                        }
                    }
                    
                } catch (Exception e) {
                    // Si falla la reflexión, usar valores por defecto
                    nombre = "Usuario";
                    email = "usuario@ejemplo.com";
                    rol = "cliente";
                    idUsuario = 0;
                }
            } else {
                // No hay objeto usuario en sesión
                UsuarioResponse usuarioResponse = new UsuarioResponse(
                    "Invitado",
                    "invitado@ejemplo.com",
                    "invitado",
                    0
                );
                usuarioResponse.setSuccess(false);
                usuarioResponse.setMensaje("No hay usuario en sesión");
                
                out.print(gson.toJson(usuarioResponse));
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            }
        }
        
        // Crear respuesta con datos del usuario
        UsuarioResponse usuarioResponse = new UsuarioResponse(
            nombre != null ? nombre.trim() : "Usuario",
            email != null ? email : "usuario@ejemplo.com",
            rol != null ? rol : "cliente",
            idUsuario != null ? idUsuario : 0
        );
        
        // Si el ID es 0, considerar que no hay sesión válida
        if (idUsuario == 0) {
            usuarioResponse.setSuccess(false);
            usuarioResponse.setMensaje("Sesión no válida");
        }
        
        out.print(gson.toJson(usuarioResponse));
        response.setStatus(HttpServletResponse.SC_OK);
    }

    /**
     * Verifica simplemente si hay una sesión activa
     */
    private void verificarSesion(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        HttpSession session = request.getSession(false);
        
        SessionResponse sessionResponse = new SessionResponse();
        
        if (session != null && session.getAttribute("usuario") != null) {
            sessionResponse.setSuccess(true);
            sessionResponse.setSesionActiva(true);
            sessionResponse.setMensaje("Sesión activa");
        } else {
            sessionResponse.setSuccess(true);
            sessionResponse.setSesionActiva(false);
            sessionResponse.setMensaje("No hay sesión activa");
        }
        
        out.print(gson.toJson(sessionResponse));
        response.setStatus(HttpServletResponse.SC_OK);
    }

    /**
     * Cierra la sesión del usuario
     */
    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            try {
                // Invalidar la sesión
                session.invalidate();
                
                SuccessResponse success = new SuccessResponse("Sesión cerrada correctamente");
                out.print(gson.toJson(success));
                response.setStatus(HttpServletResponse.SC_OK);
                
            } catch (Exception e) {
                ErrorResponse error = new ErrorResponse("Error al cerrar sesión: " + e.getMessage());
                out.print(gson.toJson(error));
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            SuccessResponse success = new SuccessResponse("No había sesión activa");
            out.print(gson.toJson(success));
            response.setStatus(HttpServletResponse.SC_OK);
        }
    }

    /**
     * Clase para la respuesta de datos del usuario
     */
    private static class UsuarioResponse {
        private String nombre;
        private String email;
        private String rol;
        private int id;
        private boolean success = true;
        private String mensaje;

        public UsuarioResponse(String nombre, String email, String rol, int id) {
            this.nombre = nombre;
            this.email = email;
            this.rol = rol;
            this.id = id;
        }

        public String getNombre() { return nombre; }
        public void setNombre(String nombre) { this.nombre = nombre; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getRol() { return rol; }
        public void setRol(String rol) { this.rol = rol; }
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getMensaje() { return mensaje; }
        public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    }

    /**
     * Clase para respuesta de verificación de sesión
     */
    private static class SessionResponse {
        private boolean success = true;
        private boolean sesionActiva = false;
        private String mensaje;

        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public boolean isSesionActiva() { return sesionActiva; }
        public void setSesionActiva(boolean sesionActiva) { this.sesionActiva = sesionActiva; }
        public String getMensaje() { return mensaje; }
        public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    }

    /**
     * Clase para respuestas de éxito
     */
    private static class SuccessResponse {
        private boolean success = true;
        private String message;

        public SuccessResponse(String message) {
            this.message = message;
        }

        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
    }

    /**
     * Clase para respuestas de error
     */
    private static class ErrorResponse {
        private boolean success = false;
        private String error;

        public ErrorResponse(String error) {
            this.error = error;
        }

        public boolean isSuccess() { return success; }
        public String getError() { return error; }
    }
}