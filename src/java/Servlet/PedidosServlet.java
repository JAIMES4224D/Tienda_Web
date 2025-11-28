package Servlet;

import DAO.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "PedidosServlet", urlPatterns = {"/PedidosServlet"})
public class PedidosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String accion = request.getParameter("accion");
        HttpSession session = request.getSession(false);

        // Verificar si es admin
        boolean esAdmin = session != null && 
                         session.getAttribute("usuarioRol") != null && 
                         "admin".equals(session.getAttribute("usuarioRol"));

        if ("detalle".equals(accion)) {
            if (esAdmin) {
                obtenerDetallePedidoAdmin(request, response);
            } else {
                obtenerDetallePedido(request, response);
            }
        } else {
            if (esAdmin) {
                // Si necesitas lista de pedidos para admin también
                obtenerDetallePedidoAdmin(request, response);
            } else {
                obtenerPedidosUsuario(request, response);
            }
        }
    }
    
    private void obtenerPedidosUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        // 1. SEGURIDAD: Verificar Sesión
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("usuarioId") == null) {
            out.print("[]");
            return;
        }

        // Convertimos el ID de forma segura
        int idUsuario = 0;
        try {
            idUsuario = Integer.parseInt(session.getAttribute("usuarioId").toString());
        } catch (Exception e) {
            out.print("[]");
            return;
        }
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Conexion c = new Conexion();
            con = c.getConexion();
            
            // 2. CONSULTA MAESTRA: Traer los pedidos de este usuario
            String sqlPedidos = "SELECT id_pedido, fecha_pedido, total, estado FROM pedidos WHERE id_usuario = ? ORDER BY fecha_pedido DESC";
            ps = con.prepareStatement(sqlPedidos);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();
            
            JSONArray listaPedidos = new JSONArray();
            
            while (rs.next()) {
                JSONObject pedido = new JSONObject();
                
                // Usar nombres consistentes con el JavaScript
                int idPedido = rs.getInt("id_pedido");
                pedido.put("id_pedido", idPedido);
                
                // Enviar fecha como string para evitar problemas
                Timestamp fecha = rs.getTimestamp("fecha_pedido");
                pedido.put("fecha_pedido", fecha != null ? fecha.toString() : "");
                
                pedido.put("total", rs.getDouble("total"));
                pedido.put("estado", rs.getString("estado"));
                
                listaPedidos.put(pedido);
            }
            
            out.print(listaPedidos.toString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        } finally {
            // Cerrar todas las conexiones
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }
    
    private void obtenerDetallePedido(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        // 1. SEGURIDAD: Verificar Sesión
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("usuarioId") == null) {
            out.print("{\"error\": \"Usuario no autenticado\"}");
            return;
        }

        // Obtener ID del pedido
        String idPedidoParam = request.getParameter("id");
        if (idPedidoParam == null || idPedidoParam.isEmpty()) {
            out.print("{\"error\": \"ID de pedido no especificado\"}");
            return;
        }

        int idPedido;
        try {
            idPedido = Integer.parseInt(idPedidoParam);
        } catch (NumberFormatException e) {
            out.print("{\"error\": \"ID de pedido inválido\"}");
            return;
        }
        
        Connection con = null;
        PreparedStatement psPedido = null;
        PreparedStatement psProductos = null;
        ResultSet rsPedido = null;
        ResultSet rsProductos = null;

        try {
            Conexion c = new Conexion();
            con = c.getConexion();
            
            // Verificar que el pedido pertenece al usuario
            int idUsuario = Integer.parseInt(session.getAttribute("usuarioId").toString());
            String sqlVerificar = "SELECT id_pedido FROM pedidos WHERE id_pedido = ? AND id_usuario = ?";
            psPedido = con.prepareStatement(sqlVerificar);
            psPedido.setInt(1, idPedido);
            psPedido.setInt(2, idUsuario);
            rsPedido = psPedido.executeQuery();
            
            if (!rsPedido.next()) {
                out.print("{\"error\": \"Pedido no encontrado o no autorizado\"}");
                return;
            }
            
            // Obtener información del pedido
            String sqlPedido = "SELECT id_pedido, fecha_pedido, total, estado FROM pedidos WHERE id_pedido = ?";
            psPedido = con.prepareStatement(sqlPedido);
            psPedido.setInt(1, idPedido);
            rsPedido = psPedido.executeQuery();
            
            JSONObject respuesta = new JSONObject();
            JSONObject pedido = new JSONObject();
            JSONArray productosArray = new JSONArray();
            
            if (rsPedido.next()) {
                pedido.put("id_pedido", rsPedido.getInt("id_pedido"));
                Timestamp fecha = rsPedido.getTimestamp("fecha_pedido");
                pedido.put("fecha_pedido", fecha != null ? fecha.toString() : "");
                pedido.put("total", rsPedido.getDouble("total"));
                pedido.put("estado", rsPedido.getString("estado"));
                
                respuesta.put("pedido", pedido);
            }
            
            // Obtener productos del pedido
            String sqlProductos = "SELECT dp.cantidad, dp.precio_unitario, p.nombre_producto, p.imagen " +
                                 "FROM detalle_pedido dp " +
                                 "JOIN productos p ON dp.id_producto = p.id_producto " +
                                 "WHERE dp.id_pedido = ?";
            psProductos = con.prepareStatement(sqlProductos);
            psProductos.setInt(1, idPedido);
            rsProductos = psProductos.executeQuery();
            
            while (rsProductos.next()) {
                JSONObject producto = new JSONObject();
                producto.put("cantidad", rsProductos.getInt("cantidad"));
                producto.put("precio_unitario", rsProductos.getDouble("precio_unitario"));
                producto.put("nombre_producto", rsProductos.getString("nombre_producto"));
                
                // Conversión de imagen (BLOB a Base64)
                byte[] imgBytes = rsProductos.getBytes("imagen");
                if (imgBytes != null && imgBytes.length > 0) {
                    String imgBase64 = Base64.getEncoder().encodeToString(imgBytes);
                    producto.put("imagen", imgBase64);
                } else {
                    producto.put("imagen", JSONObject.NULL);
                }
                
                productosArray.put(producto);
            }
            
            respuesta.put("productos", productosArray);
            out.print(respuesta.toString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"Error al obtener detalles del pedido\"}");
        } finally {
            // Cerrar todas las conexiones
            try { if(rsProductos != null) rsProductos.close(); } catch(Exception e) {}
            try { if(psProductos != null) psProductos.close(); } catch(Exception e) {}
            try { if(rsPedido != null) rsPedido.close(); } catch(Exception e) {}
            try { if(psPedido != null) psPedido.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }
    private void obtenerDetallePedidoAdmin(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
        PrintWriter out = response.getWriter();

        // 1. SEGURIDAD: Verificar que es admin
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuarioRol") == null || 
            !"admin".equals(session.getAttribute("usuarioRol"))) {
            out.print("{\"error\": \"Acceso no autorizado\"}");
            return;
        }

        // Obtener ID del pedido
        String idPedidoParam = request.getParameter("id");
        if (idPedidoParam == null || idPedidoParam.isEmpty()) {
            out.print("{\"error\": \"ID de pedido no especificado\"}");
            return;
        }

        int idPedido;
        try {
            idPedido = Integer.parseInt(idPedidoParam);
        } catch (NumberFormatException e) {
            out.print("{\"error\": \"ID de pedido inválido\"}");
            return;
        }

        Connection con = null;
        PreparedStatement psPedido = null;
        PreparedStatement psProductos = null;
        ResultSet rsPedido = null;
        ResultSet rsProductos = null;

        try {
            Conexion c = new Conexion();
            con = c.getConexion();

            // Obtener información completa del pedido (sin restricción de usuario)
            String sqlPedido = "SELECT p.id_pedido, p.fecha_pedido, p.total, p.estado, " +
                              "u.nombre as nombre_cliente, u.apellido, u.direccion, u.telefono " +
                              "FROM pedidos p " +
                              "JOIN usuarios u ON p.id_usuario = u.id_usuario " +
                              "WHERE p.id_pedido = ?";
            psPedido = con.prepareStatement(sqlPedido);
            psPedido.setInt(1, idPedido);
            rsPedido = psPedido.executeQuery();

            JSONObject respuesta = new JSONObject();

            if (rsPedido.next()) {
                // Información del pedido
                respuesta.put("id_pedido", rsPedido.getInt("id_pedido"));

                Timestamp fecha = rsPedido.getTimestamp("fecha_pedido");
                respuesta.put("fecha", fecha != null ? fecha.toString() : "");

                respuesta.put("total", rsPedido.getDouble("total"));
                respuesta.put("estado", rsPedido.getString("estado"));

                // Información del cliente
                String nombreCliente = rsPedido.getString("nombre_cliente") + " " + 
                                      rsPedido.getString("apellido");
                respuesta.put("cliente", nombreCliente);
                respuesta.put("direccion", rsPedido.getString("direccion"));
                respuesta.put("telefono", rsPedido.getString("telefono"));

                // Calcular subtotal (sin envío)
                double total = rsPedido.getDouble("total");
                respuesta.put("subtotal", total - 15.00); // Asumiendo envío fijo de S/ 15
                respuesta.put("envio", 15.00);
            } else {
                out.print("{\"error\": \"Pedido no encontrado\"}");
                return;
            }

            // Obtener productos del pedido
            String sqlProductos = "SELECT dp.cantidad, dp.precio_unitario, p.nombre_producto, p.imagen " +
                                 "FROM detalle_pedido dp " +
                                 "JOIN productos p ON dp.id_producto = p.id_producto " +
                                 "WHERE dp.id_pedido = ?";
            psProductos = con.prepareStatement(sqlProductos);
            psProductos.setInt(1, idPedido);
            rsProductos = psProductos.executeQuery();

            JSONArray productosArray = new JSONArray();
            double subtotalCalculado = 0;

            while (rsProductos.next()) {
                JSONObject producto = new JSONObject();
                int cantidad = rsProductos.getInt("cantidad");
                double precio = rsProductos.getDouble("precio_unitario");
                double subtotalProducto = cantidad * precio;
                subtotalCalculado += subtotalProducto;

                producto.put("nombre", rsProductos.getString("nombre_producto"));
                producto.put("precio", precio);
                producto.put("cantidad", cantidad);
                

                // Conversión de imagen
                byte[] imgBytes = rsProductos.getBytes("imagen");
                if (imgBytes != null && imgBytes.length > 0) {
                    String imgBase64 = Base64.getEncoder().encodeToString(imgBytes);
                    producto.put("imagen", "data:image/jpeg;base64," + imgBase64);
                } else {
                    producto.put("imagen", "");
                }

                productosArray.put(producto);
            }

            // Actualizar subtotal con cálculo real
            respuesta.put("subtotal", subtotalCalculado);
            respuesta.put("productos", productosArray);

            out.print(respuesta.toString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"Error al obtener detalles del pedido: " + e.getMessage() + "\"}");
        } finally {
            try { if(rsProductos != null) rsProductos.close(); } catch(Exception e) {}
            try { if(psProductos != null) psProductos.close(); } catch(Exception e) {}
            try { if(rsPedido != null) rsPedido.close(); } catch(Exception e) {}
            try { if(psPedido != null) psPedido.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }
}