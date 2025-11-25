/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.AdminDAO;
import DAO.UsuarioDAO;
import Modelo.Categoria;
import Modelo.ProductoDTO;
import Modelo.Proveedores;
import Modelo.Usuario;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Jeferson
 */
@WebServlet(name = "AccionesPServlet", urlPatterns = {"/AccionesPServlet"})
@MultipartConfig(
    maxFileSize = 1024 * 1024 * 10, // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class AccionesPServlet extends HttpServlet {

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
        if(acc.equals("Insertar Producto")){
            String nombre_producto = request.getParameter("nombre_producto");
            String descripcion = request.getParameter("descripcion");
            String precioStr = request.getParameter("precio");
            String stockStr = request.getParameter("stock");
            String idCategoriaStr = request.getParameter("id_categoria");
            Part imagenPart = request.getPart("imagen");
            String base64Image = "";

            if (imagenPart != null && imagenPart.getSize() > 0) {
                // 2. Obtener el flujo de entrada
                InputStream inputStream = imagenPart.getInputStream();

                // 3. Escribir el flujo en un ByteArrayOutputStream
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

                byte[] imageBytes = outputStream.toByteArray();

                // 4. Convertir a String Base64 usando la clase nativa de Java 8+
                base64Image = Base64.getEncoder().encodeToString(imageBytes);

                // 5. Cerrar los flujos para liberar memoria
                inputStream.close();
                outputStream.close();
            }
            ProductoDTO p = new ProductoDTO();
            
            //cargar los datos al modelo
            p.setNombre_producto(nombre_producto);
            p.setDescripcion(descripcion);
            p.setPrecio(Double.parseDouble(precioStr));
            p.setStock(Integer.parseInt(stockStr));
            p.setId_categoria(Integer.parseInt(idCategoriaStr));
            p.setImagenBase64(base64Image);
            
            
            boolean exito = ad.agregarProducto(p);
            if(exito){
                request.setAttribute("mensaje", "Producto insertado correctamente");
                response.sendRedirect("Productos.jsp");
            }else{
                request.setAttribute("mensaje", "Producto NO insertado correctamente");
                response.sendRedirect("Admin.jsp");
            }
        }
        if (acc.equals("eliminar")) {
            // 1. Obtienes el parámetro "id" que enviaste en la URL (llega como String)
            String idString = request.getParameter("id");

            // 2. Lo conviertes a entero (int) para que tu DAO lo entienda
            int id = Integer.parseInt(idString);

            // 3. Ejecutas el método pasando el ID real
            boolean exito = ad.eliminarProducto(id);

            // 4. Redireccionas para refrescar la tabla y ver que se borró
            if (exito) {
                response.sendRedirect("AdminController?acc=productos"); 
            } else {
                // Opcional: manejar error
                response.sendRedirect("Productos.jsp?error=true");
            }
        }
        if (acc.equals("editar")) {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            ProductoDTO p = ad.buscarProductoPorId(idProducto);

            if (p != null) {
                // Obtener lista de categorías para el dropdown
                List<Categoria> listaCategorias = ad.listarCategorias(); // Asegúrate de tener este método

                request.setAttribute("producto", p);
                request.setAttribute("listaCategorias", listaCategorias);
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } else {
                // Producto no encontrado, redirigir a lista de productos
                response.sendRedirect("AdminController?acc=productos");
            }
        }else if (acc.equals("actualizar")) {
            // Esto es para PROCESAR la actualización cuando se envía el formulario
            actualizarProducto(request, response);
        }
        
        if(acc.equals("eliminarCat")){
            int id = Integer.parseInt(request.getParameter("id"));
            boolean exito = ad.eliminarCategoria(id);
            if(exito){
                request.setAttribute("mensaje", "categoria eliminada correctamente");
                response.sendRedirect("AdminController?acc=categorias"); 
                
            }else{
                request.setAttribute("mensaje", "categoria no eliminada correctamente");
                response.sendRedirect("AdminController?acc=categorias"); 
            }
        }
        
        
        if (acc.equals("Insertar Categoria")) { // Asegúrate que el string coincida exactamente con el value del botón del modal
            // 1. Recibir parámetros
            String nombre = request.getParameter("nombre_categoria");
            String descripcion = request.getParameter("descripcion");

            // Si decides mantener tu DAO antiguo que recibe Strings:
            boolean exito = ad.insertarCategoria(nombre, descripcion);

            // 2. Manejo de Mensajes (CORRECCIÓN TÉCNICA)
            if (exito) {
                // Usamos getSession() para que el mensaje sobreviva al redirect
                request.getSession().setAttribute("mensaje", "¡Categoría registrada correctamente!"); 
            } else {
                request.getSession().setAttribute("error", "Error: No se pudo registrar la categoría.");
            }

            // 3. Redirección (Patrón PRG - Post/Redirect/Get)
            response.sendRedirect("AdminController?acc=categorias");
        }
        
        if (acc.equals("actualizar_categoria")) {
            // 1. Recibir datos
            int id = Integer.parseInt(request.getParameter("id_categoria"));
            String nombre = request.getParameter("nombre_categoria");
            String descripcion = request.getParameter("descripcion");

            // 2. Llamar al DAO
            // Asumiendo que 'ad' es tu instancia de CategoriaDAO
            boolean exito = ad.editarCategoria(id, nombre, descripcion);

            // 3. Redirigir
            if (exito) {
                request.getSession().setAttribute("mensaje", "Categoría actualizada correctamente");
            } else {
                request.getSession().setAttribute("error", "Error al actualizar la categoría");
            }
            response.sendRedirect("AdminController?acc=categorias");
        }
        
        if(acc.equals("insertar_usuario")){
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String rol = request.getParameter("rol");
            // 2. RECIBIR LA FOTO (Nivel Experto) 📸
            InputStream inputStream = null; // Aquí guardaremos la foto

            try {
                Part filePart = request.getPart("foto"); // "foto" es el name del input en el JSP

                if (filePart != null && filePart.getSize() > 0) {
                    // Convertimos el archivo a un flujo de entrada para la BD
                    inputStream = filePart.getInputStream();
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Error al recibir la foto: " + e.getMessage());
            }
            
            UsuarioDAO ud = new UsuarioDAO();
            boolean exito = ud.registrarCliente(nombre, apellido, correo, contrasena, telefono, direccion, inputStream, rol);
            
            if(exito){
                response.sendRedirect("AdminController?acc=usuarios");
            }else{
                response.sendRedirect("AdminController?acc=usuarios");
            }
            
        }
       if(acc.equals("eliminar_usuario")){
            try {
                UsuarioDAO ud = new UsuarioDAO();
                String idStr = request.getParameter("id");

                // Validamos que el ID no sea nulo antes de convertir
                if(idStr != null && !idStr.isEmpty()){
                    int cod = Integer.parseInt(idStr);

                    // Aquí estaba el error: ahora capturamos la SQLException
                    boolean exito = ud.eliminarUsuario(cod); 

                    if(exito){
                        request.getSession().setAttribute("mensaje", "Usuario eliminado correctamente.");
                    } else {
                        // Si devuelve false, es porque es el único admin o falló la query
                        request.getSession().setAttribute("error", "No se puede eliminar: Es el único administrador o hubo un error.");
                    }
                }

            } catch (SQLException e) {
                // Aquí manejamos el error de base de datos
                e.printStackTrace();
                request.getSession().setAttribute("error", "Error de Base de Datos: " + e.getMessage());
            } catch (NumberFormatException e) {
                // Aquí manejamos si el ID no es un número válido
                request.getSession().setAttribute("error", "Error: ID de usuario no válido.");
            }

            // Redireccionamos siempre al final
            response.sendRedirect("AdminController?acc=usuarios");
        }
       
       if(acc.equals("actualizar_usuario")){
            try {
                // 1. Recibir el ID (Fundamental para saber a quién editar)
                // Viene del <input type="hidden" name="id_usuario">
                int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));

                // 2. Recibir el resto de datos del formulario
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String correo = request.getParameter("correo");

                // Nota: Si el usuario dejó el campo vacío, recibiremos un String vacío ""
                // Nuestro Stored Procedure ya sabe qué hacer con eso (mantener la antigua).
                String contrasena = request.getParameter("contrasena");

                String telefono = request.getParameter("telefono");
                String direccion = request.getParameter("direccion");
                String rol = request.getParameter("rol");

                // 3. Llenar el objeto Modelo (Usuario)
                Usuario u = new Usuario();
                u.setId_usuario(idUsuario); // ¡Muy importante setear el ID!
                u.setNombre(nombre);
                u.setApellido(apellido);
                u.setCorreo(correo);
                u.setContrasena(contrasena);
                u.setTelefono(telefono);
                u.setDireccion(direccion);
                u.setRol(rol);

                // 4. Llamar al DAO (Asumo que tu instancia se llama 'ud' o 'dao')
                UsuarioDAO ud = new UsuarioDAO();
                boolean exito = ud.editarUsuario(u);

                // 5. Mensajes y Redirección
                if(exito){
                    request.getSession().setAttribute("mensaje", "Usuario actualizado correctamente.");
                } else {
                    request.getSession().setAttribute("error", "No se pudo actualizar el usuario.");
                }

            } catch (NumberFormatException e) {
                // Seguridad: Si alguien manipula el HTML y manda un ID texto
                e.printStackTrace();
                request.getSession().setAttribute("error", "Error: El ID del usuario no es válido.");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Error en el servidor: " + e.getMessage());
            }

            // 6. Redirigir siempre a la lista
            response.sendRedirect("AdminController?acc=usuarios");
        }
       
       if(acc.equals("cambiar_estado")){
            try {
                // 1. Recibimos los datos "sucios" (posiblemente mal codificados)
                String nombreRaw = request.getParameter("nombre");
                String mensajeRaw = request.getParameter("mensaje");
                String estadoNuevo = request.getParameter("estado");

                // 2. TRUCO PARA NETBEANS 8.2 (Vital para GET requests)
                // Convertimos de ISO-8859-1 a UTF-8 para arreglar tildes y eñes
                String nombre = new String(nombreRaw.getBytes("ISO-8859-1"), "UTF-8");
                String mensaje = new String(mensajeRaw.getBytes("ISO-8859-1"), "UTF-8");

                // Debug: Mira esto en la consola de NetBeans (Output) para ver qué llega
                System.out.println("--- INTENTANDO ACTUALIZAR ---");
                System.out.println("Nombre: " + nombre);
                System.out.println("Mensaje: " + mensaje);

                // 3. Llamar al DAO
                // ContactDAO ad = new ContactDAO(); // Asegúrate de tener la instancia
                boolean exito = ad.cambiarEstado(nombre, mensaje, estadoNuevo);

                if(exito){
                    request.getSession().setAttribute("mensaje", "Mensaje actualizado correctamente.");
                } else {
                    request.getSession().setAttribute("error", "No se encontró el mensaje. Verifica los datos.");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect("AdminController?acc=mensajesWeb");
        }
       
       if(acc.equals("eliminarProveedor")){
           int id = Integer.parseInt(request.getParameter("id"));
           boolean exito = ad.eliminarProveedor(id);
           response.sendRedirect("AdminController?acc=proveedores");
       }
       if (acc.equals("insertarProveedor")) {
            // 1. Recibir datos del formulario
            String nombre = request.getParameter("nombre_empresa");
            String contacto = request.getParameter("contacto");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String direccion = request.getParameter("direccion");

            // 2. Llenar el objeto
            Proveedores p = new Proveedores();
            p.setNombre_empresa(nombre);
            p.setContacto(contacto);
            p.setTelefono(telefono);
            p.setCorreo(correo);
            p.setDireccion(direccion);

            // 3. Guardar en BD
            // Asumiendo que 'ad' es tu instancia de AdminDAO
            ad.agregarProveedor(p);

            // 4. Redireccionar a la lista
            request.getRequestDispatcher("AdminController?acc=proveedores").forward(request, response);
        }

        
    }
    

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Obtener parámetros del formulario
        AdminDAO ad = new AdminDAO();
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        String nombreProducto = request.getParameter("nombre_producto");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        String mantenerImagen = request.getParameter("mantener_imagen");
        Part imagenPart = request.getPart("imagen");
        
        // Obtener producto actual para mantener la imagen si es necesario
        ProductoDTO productoActual = ad.buscarProductoPorId(idProducto);
        
        // Procesar imagen - MÉTODO COMPATIBLE
        String imagenBase64 = null;
        
        if (mantenerImagen != null && mantenerImagen.equals("true")) {
            // Mantener la imagen actual
            imagenBase64 = productoActual.getImagenBase64();
        } else {
            // Procesar nueva imagen
            if (imagenPart != null && imagenPart.getSize() > 0) {
                // Convertir la nueva imagen a Base64 - MÉTODO COMPATIBLE
                InputStream imagenStream = imagenPart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                
                int nRead;
                byte[] data = new byte[1024];
                
                while ((nRead = imagenStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                
                buffer.flush();
                byte[] imagenBytes = buffer.toByteArray();
                imagenBase64 = java.util.Base64.getEncoder().encodeToString(imagenBytes);
                
                // Cerrar streams
                imagenStream.close();
                buffer.close();
            }
        }
        
        // Crear objeto Producto actualizado
        ProductoDTO productoActualizado = new ProductoDTO();
        productoActualizado.setId_producto(idProducto);
        productoActualizado.setNombre_producto(nombreProducto);
        productoActualizado.setDescripcion(descripcion);
        productoActualizado.setPrecio(precio);
        productoActualizado.setStock(stock);
        productoActualizado.setId_categoria(idCategoria);
        productoActualizado.setImagenBase64(imagenBase64);
        
        // Actualizar en la base de datos
        boolean exito = ad.actualizarProducto(productoActualizado);
        
        if (exito) {
            request.getSession().setAttribute("mensaje", "Producto actualizado correctamente");
        } else {
            request.getSession().setAttribute("error", "Error al actualizar el producto");
        }
        
        // Redirigir a la lista de productos
        response.sendRedirect("AdminController?acc=productos");
        
    } catch (Exception e) {
        e.printStackTrace();
        request.getSession().setAttribute("error", "Error al actualizar: " + e.getMessage());
        response.sendRedirect("AdminController?acc=productos");
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
