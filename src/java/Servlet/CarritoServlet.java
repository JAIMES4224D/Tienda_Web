package Servlet;

import DAO.Conexion;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "CarritoServlet", urlPatterns = {"/CarritoServlet"})
public class CarritoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        // Importante: Configurar la respuesta como JSON UTF-8
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if ("realizarCompra".equalsIgnoreCase(accion)) {
            Connection con = null;
            PreparedStatement psPedido = null;
            PreparedStatement psDetalle = null;
            PreparedStatement psStock = null;
            ResultSet rs = null;

            try {
                // ==========================================
                // 1. VALIDACIÓN DE SESIÓN (AQUÍ ESTABA EL ERROR)
                // ==========================================
                HttpSession session = request.getSession(false); 
                
                // CORRECCIÓN: Usamos "id_usuario" exactamente como lo pusiste en el Login
                if (session == null || session.getAttribute("usuarioId") == null) {
                    out.print("{\"success\": false, \"message\": \"Tu sesión ha expirado o no has iniciado sesión. Por favor, entra nuevamente.\"}");
                    return;
                }

                // Obtenemos el ID de forma segura
                int idUsuario = Integer.parseInt(session.getAttribute("usuarioId").toString());

                // ==========================================
                // 2. LEER EL CARRITO (JSON)
                // ==========================================
                BufferedReader reader = request.getReader();
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }

                if (sb.toString().trim().isEmpty()) {
                     out.print("{\"success\": false, \"message\": \"Error: El carrito llegó vacío al servidor.\"}");
                     return;
                }

                JSONArray carrito = new JSONArray(sb.toString());

                if (carrito.length() == 0) {
                    out.print("{\"success\": false, \"message\": \"No hay productos en el carrito.\"}");
                    return;
                }

                // ==========================================
                // 3. PROCESAR COMPRA EN BASE DE DATOS
                // ==========================================
                Conexion c = new Conexion();
                con = c.getConexion();
                
                if (con == null) {
                     throw new Exception("No se pudo conectar a la base de datos.");
                }

                // Desactivamos auto-commit para iniciar una Transacción (Todo o Nada)
                con.setAutoCommit(false); 

                // Calcular total del pedido
                double total = 0;
                for (int i = 0; i < carrito.length(); i++) {
                    JSONObject item = carrito.getJSONObject(i);
                    total += item.getDouble("precio") * item.getInt("cantidad");
                }

                // A. INSERTAR PEDIDO (Tabla Maestra)
                String sqlPedido = "INSERT INTO pedidos (id_usuario, total, estado) VALUES (?, ?, 'pendiente')";
                psPedido = con.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
                psPedido.setInt(1, idUsuario);
                psPedido.setDouble(2, total);
                psPedido.executeUpdate();

                // Obtener el ID del pedido recién creado
                rs = psPedido.getGeneratedKeys();
                int idPedido = 0;
                if (rs.next()) {
                    idPedido = rs.getInt(1);
                } else {
                    throw new SQLException("Error al generar el ID del pedido.");
                }

                // B. INSERTAR DETALLES Y ACTUALIZAR STOCK
                String sqlDetalle = "INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES (?,?,?,?)";
                // Esta consulta solo actualiza si el stock es suficiente (stock >= cantidad)
                String sqlStock = "UPDATE productos SET stock = stock - ? WHERE id_producto = ? AND stock >= ?";

                psDetalle = con.prepareStatement(sqlDetalle);
                psStock = con.prepareStatement(sqlStock);

                for (int i = 0; i < carrito.length(); i++) {
                    JSONObject item = carrito.getJSONObject(i);
                    int idProd = item.getInt("id");
                    int cant = item.getInt("cantidad");
                    double precio = item.getDouble("precio");

                    // 1. Intentar bajar el stock
                    psStock.setInt(1, cant);
                    psStock.setInt(2, idProd);
                    psStock.setInt(3, cant); // Validación de seguridad
                    
                    int filasAfectadas = psStock.executeUpdate();
                    if (filasAfectadas == 0) {
                        // Si entra aquí, es porque no había suficiente stock
                        throw new Exception("Stock insuficiente para el producto: " + item.getString("nombre"));
                    }

                    // 2. Guardar el detalle
                    psDetalle.setInt(1, idPedido);
                    psDetalle.setInt(2, idProd);
                    psDetalle.setInt(3, cant);
                    psDetalle.setDouble(4, precio);
                    psDetalle.executeUpdate();
                }

                // Si todo salió bien, guardamos los cambios permanentemente
                con.commit();
                
                // Respuesta de éxito al JavaScript
                out.print("{\"success\": true, \"message\": \"Compra realizada con éxito. Pedido #" + idPedido + "\"}");

            } catch (Exception e) {
                // Si algo falló, revertimos todos los cambios en la BD
                try { if (con != null) con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
                
                e.printStackTrace(); // Ver error en la consola de NetBeans/Tomcat
                
                // Limpiamos el mensaje de error para enviarlo al usuario
                String errorMsg = e.getMessage() != null ? e.getMessage().replace("\"", "'") : "Error desconocido";
                out.print("{\"success\": false, \"message\": \"Error al procesar: " + errorMsg + "\"}");
                
            } finally {
                // Cerrar todas las conexiones para liberar memoria
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (psPedido != null) psPedido.close(); } catch (Exception e) {}
                try { if (psDetalle != null) psDetalle.close(); } catch (Exception e) {}
                try { if (psStock != null) psStock.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de Carrito de Compras";
    }
}