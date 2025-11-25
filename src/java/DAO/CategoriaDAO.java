package DAO;

import Modelo.Categoria;
import DAO.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {
    Conexion conexion = new Conexion();
    private Connection connection = conexion.getConexion();

    
    

    public List<Categoria> obtenerTodasLasCategorias() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias ORDER BY nombre_categoria";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("id_categoria"));
                categoria.setNombre_categoria(rs.getString("nombre_categoria"));
                categoria.setDescripcion(rs.getString("descripcion"));
                categorias.add(categoria);
            }
        }
        return categorias;
    }

    public boolean insertarCategoria(Categoria categoria) throws SQLException {
        String sql = "INSERT INTO categorias (nombre_categoria, descripcion) VALUES (?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, categoria.getNombre_categoria());
            stmt.setString(2, categoria.getDescripcion());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean actualizarCategoria(Categoria categoria) throws SQLException {
        String sql = "UPDATE categorias SET nombre_categoria = ?, descripcion = ? WHERE id_categoria = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, categoria.getNombre_categoria());
            stmt.setString(2, categoria.getDescripcion());
            stmt.setInt(3, categoria.getId_categoria());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarCategoria(int id) throws SQLException {
        // Verificar si hay productos usando esta categoría
        String checkSql = "SELECT COUNT(*) FROM productos WHERE id_categoria = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, id);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // No se puede eliminar, hay productos asociados
                }
            }
        }
        
        String sql = "DELETE FROM categorias WHERE id_categoria = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}