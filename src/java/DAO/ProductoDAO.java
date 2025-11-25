/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import Modelo.Producto;
import Modelo.Productos;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ProductoDAO {
    private Conexion conexion = new Conexion();
    
    // Procedimiento almacenado: obtener_productos_con_categorias()
    public List<Producto> obtenerProductosConCategorias() {
        List<Producto> productos = new ArrayList<>();
        Connection cn = null;
        CallableStatement ct = null;
        ResultSet rs = null;
        
        try {
            System.out.println("=== INICIO OBTENER PRODUCTOS CON CATEGORIAS ===");
            
            cn = conexion.getConexion();
            String sql = "{CALL obtener_productos_con_categorias()}";
            System.out.println("Ejecutando procedimiento: " + sql);
            
            ct = cn.prepareCall(sql);
            rs = ct.executeQuery();
            
            while (rs.next()) {
                Producto producto = mapearProductoDesdeResultSet(rs);
                productos.add(producto);
                
                System.out.println("Producto encontrado: " + producto.getNombre_producto() + 
                                 " - Categoría: " + producto.getNombre_categoria());
            }
            
            System.out.println("Total productos obtenidos: " + productos.size());
            
        } catch (SQLException e) {
            System.err.println("Error SQL en obtenerProductosConCategorias: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error inesperado en obtenerProductosConCategorias: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(rs, ct, cn);
            System.out.println("=== FIN OBTENER PRODUCTOS CON CATEGORIAS ===\n");
        }
        
        return productos;
    }
    
    // Procedimiento almacenado: obtener_productos_por_categoria
    public List<Producto> obtenerProductosPorCategoria(int idCategoria) {
        List<Producto> productos = new ArrayList<>();
        Connection cn = null;
        CallableStatement ct = null;
        ResultSet rs = null;
        
        try {
            System.out.println("=== INICIO OBTENER PRODUCTOS POR CATEGORIA ===");
            System.out.println("ID Categoría: " + idCategoria);
            
            cn = conexion.getConexion();
            String sql = "{CALL obtener_productos_por_categoria(?)}";
            ct = cn.prepareCall(sql);
            ct.setInt(1, idCategoria);
            
            rs = ct.executeQuery();
            
            while (rs.next()) {
                Producto producto = mapearProductoDesdeResultSet(rs);
                productos.add(producto);
                
                System.out.println("Producto encontrado: " + producto.getNombre_producto());
            }
            
            System.out.println("Total productos obtenidos para categoría " + idCategoria + ": " + productos.size());
            
        } catch (SQLException e) {
            System.err.println("Error SQL en obtenerProductosPorCategoria: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(rs, ct, cn);
            System.out.println("=== FIN OBTENER PRODUCTOS POR CATEGORIA ===\n");
        }
        
        return productos;
    }
    
    // Procedimiento almacenado: buscar_productos_por_nombre
    public List<Producto> buscarProductosPorNombre(String nombre) {
        List<Producto> productos = new ArrayList<>();
        Connection cn = null;
        CallableStatement ct = null;
        ResultSet rs = null;
        
        try {
            System.out.println("=== INICIO BUSCAR PRODUCTOS POR NOMBRE ===");
            System.out.println("Término de búsqueda: " + nombre);
            
            cn = conexion.getConexion();
            String sql = "{CALL buscar_productos_por_nombre(?)}";
            ct = cn.prepareCall(sql);
            ct.setString(1, "%" + nombre + "%");
            
            rs = ct.executeQuery();
            
            while (rs.next()) {
                Producto producto = mapearProductoDesdeResultSet(rs);
                productos.add(producto);
                
                System.out.println("Producto encontrado: " + producto.getNombre_producto());
            }
            
            System.out.println("Total productos encontrados: " + productos.size());
            
        } catch (SQLException e) {
            System.err.println("Error SQL en buscarProductosPorNombre: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(rs, ct, cn);
            System.out.println("=== FIN BUSCAR PRODUCTOS POR NOMBRE ===\n");
        }
        
        return productos;
    }
    
    // Procedimiento almacenado: obtener_producto_por_id
    public Producto obtenerProductoPorId(int idProducto) {
        Producto producto = null;
        Connection cn = null;
        CallableStatement ct = null;
        ResultSet rs = null;
        
        try {
            System.out.println("=== INICIO OBTENER PRODUCTO POR ID ===");
            System.out.println("ID Producto: " + idProducto);
            
            cn = conexion.getConexion();
            String sql = "{CALL obtener_producto_por_id(?)}";
            ct = cn.prepareCall(sql);
            ct.setInt(1, idProducto);
            
            rs = ct.executeQuery();
            
            if (rs.next()) {
                producto = mapearProductoDesdeResultSet(rs);
                System.out.println("Producto encontrado: " + producto.getNombre_producto());
            } else {
                System.out.println("No se encontró producto con ID: " + idProducto);
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL en obtenerProductoPorId: " + e.getMessage());
            e.printStackTrace();
        } finally {
            cerrarRecursos(rs, ct, cn);
            System.out.println("=== FIN OBTENER PRODUCTO POR ID ===\n");
        }
        
        return producto;
    }
    
    // Método auxiliar para mapear ResultSet a Producto
    private Producto mapearProductoDesdeResultSet(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        
        producto.setId_producto(rs.getInt("id_producto"));
        producto.setNombre_producto(rs.getString("nombre_producto"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setPrecio(rs.getDouble("precio"));
        producto.setStock(rs.getInt("stock"));
        producto.setId_categoria(rs.getInt("id_categoria"));
        producto.setFecha_registro(rs.getTimestamp("fecha_registro"));
        producto.setNombre_categoria(rs.getString("nombre_categoria"));
        
        // Manejar la imagen (BLOB)
        Blob imagenBlob = rs.getBlob("imagen");
        if (imagenBlob != null) {
            producto.setImagen(imagenBlob.getBytes(1, (int) imagenBlob.length()));
        }
        
        return producto;
    }
    
    
    
     public List<Productos> obtenerTodosLosProductos() throws SQLException {
        List<Productos> productos = new ArrayList<>();
        String sql = "SELECT p.*, c.nombre_categoria FROM productos p " +
                    "LEFT JOIN categorias c ON p.id_categoria = c.id_categoria " +
                    "ORDER BY p.id_producto";

        Connection connection = conexion.getConexion();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Productos producto = new Productos();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombreProducto(rs.getString("nombre_producto"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getBigDecimal("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setIdCategoria(rs.getInt("id_categoria"));
                producto.setNombreCategoria(rs.getString("nombre_categoria"));
                
                // Convertir imagen a Base64 si existe
                byte[] imagenBytes = rs.getBytes("imagen");
                if (imagenBytes != null && imagenBytes.length > 0) {
                    String imagenBase64 = Base64.getEncoder().encodeToString(imagenBytes);
                    producto.setImagenBase64(imagenBase64);
                }
                
                productos.add(producto);
            }
        }
        return productos;
    }

    /**
     *
     * @param id
     * @return
     * @throws SQLException
     */
    public Productos obtenerProductosPorId(int id) throws SQLException {
            String sql = "SELECT p.*, c.nombre_categoria FROM productos p " +
                        "LEFT JOIN categorias c ON p.id_categoria = c.id_categoria " +
                        "WHERE p.id_producto = ?";
            Conexion conexion = new Conexion();
            
            try (Connection connection = conexion.getConexion();  // Método estático
                 PreparedStatement stmt = connection.prepareStatement(sql)) {

                stmt.setInt(1, id);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        Productos producto = new Productos();
                        producto.setIdProducto(rs.getInt("id_producto"));
                        producto.setNombreProducto(rs.getString("nombre_producto"));
                        producto.setDescripcion(rs.getString("descripcion"));
                        producto.setPrecio(rs.getBigDecimal("precio"));
                        producto.setStock(rs.getInt("stock"));
                        producto.setIdCategoria(rs.getInt("id_categoria"));
                        producto.setNombreCategoria(rs.getString("nombre_categoria"));

                        byte[] imagenBytes = rs.getBytes("imagen");
                        if (imagenBytes != null && imagenBytes.length > 0) {
                            String imagenBase64 = Base64.getEncoder().encodeToString(imagenBytes);
                            producto.setImagenBase64(imagenBase64);
                        }

                        return producto;
                    }
                }
            }
            return null;
        }

    public boolean insertarProducto(Productos producto) throws SQLException {
        String sql = "INSERT INTO productos (nombre_producto, descripcion, precio, stock, id_categoria, imagen) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, producto.getNombreProducto());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setInt(5, producto.getIdCategoria());
            
            // Manejar imagen (por ahora null, puedes implementarlo después)
            stmt.setBytes(6, null);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean actualizarProducto(Productos producto) throws SQLException {
        String sql = "UPDATE productos SET nombre_producto = ?, descripcion = ?, precio = ?, " +
                    "stock = ?, id_categoria = ? WHERE id_producto = ?";
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, producto.getNombreProducto());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setInt(5, producto.getIdCategoria());
            stmt.setInt(6, producto.getIdProducto());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarProducto(int id) throws SQLException {
        String sql = "DELETE FROM productos WHERE id_producto = ?";
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    // Método para cerrar recursos - CORREGIDO para incluir Connection
    private void cerrarRecursos(ResultSet rs, CallableStatement ct, Connection cn) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error cerrando ResultSet: " + e.getMessage());
        }
        
        try {
            if (ct != null) {
                ct.close();
            }
        } catch (SQLException e) {
            System.err.println("Error cerrando CallableStatement: " + e.getMessage());
        }
        
        try {
            if (cn != null && !cn.isClosed()) {
                cn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error cerrando Connection: " + e.getMessage());
        }
    }
}