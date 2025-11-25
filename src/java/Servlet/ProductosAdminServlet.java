package Servlet;

import DAO.ProductoDAO;
import Modelo.Producto;
import Modelo.Productos;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductosAdminServlet")
public class ProductosAdminServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        productoDAO = new ProductoDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String accion = request.getParameter("accion");
            
            if ("obtenerTodos".equals(accion)) {
                List<Productos> productos = productoDAO.obtenerTodosLosProductos();
                out.print(gson.toJson(productos));
            } else if ("obtenerPorId".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Producto producto = productoDAO.obtenerProductoPorId(id);
                out.print(gson.toJson(producto));
            } else {
                // Por defecto, obtener todos
                List<Productos> productos = productoDAO.obtenerTodosLosProductos();
                out.print(gson.toJson(productos));
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Error al obtener productos: " + e.getMessage() + "\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String accion = request.getParameter("accion");
            
            if ("agregar".equals(accion)) {
                Productos producto = new Productos();
                producto.setNombreProducto(request.getParameter("nombre"));
                producto.setDescripcion(request.getParameter("descripcion"));
                producto.setPrecio(new BigDecimal(request.getParameter("precio")));
                producto.setStock(Integer.parseInt(request.getParameter("stock")));
                producto.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));
                
                boolean resultado = productoDAO.insertarProducto(producto);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Producto agregado correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al agregar producto\"}");
                }
                
            } else if ("editar".equals(accion)) {
                Productos producto = new Productos();
                producto.setIdProducto(Integer.parseInt(request.getParameter("id")));
                producto.setNombreProducto(request.getParameter("nombre"));
                producto.setDescripcion(request.getParameter("descripcion"));
                producto.setPrecio(new BigDecimal(request.getParameter("precio")));
                producto.setStock(Integer.parseInt(request.getParameter("stock")));
                producto.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));
                
                boolean resultado = productoDAO.actualizarProducto(producto);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Producto actualizado correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al actualizar producto\"}");
                }
                
            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean resultado = productoDAO.eliminarProducto(id);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Producto eliminado correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al eliminar producto\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}