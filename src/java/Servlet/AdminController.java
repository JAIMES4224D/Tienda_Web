/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.AdminDAO;
import DAO.ContDAO;
import Modelo.Categoria;
import Modelo.ContactData;
import Modelo.Productoss;
import Modelo.Proveedores;
import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jeferson
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

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
        String acc = request.getParameter("acc");
        AdminDAO ad = new AdminDAO();
        
        if(acc.equals("productos")){
            // 1. Obtener los datos del DAO
            int productos = ad.contarProductos();
            int productosActivos = ad.contarProductosActivos();
            int stockBajo = ad.contarStockBajo();
            int categorias = ad.contarCategorias();
            List<Categoria> listaCategorias = ad.listarCategorias();
            List<Productoss> listaProductos = ad.listarProductos();

            // 2. GUARDAR los datos en el "request" (como si fuera una mochila)
            request.setAttribute("nroProductos", productos);
            request.setAttribute("nroActivos", productosActivos);
            request.setAttribute("nroStockBajo", stockBajo);
            request.setAttribute("nroCategorias", categorias);

            // Guardamos las listas
            request.setAttribute("listaCategorias", listaCategorias);
            request.setAttribute("listaProductos", listaProductos);

            // 3. ENVIAR (Forward) al JSP sin perder los datos
            request.getRequestDispatcher("Productos.jsp").forward(request, response);
        }
        
        if(acc.equals("categorias")){
            int categorias = ad.contarCategoria(); // 1 y 2 
            List<Categoria> listaCategorias = ad.listarCategorias();
            
            request.setAttribute("nroCategorias", categorias);
            request.setAttribute("listaCategorias", listaCategorias);
            
            request.getRequestDispatcher("Categorias.jsp").forward(request, response);
        }
        
        if(acc.equals("usuarios")){
            ContDAO cd = new ContDAO();
            int totalUsuarios = ad.totalUsuarios();
            int administradores = cd.contarAdmin();
            int clientes = ad.totalClientes();
            List<Usuario> listaUsuario = ad.listarUsuarios();
            request.setAttribute("totalUsuarios", totalUsuarios);
            request.setAttribute("administradores", administradores);
            request.setAttribute("clientes", clientes);
            request.setAttribute("listaUsuario", listaUsuario);
            request.getRequestDispatcher("Usuarios.jsp").forward(request, response);
        }
        
        if(acc.equals("admin")){
            ContDAO cd = new ContDAO();
            int administradores = cd.contarAdmin();
            List<Usuario> admins = ad.listarAdministradores();
            request.setAttribute("administradores", administradores);
            request.setAttribute("admins", admins);
            request.getRequestDispatcher("Admin.jsp").forward(request, response);
            
        }
        
        if(acc.equals("mensajesWeb")){
            int cantidadMensajes = ad.cantidadMensajes();
            int mensajesLeidos = ad.cantidadMensajesPendientes();
            int mensajesNoLeidos = ad.cantidadMensajesLeidos();
            List<ContactData> lista = ad.listarMensajes();
            request.setAttribute("cantidadMensajes", cantidadMensajes);
            request.setAttribute("mensajesLeidos", mensajesLeidos);
            request.setAttribute("mensajesNoLeidos", mensajesNoLeidos);
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("MensajesWeb.jsp").forward(request, response);
        }
        
        if(acc.equals("proveedores")){
            Random random = new Random();
            int totalProveedores = ad.totalProveedores(); //proovedores activos  = 
            int paisesCubiertos = random.nextInt(50)+10;
            int productosSuministrados = ad.contarProductos();
            List<Proveedores> lista = ad.listarProveedores();
            request.setAttribute("totalProveedores", totalProveedores);
            request.setAttribute("paisesCubiertos", paisesCubiertos);
            request.setAttribute("productosSuministrados", productosSuministrados);
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("Proveedores.jsp").forward(request, response);
        }
        
        if(acc.equals("reportes")){
            
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
