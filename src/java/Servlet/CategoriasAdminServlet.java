package Servlet;

import DAO.CategoriaDAO;
import Modelo.Categoria;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CategoriasAdminServlet")
public class CategoriasAdminServlet extends HttpServlet {
    private CategoriaDAO categoriaDAO;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        categoriaDAO = new CategoriaDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            List<Categoria> categorias = categoriaDAO.obtenerTodasLasCategorias();
            out.print(gson.toJson(categorias));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"Error al obtener categorías: " + e.getMessage() + "\"}");
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
                Categoria categoria = new Categoria();
                categoria.setNombre_categoria(request.getParameter("nombre"));
                categoria.setDescripcion(request.getParameter("descripcion"));
                
                boolean resultado = categoriaDAO.insertarCategoria(categoria);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Categoría agregada correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al agregar categoría\"}");
                }
                
            } else if ("editar".equals(accion)) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(Integer.parseInt(request.getParameter("id")));
                categoria.setNombre_categoria(request.getParameter("nombre"));
                categoria.setDescripcion(request.getParameter("descripcion"));
                
                boolean resultado = categoriaDAO.actualizarCategoria(categoria);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Categoría actualizada correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al actualizar categoría\"}");
                }
                
            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean resultado = categoriaDAO.eliminarCategoria(id);
                if (resultado) {
                    out.print("{\"success\": true, \"message\": \"Categoría eliminada correctamente\"}");
                } else {
                    out.print("{\"success\": false, \"error\": \"Error al eliminar categoría\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\": false, \"error\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}