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

@WebServlet("/InicializarSesionServlet")
public class InicializarSesionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            
            // Verificar si ya existe una sesión con usuario
            Integer idUsuario = (Integer) session.getAttribute("usuarioId");
            
            if (idUsuario == null) {
                // Crear sesión simulada (solo para desarrollo)
                session.setAttribute("usuarioId", 1);
                session.setAttribute("usuarioNombre", "Jeferson Jociney");
                session.setAttribute("usuarioCorreo", "jaimespassunijeferson@gmail.com");
                session.setAttribute("usuarioRol", "cliente");
                
                out.print("{\"success\": true, \"message\": \"Sesión de desarrollo creada\", \"userId\": 1}");
            } else {
                out.print("{\"success\": true, \"message\": \"Sesión ya existente\", \"userId\": " + idUsuario + "}");
            }
            
        } catch (Exception e) {
            out.print("{\"success\": false, \"error\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}