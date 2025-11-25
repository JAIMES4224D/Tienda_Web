/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import DAO.Conexion;
import Modelo.Usuario;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.Part;
/**
 *
 * @author JEJALUOS
 */
public class UsuarioDAO {
    Conexion c = new Conexion();
    public Connection cn = c.getConexion();
    public CallableStatement ct = null;
    public ResultSet rs = null;
    
    public boolean registrarCliente(String nombre, String apellido, String correo, String contrasena, String telefono, String direccion, InputStream foto, String rol) {
        boolean flag = false;
        
        try {
            // Llamar al procedimiento almacenado
            String sql = "{CALL insertar_usuario(?, ?, ?, ?, ?, ?, ?, ?)}";
            ct = cn.prepareCall(sql);
            
            // Establecer parámetros
            ct.setString(1, nombre);
            ct.setString(2, apellido);
            ct.setString(3, correo);
            
            // Encriptar contraseña antes de guardar
            String contrasenaEncriptada = hashPassword(contrasena);
            ct.setString(4, contrasenaEncriptada);
            
            // Manejar parámetros opcionales (telefono y direccion)
            if (telefono != null && !telefono.trim().isEmpty()) {
                ct.setString(5, telefono);
            } else {
                ct.setNull(5, java.sql.Types.VARCHAR);
            }
            
            if (direccion != null && !direccion.trim().isEmpty()) {
                ct.setString(6, direccion);
            } else {
                ct.setNull(6, java.sql.Types.VARCHAR);
            }
            
            // Manejar la foto (BLOB)
            if (foto != null) {
                ct.setBlob(7, foto);
            } else {
                ct.setNull(7, java.sql.Types.BLOB);
            }
            
            // Establecer rol (si es null, el procedimiento usará 'cliente' por defecto)
            if (rol != null && !rol.trim().isEmpty()) {
                ct.setString(8, rol);
            } else {
                ct.setString(8, "cliente");
            }
            
            // Ejecutar el procedimiento
            int filasAfectadas = ct.executeUpdate();
            flag = (filasAfectadas > 0);
            
        } catch (SQLException e) {
            System.err.println("Error en registrarCliente: " + e.getMessage());
            e.printStackTrace();
            flag = false;
        } finally {
            // Cerrar recursos
            cerrarRecursos();
        }
        
        return flag;
    }
    
    // Método para encriptar contraseña
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al encriptar contraseña", e);
        }
    }
    

    
    
    
    public Usuario buscarPorCorreo(String correo) {
        Usuario usuario = null;

        try {
            // Llamar al procedimiento almacenado
            String sql = "{CALL buscar_usuario_por_correo(?)}";
            ct = cn.prepareCall(sql);

            // Establecer parámetro
            ct.setString(1, correo);

            // Ejecutar y obtener resultados
            rs = ct.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setContrasena(rs.getString("contrasena"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setDireccion(rs.getString("direccion"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFecha_registro(rs.getTimestamp("fecha_registro"));

                // Manejar la foto (BLOB)
                Blob fotoBlob = rs.getBlob("foto");
                if (fotoBlob != null) {
                    usuario.setFoto(fotoBlob.getBytes(1, (int) fotoBlob.length()));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error en buscarPorCorreo: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            cerrarRecursos();
        }

        return usuario;
    }
    public List<Usuario> obtenerTodosLosUsuarios() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY fecha_registro DESC";
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setDireccion(rs.getString("direccion"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFecha_registro(rs.getTimestamp("fecha_registro"));
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    public List<Usuario> obtenerClientes() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE rol = 'cliente' ORDER BY fecha_registro DESC";
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setDireccion(rs.getString("direccion"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFecha_registro(rs.getTimestamp("fecha_registro"));
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    public List<Usuario> obtenerAdministradores() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios WHERE rol = 'admin' ORDER BY fecha_registro DESC";
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setDireccion(rs.getString("direccion"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFecha_registro(rs.getTimestamp("fecha_registro"));
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    public boolean insertarUsuario(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, apellido, correo, contrasena, telefono, direccion, rol) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getCorreo());
            stmt.setString(4, usuario.getContrasena()); // En producción, encriptar
            stmt.setString(5, usuario.getTelefono());
            stmt.setString(6, usuario.getDireccion());
            stmt.setString(7, usuario.getRol());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarUsuario(int id) throws SQLException {
        // No permitir eliminar si es el único administrador
        if (esUnicoAdministrador(id)) {
            return false;
        }
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private boolean esUnicoAdministrador(int idUsuario) throws SQLException {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE rol = 'admin' AND id_usuario != ?";
        Conexion conexion = new Conexion();
        Connection connection = conexion.getConexion();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Si no hay otros administradores
                }
            }
        }
        return true;
    }
    // Asegúrate de importar: java.sql.* y tu clase Modelo.Usuario + Util.Conexion

    public boolean editarUsuario(Usuario u) {
        boolean flag = false;
        String sql = "{call sp_editar_usuario(?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cs = null;

        try {
            cs = cn.prepareCall(sql);

            // 1. ID (Para el WHERE)
            cs.setInt(1, u.getId_usuario());

            // 2. Datos personales
            cs.setString(2, u.getNombre());
            cs.setString(3, u.getApellido());
            cs.setString(4, u.getCorreo());

            // 3. Contraseña (Si está vacía, el SP la ignora)
            cs.setString(5, u.getContrasena());

            // 4. Datos opcionales (Manejamos nulos por si acaso)
            cs.setString(6, u.getTelefono() != null ? u.getTelefono() : "");
            cs.setString(7, u.getDireccion() != null ? u.getDireccion() : "");

            // 5. Rol
            cs.setString(8, u.getRol());

            // Ejecutar
            int i = cs.executeUpdate();
            if (i > 0) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println("Error en editarUsuario DAO: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar recursos siempre
            try {
                if (cs != null) cs.close();
                if (cn != null) cn.close();
            } catch (Exception e) {}
        }

        return flag;
    }
        // Método para cerrar recursos
    private void cerrarRecursos() {
        try {
            if (rs != null) {
                rs.close();
                rs = null;
            }
            if (ct != null) {
                ct.close();
                ct = null;
            }
            // No cerramos la conexión (cn) para reutilizarla
        } catch (SQLException e) {
            System.err.println("Error cerrando recursos: " + e.getMessage());
        }
    }
    
}
