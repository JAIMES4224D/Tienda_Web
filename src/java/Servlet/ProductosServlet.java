/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.ProductoDAO;
import Modelo.Producto;
import Modelo.ProductoDTO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
@WebServlet(name = "ProductosServlet", urlPatterns = {"/ProductosServlet"})
public class ProductosServlet extends HttpServlet {
ProductoDAO pd = new ProductoDAO();
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
    
    response.setContentType("application/json;charset=UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    PrintWriter out = response.getWriter();
    
    try {
        // Obtener productos de la base de datos
        List<Producto> productos = pd.obtenerProductosConCategorias();
        
        // Convertir a ProductoDTO para incluir imagen en Base64
        List<ProductoDTO> productosDTO = new ArrayList<>();
        for (Producto producto : productos) {
            productosDTO.add(new ProductoDTO(producto));
        }
        
        System.out.println("✅ Productos encontrados: " + productosDTO.size());
        
        // Convertir a JSON y enviar respuesta
        Gson gson = new Gson();
        String json = gson.toJson(productosDTO);
        
        out.write(json);
        
    } catch (Exception e) {
        System.err.println("❌ Error en ProductosServlet: " + e.getMessage());
        e.printStackTrace();
        
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        out.write("{\"error\": \"Error al cargar productos\"}");
    } finally {
        out.flush();
        out.close();
    }
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
