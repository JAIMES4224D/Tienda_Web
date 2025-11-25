package Servlet;

import DAO.UsuarioDAO;
import Modelo.Usuario;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UsuariosAdminServlet")
public class UsuariosAdminServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String tipo = request.getParameter("tipo");
            List<Usuario> usuarios;
            
            if ("clientes".equals(tipo)) {
                usuarios = usuarioDAO.obtenerClientes();
            } else if ("administradores".equals(tipo)) {
                usuarios = usuarioDAO.obtenerAdministradores();
            } else {
                usuarios = usuarioDAO.obtenerTodosLosUsuarios();
            }
            
            out.print(gson.toJson(usuarios));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Error al obtener usuarios: " + e.getMessage() + "\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String accion = request.getParameter("accion");
            
            if ("agregarAdmin".equals(accion)) {
                Usuario usuario = new Usuario();
                usuario.setNombre(request.getParameter("nombre"));
                usuario.setApellido(request.getParameter("apellido"));
                usuario.setCorreo(request.getParameter("email"));
                usuario.setContrasena(request.getParameter("password")); // Encriptar en producción
                usuario.setTelefono(request.getParameter("telefono"));
                usuario.setDireccion(request.getParameter("direccion"));
                usuario.setRol("admin");
                
                boolean resultado = usuarioDAO.insertarUsuario(usuario);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Administrador agregado correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al agregar administrador\"}");
                }
                
            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean resultado = usuarioDAO.eliminarUsuario(id);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Usuario eliminado correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al eliminar usuario\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}