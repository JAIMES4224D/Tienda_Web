/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.Conexion;
import Modelo.ContactData;
import com.google.gson.Gson;
import com.mysql.cj.xdevapi.PreparableStatement;
import java.sql.CallableStatement;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JEJALUOS
 */
@WebServlet(name = "MensajesWeb", urlPatterns = {"/MensajesWeb"})
public class MensajesWeb extends HttpServlet {
Conexion c = new Conexion();
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
        // Establece el tipo de contenido que esperas recibir
        request.setCharacterEncoding("UTF-8");

        // Lee el JSON del cuerpo de la solicitud
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }
        String jsonReceived = jsonBuilder.toString();

        // Si usas la librería Gson, puedes convertir el JSON a un objeto Java
        Gson gson = new Gson();
        ContactData contactData = gson.fromJson(jsonReceived, ContactData.class);
        System.out.println("nombre" + contactData.getName());
        System.out.println("phone" + contactData.getPhone());
        String sql = "CALL insertar_mensajes_web(?,?,?,?,?);";
        Connection cn = null;
        CallableStatement cs = null;

        boolean success = false;

        try {
            cn = c.getConexion();
            cs = (CallableStatement) cn.prepareCall(sql);

            cs.setString(1, contactData.getName());
            cs.setString(2, contactData.getEmail());
            cs.setString(3, contactData.getPhone());
            cs.setString(4, contactData.getSubject());
            cs.setString(5, contactData.getMessage());

            cs.execute();
            System.out.println("Mensaje insertado mediante procedimiento almacenado.");
            success = true;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error de base de datos: " + e.getMessage());
            success = false;
        } finally {
            try {
                if (cs != null) cs.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Preparar y enviar la respuesta al cliente (navegador)
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (success) {
            // Crear respuesta HTML con el estilo de DonGlai
            String htmlResponse = createSuccessHTML(contactData.getName());
            out.print(htmlResponse);
        } else {
            // Crear respuesta de error
            String htmlError = createErrorHTML();
            out.print(htmlError);
        }

        out.flush();
    }

    private String createSuccessHTML(String userName) {
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "<meta charset='UTF-8'>" +
               "<style>" +
               "body {" +
               "    font-family: 'Poppins', sans-serif;" +
               "    background: linear-gradient(135deg, #0d0d0d 0%, #1a1a1a 100%);" +
               "    color: #fff;" +
               "    margin: 0;" +
               "    padding: 0;" +
               "    display: flex;" +
               "    justify-content: center;" +
               "    align-items: center;" +
               "    min-height: 100vh;" +
               "}" +
               ".success-card {" +
               "    background: linear-gradient(145deg, #1a1a1a, #222);" +
               "    border-radius: 20px;" +
               "    padding: 50px 40px;" +
               "    text-align: center;" +
               "    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);" +
               "    border-top: 5px solid #00e0ff;" +
               "    border-left: 5px solid #00e0ff;" +
               "    max-width: 500px;" +
               "    width: 90%;" +
               "    position: relative;" +
               "    overflow: hidden;" +
               "}" +
               ".success-card::before {" +
               "    content: '';" +
               "    position: absolute;" +
               "    top: 0;" +
               "    left: 0;" +
               "    width: 100%;" +
               "    height: 100%;" +
               "    background: linear-gradient(135deg, rgba(0, 224, 255, 0.05) 0%, transparent 50%);" +
               "    z-index: 1;" +
               "}" +
               ".success-icon {" +
               "    font-size: 5rem;" +
               "    color: #00e0ff;" +
               "    margin-bottom: 20px;" +
               "    text-shadow: 0 0 20px rgba(0, 224, 255, 0.7);" +
               "    animation: pulse 2s infinite;" +
               "}" +
               "@keyframes pulse {" +
               "    0%, 100% { transform: scale(1); }" +
               "    50% { transform: scale(1.1); }" +
               "}" +
               ".success-title {" +
               "    color: #00e0ff;" +
               "    font-size: 2rem;" +
               "    font-weight: 700;" +
               "    margin-bottom: 15px;" +
               "    text-shadow: 0 0 10px rgba(0, 224, 255, 0.5);" +
               "}" +
               ".success-message {" +
               "    color: #ddd;" +
               "    font-size: 1.2rem;" +
               "    line-height: 1.6;" +
               "    margin-bottom: 25px;" +
               "}" +
               ".user-name {" +
               "    color: #00e0ff;" +
               "    font-weight: 700;" +
               "}" +
               ".success-details {" +
               "    background: rgba(0, 224, 255, 0.1);" +
               "    border-radius: 10px;" +
               "    padding: 15px;" +
               "    margin: 20px 0;" +
               "    border-left: 3px solid #00e0ff;" +
               "}" +
               ".detail-item {" +
               "    color: #ccc;" +
               "    margin: 8px 0;" +
               "    font-size: 0.95rem;" +
               "}" +
               ".btn-close {" +
               "    background: linear-gradient(135deg, #00e0ff, #00a2ff);" +
               "    border: none;" +
               "    color: #000;" +
               "    font-weight: 700;" +
               "    border-radius: 30px;" +
               "    padding: 12px 30px;" +
               "    font-size: 1rem;" +
               "    cursor: pointer;" +
               "    transition: all 0.3s ease;" +
               "    margin-top: 15px;" +
               "    box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);" +
               "}" +
               ".btn-close:hover {" +
               "    transform: scale(1.05);" +
               "    box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);" +
               "}" +
               ".led-effect {" +
               "    position: absolute;" +
               "    top: 0;" +
               "    left: -100%;" +
               "    width: 100%;" +
               "    height: 100%;" +
               "    background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.1), transparent);" +
               "    animation: ledSlide 3s infinite;" +
               "}" +
               "@keyframes ledSlide {" +
               "    0% { left: -100%; }" +
               "    100% { left: 100%; }" +
               "}" +
               "</style>" +
               "</head>" +
               "<body>" +
               "<div class='success-card'>" +
               "    <div class='led-effect'></div>" +
               "    <div class='success-icon'>✅</div>" +
               "    <h1 class='success-title'>¡Mensaje Enviado!</h1>" +
               "    <p class='success-message'>Hola <span class='user-name'>" + userName + "</span>, hemos recibido tu mensaje correctamente.</p>" +
               "    <div class='success-details'>" +
               "        <div class='detail-item'>✅ Mensaje guardado en nuestra base de datos</div>" +
               "        <div class='detail-item'>📧 Te contactaremos en menos de 24 horas</div>" +
               "        <div class='detail-item'>⏰ Horario de respuesta: Lunes a Viernes 9:00 AM - 7:00 PM</div>" +
               "    </div>" +
               "    <p class='success-message'>Gracias por contactarte con <strong>DonGlai</strong>. En un momento nos comunicaremos contigo.</p>" +
               "    <button class='btn-close' onclick='window.close()'>Cerrar esta ventana</button>" +
               "</div>" +
               "<script>" +
               "setTimeout(function() {" +
               "    document.querySelector('.success-card').style.transform = 'translateY(-10px)';" +
               "    document.querySelector('.success-card').style.boxShadow = '0 20px 40px rgba(0, 224, 255, 0.3)';" +
               "}, 100);" +
               "</script>" +
               "</body>" +
               "</html>";
    }

    private String createErrorHTML() {
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "<meta charset='UTF-8'>" +
               "<style>" +
               "body {" +
               "    font-family: 'Poppins', sans-serif;" +
               "    background: linear-gradient(135deg, #0d0d0d 0%, #1a1a1a 100%);" +
               "    color: #fff;" +
               "    margin: 0;" +
               "    padding: 0;" +
               "    display: flex;" +
               "    justify-content: center;" +
               "    align-items: center;" +
               "    min-height: 100vh;" +
               "}" +
               ".error-card {" +
               "    background: linear-gradient(145deg, #1a1a1a, #222);" +
               "    border-radius: 20px;" +
               "    padding: 50px 40px;" +
               "    text-align: center;" +
               "    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);" +
               "    border-top: 5px solid #ff4444;" +
               "    border-left: 5px solid #ff4444;" +
               "    max-width: 500px;" +
               "    width: 90%;" +
               "}" +
               ".error-icon {" +
               "    font-size: 5rem;" +
               "    color: #ff4444;" +
               "    margin-bottom: 20px;" +
               "}" +
               ".error-title {" +
               "    color: #ff4444;" +
               "    font-size: 2rem;" +
               "    font-weight: 700;" +
               "    margin-bottom: 15px;" +
               "}" +
               ".error-message {" +
               "    color: #ddd;" +
               "    font-size: 1.2rem;" +
               "    line-height: 1.6;" +
               "    margin-bottom: 25px;" +
               "}" +
               ".btn-retry {" +
               "    background: linear-gradient(135deg, #ff4444, #ff6666);" +
               "    border: none;" +
               "    color: #fff;" +
               "    font-weight: 700;" +
               "    border-radius: 30px;" +
               "    padding: 12px 30px;" +
               "    font-size: 1rem;" +
               "    cursor: pointer;" +
               "    transition: all 0.3s ease;" +
               "    margin-top: 15px;" +
               "}" +
               ".btn-retry:hover {" +
               "    transform: scale(1.05);" +
               "}" +
               "</style>" +
               "</head>" +
               "<body>" +
               "<div class='error-card'>" +
               "    <div class='error-icon'>❌</div>" +
               "    <h1 class='error-title'>Error al Enviar</h1>" +
               "    <p class='error-message'>Lo sentimos, ha ocurrido un error al procesar tu mensaje.</p>" +
               "    <p class='error-message'>Por favor, intenta nuevamente o contacta directamente a:</p>" +
               "    <p class='error-message'><strong>contacto@donglai.com</strong></p>" +
               "    <button class='btn-retry' onclick='history.back()'>Volver e Intentar</button>" +
               "</div>" +
               "</body>" +
               "</html>";
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

}
