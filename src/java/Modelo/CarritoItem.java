package Modelo;

public class CarritoItem {
    private int userId;
    private int idProducto;
    private String nombre;
    private double precio;
    private int cantidad;
    private String imagen;
    private int stock;

    // Getters y Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public double getSubtotal() {
        return precio * cantidad;
    }
}