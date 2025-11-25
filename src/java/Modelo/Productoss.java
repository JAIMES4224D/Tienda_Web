package Modelo;

import java.util.Base64;

/**
 *
 * @author Jeferson
 */
public class Productoss {
    private int idProducto;
    private String nombreProducto;
    private String descripcion;
    private double precio;
    private int stock;
    private int idCategoria;        
    private String nombreCategoria;
    
    // ⭐ CAMBIO: Usamos byte[] en lugar de InputStream para poder convertir a Base64
    private byte[] imagen; 

    public Productoss() {
    }

    // Constructor actualizado con byte[]
    public Productoss(int idProducto, String nombreProducto, String descripcion, double precio, int stock, int idCategoria, String nombreCategoria, byte[] imagen) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.idCategoria = idCategoria;
        this.nombreCategoria = nombreCategoria;
        this.imagen = imagen;
    }

    // --- GETTERS Y SETTERS ---

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    // Getter normal para la BD
    public byte[] getImagen() {
        return imagen;
    }

    // Setter normal
    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }

    // ==============================================================
    // ⭐ MÉTODOS NUEVOS QUE SOLUCIONAN EL ERROR DEL JSP
    // ==============================================================

    // Este es el método que busca el JSP cuando pones ${p.imagenBase64}
    public String getImagenBase64() {
        if (this.imagen != null && this.imagen.length > 0) {
            // Convierte los bytes de la imagen a texto Base64 para el HTML
            return Base64.getEncoder().encodeToString(this.imagen);
        }
        return null;
    }

    // Este método sirve para el <c:if test="${p.tieneImagen()}">
    public boolean tieneImagen() {
        return this.imagen != null && this.imagen.length > 0;
    }
}