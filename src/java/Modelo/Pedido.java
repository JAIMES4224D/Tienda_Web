package Modelo;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Pedido {
    private int idPedido;
    private int idUsuario;
    private Timestamp fechaPedido;
    private BigDecimal total;
    private String estado;
    private String nombreUsuario;
    private List<DetallePedido> detalles;

    public Pedido() {
    }

    public Pedido(int idPedido, int idUsuario, Timestamp fechaPedido, BigDecimal total, String estado, String nombreUsuario, List<DetallePedido> detalles) {
        this.idPedido = idPedido;
        this.idUsuario = idUsuario;
        this.fechaPedido = fechaPedido;
        this.total = total;
        this.estado = estado;
        this.nombreUsuario = nombreUsuario;
        this.detalles = detalles;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Timestamp getFechaPedido() {
        return fechaPedido;
    }

    public void setFechaPedido(Timestamp fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public List<DetallePedido> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetallePedido> detalles) {
        this.detalles = detalles;
    }
    
}