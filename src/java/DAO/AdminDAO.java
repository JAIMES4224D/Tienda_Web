/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Modelo.Categoria;
import DAO.Conexion;
import Modelo.ContactData;
import Modelo.ProductoDTO;
import Modelo.Productoss;
import Modelo.Proveedores;
import Modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
/**
 *
 * @author Jeferson Jaimes Passuni
 */
public class AdminDAO {
    Conexion conexion = new Conexion();
    private Connection cn = conexion.getConexion();
    private PreparedStatement pt = null;
    private CallableStatement cs = null;
    private ResultSet rs = null;
    

    //===================================================================
    //*******************************************************************
    //===================================================================
    //PRODUCTOS(jsp)
    
    //1. Total de productos
    public int contarProductos() {
        int numProductos = 0;
        String sql = "SELECT COUNT(*) AS total FROM productos;";
        try {
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();

            // Mover el cursor a la primera fila del resultado
            if (rs.next()) {
                numProductos = rs.getInt("total");
            }

            System.out.println("Número de productos: " + numProductos);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return numProductos;
    }
    
    //2. Productos activos
    public int contarProductosActivos() {
        int numProductos = 0;
        String sql = "SELECT COUNT(*) AS total FROM productos;";
        try {
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();

            // Mover el cursor a la primera fila del resultado
            if (rs.next()) {
                numProductos = rs.getInt("total");
            }

            System.out.println("Número de productos: " + numProductos);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return numProductos;
    }
    
    //3 Productos estokc bajo 
    public int contarStockBajo(){
        int num = 0;
        String sql = "CALL sp_contar_productos_bajo_stock();";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                num = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return num;
    }
    
    //4. Contar categorias
    public int contarCategorias() {
        int total = 0;
        String sql = "{call contar_categorias()}";

        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();

            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return total;
    }
    //5. Listar categoria
    public List<Categoria> listarCategorias(){
        List<Categoria> lista = new ArrayList<>();
        String sql = "{call listarCategoria()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            
            while(rs.next()){
                Categoria c = new Categoria();
                c.setId_categoria(rs.getInt("id_categoria"));
                c.setNombre_categoria(rs.getString("nombre_categoria"));
                c.setDescripcion(rs.getString("descripcion"));
                lista.add(c);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    //6. Listar Productos(ProductosDTO)
    public List<Productoss> listarProductos(){
        List<Productoss> lista = new ArrayList<>();
        String sql = "{call listarProductos()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            while(rs.next()){
                Productoss pd = new Productoss();
                pd.setIdProducto(rs.getInt("id_producto"));
                pd.setNombreProducto(rs.getString("nombre_producto"));
                pd.setDescripcion(rs.getString("descripcion"));
                pd.setPrecio(rs.getDouble("precio"));
                pd.setStock(rs.getInt("stock"));
                pd.setNombreCategoria(rs.getString("nombre_categoria"));
                pd.setImagen(rs.getBytes("imagen"));
                lista.add(pd);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    //7. Editar Producto
    public void editarProducto(ProductoDTO p) {
        // 1. El SQL llama al procedimiento con los 7 parámetros
        // Orden: id, nombre, descripcion, precio, stock, id_categoria, imagen
        String sql = "{call sp_editar_producto(?, ?, ?, ?, ?, ?, ?)}";

        CallableStatement cs = null;

        try {
            cs = cn.prepareCall(sql);

            // 2. Asignamos los datos básicos
            cs.setInt(1, p.getId_producto());
            cs.setString(2, p.getNombre_producto());
            cs.setString(3, p.getDescripcion());
            cs.setDouble(4, p.getPrecio());
            cs.setInt(5, p.getStock());
            cs.setInt(6, p.getId_categoria()); 

            // --- CORRECCIÓN PARA BASE64 ---
            String base64 = p.getImagenBase64();

            if (base64 != null && !base64.isEmpty()) {
                try {
                    // 1. Decodificamos el texto Base64 a un arreglo de bytes
                    // (Asegúrate de importar java.util.Base64)
                    byte[] imagenBytes = Base64.getDecoder().decode(base64);

                    // 2. Enviamos los bytes a la base de datos
                    cs.setBytes(7, imagenBytes); 

                } catch (IllegalArgumentException e) {
                    // Si el String no es un Base64 válido, enviamos null o manejamos el error
                    System.err.println("Error al decodificar Base64: " + e.getMessage());
                    cs.setNull(7, java.sql.Types.BLOB);
                }
            } else {
                // Si está vacío, enviamos NULL (tu SP mantendrá la foto anterior)
                cs.setNull(7, java.sql.Types.BLOB);
            }

            cs.executeUpdate();
            

        } catch (Exception e) {
            System.out.println("Error al editar: " + e.getMessage());
            e.printStackTrace();
        } 
    }
    //8. Eliminar Producto
    public boolean eliminarProducto(int id) {
        // Flag inicializado en falso (asumimos error por defecto)
        boolean flag = false; 
        String sql = "{call eliminar_producto(?)}";

        CallableStatement cs = null;

        try {
            cs = cn.prepareCall(sql);
            cs.setInt(1, id);

            int filasAfectadas = cs.executeUpdate();


            if (filasAfectadas > 0) {
                flag = true;
            }

        } catch (Exception e) {
            System.out.println("Error al eliminar: " + e.getMessage());
            e.printStackTrace();
        } 

        // Retornamos el resultado
        return flag;
    }
    //9. Insertar Producto
    public boolean agregarProducto(ProductoDTO p) {
        boolean flag = false;
        String sql = "{call agregar_producto(?, ?, ?, ?, ?, ?)}";

        CallableStatement cs = null;

        try {
            cs = cn.prepareCall(sql);
            cs.setString(1, p.getNombre_producto());
            cs.setString(2, p.getDescripcion());
            cs.setDouble(3, p.getPrecio());
            cs.setInt(4, p.getStock());
            cs.setInt(5, p.getId_categoria());

            // --- CORRECCIÓN: DECODIFICAR BASE64 A BYTES ---
            String base64 = p.getImagenBase64();

            if (base64 != null && !base64.trim().isEmpty()) {
                try {
                    // 1. Convertimos el String Base64 de vuelta a arreglo de bytes
                    byte[] imagenBytes = Base64.getDecoder().decode(base64);

                    // 2. Enviamos los bytes puros a la base de datos
                    cs.setBytes(6, imagenBytes);
                } catch (IllegalArgumentException e) {
                    System.err.println("Error: El String no es un Base64 válido.");
                    cs.setNull(6, java.sql.Types.BLOB);
                }
            } else {
                // Si está vacío o es null, mandamos NULL a la BD
                cs.setNull(6, java.sql.Types.BLOB);
            }
            // -----------------------------------------------

            int filas = cs.executeUpdate();
            if (filas > 0) {
                flag = true;
            }

        } catch (Exception e) {
            System.err.println("Error al agregar: " + e.getMessage());
            e.printStackTrace();
        } 
        return flag;
    }
public ProductoDTO buscarProductoPorId(int idProducto) {
    ProductoDTO producto = null;
    String sql = "CALL sp_BuscarProductoPorID(?)";
    
    try ( CallableStatement stmt = cn.prepareCall(sql)) {
        
        stmt.setInt(1, idProducto);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            producto = new ProductoDTO();
            producto.setId_producto(rs.getInt("id_producto"));
            producto.setNombre_producto(rs.getString("nombre_producto"));
            producto.setDescripcion(rs.getString("descripcion"));
            producto.setPrecio(rs.getDouble("precio")); // Cambio aquí
            producto.setStock(rs.getInt("stock"));
            producto.setId_categoria(rs.getInt("id_categoria"));
            
            // Convertir bytes a Base64 para mostrar en HTML
            byte[] imagenBytes = rs.getBytes("imagen");
            if (imagenBytes != null) {
                String imagenBase64 = Base64.getEncoder().encodeToString(imagenBytes);
                producto.setImagenBase64(imagenBase64);
            }
            
            producto.setFecha_registro(rs.getTimestamp("fecha_registro"));
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return producto;
}
public boolean actualizarProducto(ProductoDTO producto) {
    String sql = "UPDATE productos SET nombre_producto = ?, descripcion = ?, precio = ?, " +
                 "stock = ?, id_categoria = ?, imagen = ? WHERE id_producto = ?";
    
    try (PreparedStatement stmt = cn.prepareStatement(sql)) {
        
        stmt.setString(1, producto.getNombre_producto());
        stmt.setString(2, producto.getDescripcion());
        stmt.setDouble(3, producto.getPrecio());
        stmt.setInt(4, producto.getStock());
        stmt.setInt(5, producto.getId_categoria());
        
        // Convertir Base64 a bytes para la base de datos
        if (producto.getImagenBase64() != null && !producto.getImagenBase64().isEmpty()) {
            byte[] imagenBytes = java.util.Base64.getDecoder().decode(producto.getImagenBase64());
            stmt.setBytes(6, imagenBytes);
        } else {
            stmt.setNull(6, java.sql.Types.BLOB);
        }
        
        stmt.setInt(7, producto.getId_producto());
        
        int filasAfectadas = stmt.executeUpdate();
        return filasAfectadas > 0;
        
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    //===================================================================
    //*******************************************************************
    //===================================================================
    //2. Categoria 
    //1. Contar Categorias - Categorias ACTIVAS
    public int contarCategoria(){
        int num = 0;
        String sql = "{call contar_categorias()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                num = rs.getInt("total");
            }
            System.out.println("num categorias= " + num);
        }catch(Exception e){
            e.printStackTrace();
        }
        return num;
    }
    //3. eliminar 
    public boolean eliminarCategoria(int idCategoria) {
        boolean flag = false;
        String sql = "{call sp_eliminar_categoria(?)}"; // Llamada al SP
        CallableStatement cs = null; // Declaramos fuera para cerrar en finally

        try {
            // 1. Preparar la llamada usando la conexión (asumo que 'cn' es tu variable de conexión)
            cs = cn.prepareCall(sql);

            // 2. CORRECCIÓN: Usamos setInt para ENVIAR el ID al primer parámetro (?)
            // El '1' indica que es el primer signo de interrogación
            cs.setInt(1, idCategoria);

            // 3. Ejecutar la sentencia
            // Usamos executeUpdate() para INSERT, UPDATE o DELETE
            // Devuelve el número de filas afectadas
            int filasAfectadas = cs.executeUpdate();

            // 4. Validar si se eliminó algo
            if (filasAfectadas > 0) {
                flag = true;
            }

        } catch (Exception e) {
            // Log de error profesional
            System.err.println("Error en eliminarCategoria: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // 5. CLEAN CODE: Siempre cerrar el CallableStatement para liberar memoria
            try {
                if (cs != null) cs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return flag;
    }
    //4. editar
    //5. insertar 
    public boolean insertarCategoria(String name, String descripcion) {
        System.out.println("--- INICIO DEBUG insertarCategoria ---");
        System.out.println("1. Datos recibidos: " + name + " - " + descripcion);

        boolean flag = false;
        String sql = "{call sp_insertar_categoria(?, ?)}";
        CallableStatement cs = null;

        try {
            // Verificamos si la conexión existe
            if (cn == null || cn.isClosed()) {
                 System.err.println("❌ ERROR FATAL: La conexión 'cn' es NULA o está CERRADA.");
                 System.err.println("Revisa el Constructor de tu DAO.");
                 return false;
            }

            cs = cn.prepareCall(sql);
            cs.setString(1, name);
            cs.setString(2, descripcion);

            System.out.println("2. Ejecutando SP...");
            int filasAfectadas = cs.executeUpdate();
            System.out.println("3. Filas afectadas: " + filasAfectadas);

            if (filasAfectadas > 0) {
                flag = true;
                System.out.println("✅ ÉXITO: Flag cambiada a True");
            } else {
                System.err.println("⚠️ ALERTA: La base de datos devolvió 0 cambios.");
            }

        } catch (Exception e) {
            System.err.println("❌ EXCEPCIÓN DETECTADA:");
            e.printStackTrace(); // Esto imprimirá el error exacto en rojo
        } 

        System.out.println("--- FIN DEBUG (Retorna: " + flag + ") ---");
        return flag;
    }
    
    
    public boolean editarCategoria(int id, String nombre, String descripcion) {
        boolean flag = false;
        String sql = "{call sp_editar_categoria(?, ?, ?)}"; // Asumiendo que ya creaste el SP
        CallableStatement cs = null;

        try {
            
            cs = cn.prepareCall(sql);
            cs.setInt(1, id);
            cs.setString(2, nombre);
            cs.setString(3, descripcion);

            int i = cs.executeUpdate();
            if (i > 0) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return flag;
    }
    //==============================================================================
    //Usuarios
    public int totalUsuarios(){
        int total = 0;
        String sql = "{call sp_contar_total_usuarios()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                total = rs.getInt("total");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return total;
    }


    
    public int totalClientes(){
        int total = 0;
        String sql = "{call sp_contar_total_clientes()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                total = rs.getInt("total");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return total;
    }
    
    
    public int totalAdmin(){
        int total = 0;
        String sql = "{call sp_contar_total_admin()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                total = rs.getInt("total");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return total;
    }
    
    
    public List<Usuario> listarUsuarios(){
        List<Usuario> lista = new ArrayList<>();
        String sql = "{call listarUsuarios()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            while(rs.next()){
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contrasena"));
                u.setTelefono(rs.getString("telefono"));
                u.setDireccion(rs.getString("direccion"));
                u.setFoto(rs.getBytes("foto"));
                u.setRol(rs.getString("rol"));
                u.setFecha_registro(rs.getTimestamp("fecha_registro"));
                lista.add(u);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    
    public List<Usuario> listarAdministradores(){
        List<Usuario> lista = new ArrayList<>();
        String sql = "{call sp_listar_administradores()};";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            while(rs.next()){
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setContrasena(rs.getString("contrasena"));
                u.setTelefono(rs.getString("telefono"));
                u.setDireccion(rs.getString("direccion"));
                u.setFoto(rs.getBytes("foto"));
                u.setRol(rs.getString("rol"));
                u.setFecha_registro(rs.getTimestamp("fecha_registro"));
                lista.add(u);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    public int cantidadMensajes(){
        int temp = 0;
        String sql = "{call sp_cantidad_mensajes()};";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                temp = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return temp;
    }
    
    public int cantidadMensajesPendientes(){
        int temp = 0;
        String sql = "{call sp_cantidad_mensajes_pendientes()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                temp = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return temp;
    }
    
    public int cantidadMensajesLeidos(){
        int temp = 0;
        String sql = "{call sp_cantidad_mensajes_respondidos()}";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                temp = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return temp;
    }
    
    public List<ContactData> listarMensajes(){
        List<ContactData> lista = new ArrayList<>();
        String sql = "call sp_listarMensajes()";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            while(rs.next()){
                ContactData cd = new ContactData();
                cd.setName(rs.getString("nombre_completo"));
                cd.setEmail(rs.getString("correo_electronico"));
                cd.setPhone(rs.getString("telefono"));
                cd.setSubject(rs.getString("asunto"));
                cd.setMessage(rs.getString("mensaje"));
                cd.setEstado(rs.getString("estado"));
                lista.add(cd);
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    
    public boolean cambiarEstado(String nombre, String mensaje, String nuevoEstado) {
        boolean flag = false;
        // SQL ROBUSTO: Usamos TRIM() para evitar errores por espacios en blanco invisibles
        String sql = "UPDATE mensajes_web SET estado = ? WHERE TRIM(nombre_completo) = ? AND TRIM(mensaje) LIKE ?";

        
        PreparedStatement ps = null;

        try {
            // CORRECCIÓN IMPORTANTE: Inicializar la conexión
            ps = cn.prepareStatement(sql);

            // 1. Nuevo Estado
            ps.setString(1, nuevoEstado);

            // 2. Nombre (Quitamos espacios en Java también)
            ps.setString(2, nombre.trim());

            // 3. Mensaje (Usamos trim y LIKE para ser más flexibles)
            ps.setString(3, mensaje.trim());

            // Ejecutar
            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                flag = true;
                System.out.println("✅ UPDATE EXITOSO en BD");
            } else {
                System.out.println("❌ FALLO UPDATE: No se encontraron coincidencias en BD");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error crítico en DAO cambiarEstado: " + e.getMessage());
        } finally {
            // Cerrar recursos
            try {
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (Exception e) {}
        }

        return flag;
    }
    //=========================================================================================
    //PROVEEDORES
    //==========================================================================================
    //1.CONTEO
    public int totalProveedores(){
        int temp = 0;
        String sql = "{call totalProveedores()};";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            if(rs.next()){
                temp = rs.getInt("total");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return temp;
    }
    //listar proveedores
    public List<Proveedores> listarProveedores(){
        List<Proveedores> lista = new ArrayList<>();
        String sql = "{call listarProveedores()};";
        try{
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();
            
            while(rs.next()){
                Proveedores p = new Proveedores();
                p.setId_proveedor(rs.getInt("id_proveedor"));
                p.setNombre_empresa(rs.getString("nombre_empresa"));
                p.setContacto(rs.getString("contacto"));
                p.setTelefono(rs.getString("telefono"));
                p.setCorreo(rs.getString("correo"));
                p.setDireccion(rs.getString("direccion"));
                lista.add(p);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return lista;
    }
    public boolean eliminarProveedor(int id) {
        boolean flag = false;
        String sql = "{call eliminar_proveedor(?)}";

        try {
            // Asegúrate de tener tu conexión aquí
            // cn = Conexion.getConexion(); 

            cs = cn.prepareCall(sql);
            cs.setInt(1, id);

            int i = cs.executeUpdate();

            if (i > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Error al eliminar proveedor: " + e.getMessage());
            e.printStackTrace();
        }

        return flag;
    }
    public boolean agregarProveedor(Proveedores p) {
        boolean flag = false;
        String sql = "{call insertar_proveedor(?, ?, ?, ?, ?)}";

        try {
            // Asegúrate de tener la conexión abierta
            // cn = Conexion.getConexion(); 

            cs = cn.prepareCall(sql);

            // Asignamos los parámetros en el mismo orden del SQL
            cs.setString(1, p.getNombre_empresa());
            cs.setString(2, p.getContacto());
            cs.setString(3, p.getTelefono());
            cs.setString(4, p.getCorreo());
            cs.setString(5, p.getDireccion());

            int i = cs.executeUpdate();

            if (i > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Error al insertar proveedor: " + e.getMessage());
            e.printStackTrace();
        }

        return flag;
    }
}
