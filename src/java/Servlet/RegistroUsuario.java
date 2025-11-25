/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.UsuarioDAO;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "RegistroUsuario", urlPatterns = {"/RegistroUsuario"})
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10, // 10 MB
    fileSizeThreshold = 1024 * 1024     // 1 MB
)
public class RegistroUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
         PrintWriter out = response.getWriter();
        UsuarioDAO UD = new UsuarioDAO();
        try {
            // Obtener parámetros del formulario
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String rol = request.getParameter("rol");
            
            // Obtener archivo de foto
            Part filePart = request.getPart("foto");
            InputStream fotoInputStream = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fotoInputStream = filePart.getInputStream();
            }
            
            // Validar datos
            if (nombre == null || apellido == null || correo == null || contrasena == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("Faltan campos obligatorios");
                return;
            }
            
            // Aquí iría tu lógica para insertar en la base de datos
            boolean registrado = false;
            // boolean registrado = usuarioDAO.registrarUsuario(nombre, apellido, correo, contrasena, telefono, direccion, fotoInputStream, rol);
            registrado = UD.registrarCliente(nombre, apellido, correo, contrasena, telefono, direccion, fotoInputStream, rol);
            // Simulación de registro exitoso
            registrado = true;
            
             if (registrado) {
                sendSuccessPage(response, nombre);
            } else {
                sendErrorPage(response, "El correo electrónico ya está registrado. Por favor, usa otro correo o inicia sesión.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error interno del servidor: " + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
    private void sendSuccessPage(HttpServletResponse response, String nombre) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        PrintWriter out = response.getWriter();
        
        String html = "<!DOCTYPE html>\n" +
            "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:h=\"http://xmlns.jcp.org/jsf/html\">\n" +
            "<head>\n" +
            "    <title>Registro Exitoso | DonGlai - Iluminación LED</title>\n" +
            "    <meta charset=\"UTF-8\" />\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n" +
            "    <link rel=\"icon\" type=\"image/x-icon\" href=\"img/donglai.ico\" />\n" +
            "    <!-- Bootstrap 5 -->\n" +
            "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\"/>\n" +
            "    <!-- Bootstrap Icons -->\n" +
            "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css\" rel=\"stylesheet\"/>\n" +
            "    <style>\n" +
            "        :root {\n" +
            "            --primary-color: #00e0ff;\n" +
            "            --secondary-color: #00a2ff;\n" +
            "            --dark-bg: #0d0d0d;\n" +
            "            --card-bg: #1a1a1a;\n" +
            "        }\n" +
            "        body {\n" +
            "            font-family: 'Poppins', sans-serif;\n" +
            "            background-color: var(--dark-bg);\n" +
            "            color: #fff;\n" +
            "            margin: 0;\n" +
            "            padding: 0;\n" +
            "            display: flex;\n" +
            "            justify-content: center;\n" +
            "            align-items: center;\n" +
            "            min-height: 100vh;\n" +
            "        }\n" +
            "        .success-container {\n" +
            "            background: var(--card-bg);\n" +
            "            border-radius: 20px;\n" +
            "            padding: 50px 40px;\n" +
            "            text-align: center;\n" +
            "            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);\n" +
            "            border-left: 5px solid var(--primary-color);\n" +
            "            max-width: 600px;\n" +
            "            margin: 20px;\n" +
            "        }\n" +
            "        .success-icon {\n" +
            "            width: 100px;\n" +
            "            height: 100px;\n" +
            "            border-radius: 50%;\n" +
            "            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));\n" +
            "            display: flex;\n" +
            "            align-items: center;\n" +
            "            justify-content: center;\n" +
            "            margin: 0 auto 30px;\n" +
            "            font-size: 3rem;\n" +
            "            color: #000;\n" +
            "            box-shadow: 0 5px 20px rgba(0, 224, 255, 0.5);\n" +
            "            animation: pulse 2s infinite;\n" +
            "        }\n" +
            "        @keyframes pulse {\n" +
            "            0% { transform: scale(1); box-shadow: 0 5px 20px rgba(0, 224, 255, 0.5); }\n" +
            "            50% { transform: scale(1.05); box-shadow: 0 8px 30px rgba(0, 224, 255, 0.8); }\n" +
            "            100% { transform: scale(1); box-shadow: 0 5px 20px rgba(0, 224, 255, 0.5); }\n" +
            "        }\n" +
            "        h1 {\n" +
            "            color: var(--primary-color);\n" +
            "            font-size: 2.5rem;\n" +
            "            margin-bottom: 20px;\n" +
            "            font-weight: 700;\n" +
            "        }\n" +
            "        p {\n" +
            "            color: #ccc;\n" +
            "            font-size: 1.2rem;\n" +
            "            margin-bottom: 30px;\n" +
            "            line-height: 1.6;\n" +
            "        }\n" +
            "        .user-name {\n" +
            "            color: var(--primary-color);\n" +
            "            font-weight: 700;\n" +
            "            font-size: 1.3rem;\n" +
            "        }\n" +
            "        .btn-container {\n" +
            "            display: flex;\n" +
            "            gap: 15px;\n" +
            "            justify-content: center;\n" +
            "            flex-wrap: wrap;\n" +
            "        }\n" +
            "        .btn-success {\n" +
            "            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));\n" +
            "            border: none;\n" +
            "            color: #000;\n" +
            "            font-weight: 700;\n" +
            "            border-radius: 30px;\n" +
            "            padding: 12px 30px;\n" +
            "            font-size: 1.1rem;\n" +
            "            transition: all 0.3s ease;\n" +
            "            text-decoration: none;\n" +
            "            display: inline-block;\n" +
            "            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);\n" +
            "        }\n" +
            "        .btn-success:hover {\n" +
            "            transform: translateY(-3px);\n" +
            "            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);\n" +
            "            color: #000;\n" +
            "        }\n" +
            "        .btn-secondary {\n" +
            "            background: transparent;\n" +
            "            border: 2px solid var(--primary-color);\n" +
            "            color: var(--primary-color);\n" +
            "            font-weight: 700;\n" +
            "            border-radius: 30px;\n" +
            "            padding: 12px 30px;\n" +
            "            font-size: 1.1rem;\n" +
            "            transition: all 0.3s ease;\n" +
            "            text-decoration: none;\n" +
            "            display: inline-block;\n" +
            "        }\n" +
            "        .btn-secondary:hover {\n" +
            "            background: var(--primary-color);\n" +
            "            color: #000;\n" +
            "            transform: translateY(-3px);\n" +
            "        }\n" +
            "        .auto-redirect {\n" +
            "            color: #aaa;\n" +
            "            font-size: 0.9rem;\n" +
            "            margin-top: 25px;\n" +
            "        }\n" +
            "    </style>\n" +
            "</head>\n" +
            "<body>\n" +
            "    <div class=\"success-container\">\n" +
            "        <div class=\"success-icon\">\n" +
            "            <i class=\"bi bi-check-lg\"></i>\n" +
            "        </div>\n" +
            "        <h1>¡Registro Exitoso!</h1>\n" +
            "        <p>Bienvenido a DonGlai, <span class=\"user-name\">" + nombre + "</span>. Tu cuenta ha sido creada correctamente.</p>\n" +
            "        <p>Ahora puedes acceder a todos nuestros productos y ofertas exclusivas de iluminación LED.</p>\n" +
            "        \n" +
            "        <div class=\"btn-container\">\n" +
            "            <a href=\"login.jsp\" class=\"btn-success\">\n" +
            "                <i class=\"bi bi-box-arrow-in-right\"></i> Iniciar Sesión\n" +
            "            </a>\n" +
            "            <a href=\"index.html\" class=\"btn-secondary\">\n" +
            "                <i class=\"bi bi-house\"></i> Ir al Inicio\n" +
            "            </a>\n" +
            "        </div>\n" +
            "        \n" +
            "        <div class=\"auto-redirect\">\n" +
            "            Serás redirigido automáticamente en <span id=\"countdown\">10</span> segundos...\n" +
            "        </div>\n" +
            "    </div>\n" +
            "\n" +
            "    <script>\n" +
            "        // Contador para redirección automática\n" +
            "        let seconds = 10;\n" +
            "        const countdownElement = document.getElementById('countdown');\n" +
            "        \n" +
            "        const countdown = setInterval(function() {\n" +
            "            seconds--;\n" +
            "            countdownElement.textContent = seconds;\n" +
            "            \n" +
            "            if (seconds <= 0) {\n" +
            "                clearInterval(countdown);\n" +
            "                window.location.href = 'login.jsp';\n" +
            "            }\n" +
            "        }, 1000);\n" +
            "    </script>\n" +
            "</body>\n" +
            "</html>";
        
        out.print(html);
    }
    
    private void sendErrorPage(HttpServletResponse response, String mensajeError) throws IOException {
        response.setStatus(HttpServletResponse.SC_CONFLICT);
        PrintWriter out = response.getWriter();
        
        String html = "<!DOCTYPE html>\n" +
            "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:h=\"http://xmlns.jcp.org/jsf/html\">\n" +
            "<head>\n" +
            "    <title>Error en Registro | DonGlai - Iluminación LED</title>\n" +
            "    <meta charset=\"UTF-8\" />\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n" +
            "    <link rel=\"icon\" type=\"image/x-icon\" href=\"img/donglai.ico\" />\n" +
            "    <!-- Bootstrap 5 -->\n" +
            "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\"/>\n" +
            "    <!-- Bootstrap Icons -->\n" +
            "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css\" rel=\"stylesheet\"/>\n" +
            "    <style>\n" +
            "        :root {\n" +
            "            --primary-color: #00e0ff;\n" +
            "            --error-color: #ff4d4d;\n" +
            "            --dark-bg: #0d0d0d;\n" +
            "            --card-bg: #1a1a1a;\n" +
            "        }\n" +
            "        body {\n" +
            "            font-family: 'Poppins', sans-serif;\n" +
            "            background-color: var(--dark-bg);\n" +
            "            color: #fff;\n" +
            "            margin: 0;\n" +
            "            padding: 0;\n" +
            "            display: flex;\n" +
            "            justify-content: center;\n" +
            "            align-items: center;\n" +
            "            min-height: 100vh;\n" +
            "        }\n" +
            "        .error-container {\n" +
            "            background: var(--card-bg);\n" +
            "            border-radius: 20px;\n" +
            "            padding: 50px 40px;\n" +
            "            text-align: center;\n" +
            "            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);\n" +
            "            border-left: 5px solid var(--error-color);\n" +
            "            max-width: 600px;\n" +
            "            margin: 20px;\n" +
            "        }\n" +
            "        .error-icon {\n" +
            "            width: 100px;\n" +
            "            height: 100px;\n" +
            "            border-radius: 50%;\n" +
            "            background: var(--error-color);\n" +
            "            display: flex;\n" +
            "            align-items: center;\n" +
            "            justify-content: center;\n" +
            "            margin: 0 auto 30px;\n" +
            "            font-size: 3rem;\n" +
            "            color: #fff;\n" +
            "            box-shadow: 0 5px 20px rgba(255, 77, 77, 0.5);\n" +
            "        }\n" +
            "        h1 {\n" +
            "            color: var(--error-color);\n" +
            "            font-size: 2.5rem;\n" +
            "            margin-bottom: 20px;\n" +
            "            font-weight: 700;\n" +
            "        }\n" +
            "        .error-message {\n" +
            "            color: #ff9999;\n" +
            "            font-size: 1.2rem;\n" +
            "            margin-bottom: 30px;\n" +
            "            line-height: 1.6;\n" +
            "            background: rgba(255, 77, 77, 0.1);\n" +
            "            padding: 15px;\n" +
            "            border-radius: 10px;\n" +
            "            border-left: 3px solid var(--error-color);\n" +
            "        }\n" +
            "        .btn-container {\n" +
            "            display: flex;\n" +
            "            gap: 15px;\n" +
            "            justify-content: center;\n" +
            "            flex-wrap: wrap;\n" +
            "        }\n" +
            "        .btn-primary {\n" +
            "            background: var(--primary-color);\n" +
            "            border: none;\n" +
            "            color: #000;\n" +
            "            font-weight: 700;\n" +
            "            border-radius: 30px;\n" +
            "            padding: 12px 30px;\n" +
            "            font-size: 1.1rem;\n" +
            "            transition: all 0.3s ease;\n" +
            "            text-decoration: none;\n" +
            "            display: inline-block;\n" +
            "            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);\n" +
            "        }\n" +
            "        .btn-primary:hover {\n" +
            "            transform: translateY(-3px);\n" +
            "            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);\n" +
            "            color: #000;\n" +
            "        }\n" +
            "        .btn-secondary {\n" +
            "            background: transparent;\n" +
            "            border: 2px solid var(--primary-color);\n" +
            "            color: var(--primary-color);\n" +
            "            font-weight: 700;\n" +
            "            border-radius: 30px;\n" +
            "            padding: 12px 30px;\n" +
            "            font-size: 1.1rem;\n" +
            "            transition: all 0.3s ease;\n" +
            "            text-decoration: none;\n" +
            "            display: inline-block;\n" +
            "        }\n" +
            "        .btn-secondary:hover {\n" +
            "            background: var(--primary-color);\n" +
            "            color: #000;\n" +
            "            transform: translateY(-3px);\n" +
            "        }\n" +
            "    </style>\n" +
            "</head>\n" +
            "<body>\n" +
            "    <div class=\"error-container\">\n" +
            "        <div class=\"error-icon\">\n" +
            "            <i class=\"bi bi-exclamation-triangle\"></i>\n" +
            "        </div>\n" +
            "        <h1>Error en el Registro</h1>\n" +
            "        <div class=\"error-message\">\n" +
            "            " + mensajeError + "\n" +
            "        </div>\n" +
            "        \n" +
            "        <div class=\"btn-container\">\n" +
            "            <a href=\"registro.jsp\" class=\"btn-primary\">\n" +
            "                <i class=\"bi bi-arrow-clockwise\"></i> Intentar Nuevamente\n" +
            "            </a>\n" +
            "            <a href=\"index.html\" class=\"btn-secondary\">\n" +
            "                <i class=\"bi bi-house\"></i> Ir al Inicio\n" +
            "            </a>\n" +
            "        </div>\n" +
            "    </div>\n" +
            "</body>\n" +
            "</html>";
        
        out.print(html);
    }
}
