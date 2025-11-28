/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jeferson
 */
@WebServlet(name = "cambiarEstadoPedido", urlPatterns = {"/cambiarEstadoPedido"})
public class cambiarEstadoPedido extends HttpServlet {

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
        cambiarEstadoPedido(request, response);
    }

    private void cambiarEstadoPedido(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            // Obtener parámetros con validación
            String idPedidoStr = request.getParameter("idPedido");
            String nuevoEstado = request.getParameter("nuevoEstado");
            
            System.out.println("ID Pedido recibido: '" + idPedidoStr + "'");
            System.out.println("Nuevo Estado recibido: '" + nuevoEstado + "'");
            
            // Validar que los parámetros no estén vacíos
            if (idPedidoStr == null || idPedidoStr.trim().isEmpty()) {
                request.getSession().setAttribute("mensaje", "Error: ID de pedido no válido");
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("AdminController?acc=pedidos");
                return;
            }
            
            if (nuevoEstado == null || nuevoEstado.trim().isEmpty()) {
                request.getSession().setAttribute("mensaje", "Error: Estado no válido");
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("AdminController?acc=pedidos");
                return;
            }
            
            int idPedido = Integer.parseInt(idPedidoStr.trim());
            
            // Validar que el estado sea válido para el ENUM
            if (!esEstadoValido(nuevoEstado)) {
                request.getSession().setAttribute("mensaje", "Estado inválido: " + nuevoEstado);
                request.getSession().setAttribute("tipoMensaje", "error");
                response.sendRedirect("AdminController?acc=pedidos");
                return;
            }
            
            // Aquí llamas a tu DAO para actualizar el estado
            boolean actualizado = actualizarEstadoPedido(idPedido, nuevoEstado);
            
            if (actualizado) {
                request.getSession().setAttribute("mensaje", "Estado del pedido #" + idPedido + " actualizado correctamente a: " + nuevoEstado);
                request.getSession().setAttribute("tipoMensaje", "success");
                System.out.println("Pedido " + idPedido + " actualizado a: " + nuevoEstado);
            } else {
                request.getSession().setAttribute("mensaje", "Error al actualizar el estado del pedido #" + idPedido);
                request.getSession().setAttribute("tipoMensaje", "error");
                System.out.println("Error al actualizar pedido " + idPedido);
            }
            
            // Redirigir de vuelta a la página de pedidos
            response.sendRedirect("AdminController?acc=pedidos");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("mensaje", "Error: ID de pedido no válido");
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("AdminController?acc=pedidos");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
            request.getSession().setAttribute("tipoMensaje", "error");
            response.sendRedirect("AdminController?acc=pedidos");
        }
    }

    private boolean esEstadoValido(String estado) {
        // Validar contra los valores del ENUM de tu tabla
        String[] estadosValidos = {"pendiente", "pagado", "enviado", "entregado", "cancelado"};
        for (String estadoValido : estadosValidos) {
            if (estadoValido.equalsIgnoreCase(estado.trim())) {
                return true;
            }
        }
        return false;
    }

    private boolean actualizarEstadoPedido(int idPedido, String nuevoEstado) {
        // Implementar la lógica de actualización en la base de datos
        String sql = "UPDATE pedidos SET estado = ? WHERE id_pedido = ?";
        Conexion c = new Conexion();
        try (Connection conn = c.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, nuevoEstado.toLowerCase().trim()); // Asegurar minúsculas y quitar espacios
            stmt.setInt(2, idPedido);
            
            int filasAfectadas = stmt.executeUpdate();
            System.out.println("Filas afectadas: " + filasAfectadas);
            
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error SQL: " + e.getMessage());
            return false;
        }
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