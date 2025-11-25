package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;

@WebServlet("/CarritoServlet")
public class CarritoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.gson = new Gson();
    }

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/tienda_led", 
                "root", 
                "" // Tu password
            );
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver no encontrado", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            sendErrorResponse(response, "Usuario no autenticado");
            return;
        }

        Integer userId = (Integer) session.getAttribute("usuarioId");
        if (userId == null) {
            sendErrorResponse(response, "Usuario no autenticado");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = getConnection()) {
            switch (accion) {
                case "contar":
                    int totalItems = contarItemsCarrito(conn, userId);
                    out.print("{\"success\": true, \"totalItems\": " + totalItems + "}");
                    break;

                case "obtener":
                    // Obtener todos los items del carrito
                    String carritoJson = obtenerCarritoJSON(conn, userId);
                    out.print(carritoJson);
                    break;

                default:
                    sendErrorResponse(response, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error en el servidor: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            sendErrorResponse(response, "Usuario no autenticado");
            return;
        }

        Integer userId = (Integer) session.getAttribute("usuarioId");
        if (userId == null) {
            sendErrorResponse(response, "Usuario no autenticado");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = getConnection()) {
            switch (accion) {
                case "agregar":
                    agregarAlCarrito(conn, request, response, userId);
                    break;

                case "actualizar":
                    actualizarCantidad(conn, request, response, userId);
                    break;

                case "eliminar":
                    eliminarDelCarrito(conn, request, response, userId);
                    break;

                case "vaciar":
                    vaciarCarrito(conn, userId);
                    out.print("{\"success\": true, \"message\": \"Carrito vaciado\"}");
                    break;

                default:
                    sendErrorResponse(response, "Acción no válida");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error en el servidor: " + e.getMessage());
        }
    }

    private void agregarAlCarrito(Connection conn, HttpServletRequest request, 
                                 HttpServletResponse response, int userId) throws IOException {
        PrintWriter out = response.getWriter();
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            // Verificar stock disponible
            if (!verificarStock(conn, idProducto, cantidad)) {
                sendErrorResponse(response, "No hay suficiente stock disponible");
                return;
            }

            // Verificar si el usuario tiene un carrito activo
            int idCarrito = obtenerOCrearCarrito(conn, userId);

            // Verificar si el producto ya está en el carrito
            if (existeProductoEnCarrito(conn, idCarrito, idProducto)) {
                // Actualizar cantidad si ya existe
                actualizarCantidadItem(conn, idCarrito, idProducto, cantidad);
            } else {
                // Agregar nuevo item
                agregarItemCarrito(conn, idCarrito, idProducto, cantidad);
            }

            int totalItems = contarItemsCarrito(conn, userId);
            out.print("{\"success\": true, \"message\": \"Producto agregado al carrito\", \"totalItems\": " + totalItems + "}");

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Datos inválidos");
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error al agregar al carrito: " + e.getMessage());
        }
    }

    private boolean verificarStock(Connection conn, int idProducto, int cantidad) throws SQLException {
        String sql = "SELECT stock FROM productos WHERE id_producto = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idProducto);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int stock = rs.getInt("stock");
                return stock >= cantidad;
            }
        }
        return false;
    }

    private int obtenerOCrearCarrito(Connection conn, int userId) throws SQLException {
        String sql = "SELECT id_carrito FROM carritos WHERE id_usuario = ? AND estado = 'activo'";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("id_carrito");
            } else {
                // Crear nuevo carrito
                String insertSql = "INSERT INTO carritos (id_usuario, estado) VALUES (?, 'activo')";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.executeUpdate();
                    
                    ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        throw new SQLException("No se pudo crear o obtener el carrito");
    }

    private boolean existeProductoEnCarrito(Connection conn, int idCarrito, int idProducto) throws SQLException {
        String sql = "SELECT id_detalle FROM detalle_carrito WHERE id_carrito = ? AND id_producto = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idCarrito);
            stmt.setInt(2, idProducto);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    private void agregarItemCarrito(Connection conn, int idCarrito, int idProducto, int cantidad) throws SQLException {
        // Obtener el precio del producto
        String precioSql = "SELECT precio FROM productos WHERE id_producto = ?";
        double precio = 0;
        
        try (PreparedStatement precioStmt = conn.prepareStatement(precioSql)) {
            precioStmt.setInt(1, idProducto);
            ResultSet rs = precioStmt.executeQuery();
            if (rs.next()) {
                precio = rs.getDouble("precio");
            }
        }

        String sql = "INSERT INTO detalle_carrito (id_carrito, id_producto, cantidad, subtotal) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idCarrito);
            stmt.setInt(2, idProducto);
            stmt.setInt(3, cantidad);
            stmt.setDouble(4, precio * cantidad);
            stmt.executeUpdate();
        }
    }

    private void actualizarCantidadItem(Connection conn, int idCarrito, int idProducto, int cantidad) throws SQLException {
        // Obtener cantidad actual
        String selectSql = "SELECT cantidad FROM detalle_carrito WHERE id_carrito = ? AND id_producto = ?";
        int cantidadActual = 0;
        
        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            selectStmt.setInt(1, idCarrito);
            selectStmt.setInt(2, idProducto);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                cantidadActual = rs.getInt("cantidad");
            }
        }

        int nuevaCantidad = cantidadActual + cantidad;
        
        // Verificar stock nuevamente
        if (!verificarStock(conn, idProducto, nuevaCantidad)) {
            throw new SQLException("No puedes agregar más de " + (nuevaCantidad - cantidadActual) + " unidades");
        }

        // Obtener precio para calcular nuevo subtotal
        String precioSql = "SELECT precio FROM productos WHERE id_producto = ?";
        double precio = 0;
        
        try (PreparedStatement precioStmt = conn.prepareStatement(precioSql)) {
            precioStmt.setInt(1, idProducto);
            ResultSet rs = precioStmt.executeQuery();
            if (rs.next()) {
                precio = rs.getDouble("precio");
            }
        }

        String updateSql = "UPDATE detalle_carrito SET cantidad = ?, subtotal = ? WHERE id_carrito = ? AND id_producto = ?";
        
        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
            updateStmt.setInt(1, nuevaCantidad);
            updateStmt.setDouble(2, precio * nuevaCantidad);
            updateStmt.setInt(3, idCarrito);
            updateStmt.setInt(4, idProducto);
            updateStmt.executeUpdate();
        }
    }

    private void actualizarCantidad(Connection conn, HttpServletRequest request, 
                                   HttpServletResponse response, int userId) throws IOException {
        PrintWriter out = response.getWriter();
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));

            if (cantidad <= 0) {
                eliminarItemCarrito(conn, userId, idProducto);
            } else {
                // Verificar stock
                if (!verificarStock(conn, idProducto, cantidad)) {
                    sendErrorResponse(response, "No hay suficiente stock disponible");
                    return;
                }
                
                actualizarCantidadDirecta(conn, userId, idProducto, cantidad);
            }

            int totalItems = contarItemsCarrito(conn, userId);
            out.print("{\"success\": true, \"message\": \"Carrito actualizado\", \"totalItems\": " + totalItems + "}");

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error al actualizar carrito: " + e.getMessage());
        }
    }

    private void actualizarCantidadDirecta(Connection conn, int userId, int idProducto, int cantidad) throws SQLException {
        int idCarrito = obtenerOCrearCarrito(conn, userId);
        
        // Obtener precio
        String precioSql = "SELECT precio FROM productos WHERE id_producto = ?";
        double precio = 0;
        
        try (PreparedStatement precioStmt = conn.prepareStatement(precioSql)) {
            precioStmt.setInt(1, idProducto);
            ResultSet rs = precioStmt.executeQuery();
            if (rs.next()) {
                precio = rs.getDouble("precio");
            }
        }

        String updateSql = "UPDATE detalle_carrito SET cantidad = ?, subtotal = ? WHERE id_carrito = ? AND id_producto = ?";
        
        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
            updateStmt.setInt(1, cantidad);
            updateStmt.setDouble(2, precio * cantidad);
            updateStmt.setInt(3, idCarrito);
            updateStmt.setInt(4, idProducto);
            updateStmt.executeUpdate();
        }
    }

    private void eliminarDelCarrito(Connection conn, HttpServletRequest request, 
                                   HttpServletResponse response, int userId) throws IOException {
        PrintWriter out = response.getWriter();
        
        try {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            eliminarItemCarrito(conn, userId, idProducto);
            
            int totalItems = contarItemsCarrito(conn, userId);
            out.print("{\"success\": true, \"message\": \"Producto eliminado del carrito\", \"totalItems\": " + totalItems + "}");

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Error al eliminar del carrito: " + e.getMessage());
        }
    }

    private void eliminarItemCarrito(Connection conn, int userId, int idProducto) throws SQLException {
        int idCarrito = obtenerOCrearCarrito(conn, userId);
        
        String sql = "DELETE FROM detalle_carrito WHERE id_carrito = ? AND id_producto = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idCarrito);
            stmt.setInt(2, idProducto);
            stmt.executeUpdate();
        }
    }

    private void vaciarCarrito(Connection conn, int userId) throws SQLException {
        int idCarrito = obtenerOCrearCarrito(conn, userId);
        
        String sql = "DELETE FROM detalle_carrito WHERE id_carrito = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idCarrito);
            stmt.executeUpdate();
        }
    }

    private int contarItemsCarrito(Connection conn, int userId) throws SQLException {
        String sql = "SELECT SUM(dc.cantidad) as total " +
                    "FROM detalle_carrito dc " +
                    "JOIN carritos c ON dc.id_carrito = c.id_carrito " +
                    "WHERE c.id_usuario = ? AND c.estado = 'activo'";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    private String obtenerCarritoJSON(Connection conn, int userId) throws SQLException {
        String sql = "SELECT p.id_producto, p.nombre_producto, p.precio, dc.cantidad, dc.subtotal, p.imagen " +
                    "FROM detalle_carrito dc " +
                    "JOIN carritos c ON dc.id_carrito = c.id_carrito " +
                    "JOIN productos p ON dc.id_producto = p.id_producto " +
                    "WHERE c.id_usuario = ? AND c.estado = 'activo'";
        
        StringBuilder json = new StringBuilder();
        json.append("{\"success\": true, \"items\": [");
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                json.append("{")
                    .append("\"id_producto\": ").append(rs.getInt("id_producto")).append(",")
                    .append("\"nombre\": \"").append(rs.getString("nombre_producto")).append("\",")
                    .append("\"precio\": ").append(rs.getDouble("precio")).append(",")
                    .append("\"cantidad\": ").append(rs.getInt("cantidad")).append(",")
                    .append("\"subtotal\": ").append(rs.getDouble("subtotal"))
                    .append("}");
                first = false;
            }
        }
        
        json.append("]}");
        return json.toString();
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": false, \"error\": \"" + message + "\"}");
    }
}