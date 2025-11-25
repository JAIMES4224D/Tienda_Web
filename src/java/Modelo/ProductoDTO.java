package Modelo;

import java.sql.Timestamp;
import javax.servlet.http.Part;

/**
 * DTO para transferir productos al frontend con imagen en Base64
 */
public class ProductoDTO {
    private int id_producto;
    private String nombre_producto;
    private String descripcion;
    private double precio;
    private int stock;
    private String imagenBase64;  // ⭐ CAMBIO IMPORTANTE: debe ser imagenBase64 para el JavaScript
    private int id_categoria;
    private Timestamp fecha_registro;
    private String nombre_categoria;
    
    // Constructor vacío (necesario para Gson)
    public ProductoDTO() {
    }
    
    // Constructor que convierte de Producto a ProductoDTO
    public ProductoDTO(Producto producto) {
        this.id_producto = producto.getId_producto();
        this.nombre_producto = producto.getNombre_producto();
        this.descripcion = producto.getDescripcion();
        this.precio = producto.getPrecio();
        this.stock = producto.getStock();
        this.id_categoria = producto.getId_categoria();
        this.fecha_registro = producto.getFecha_registro();
        this.nombre_categoria = producto.getNombre_categoria();
        
        // Usar el método getImagenBase64() del Producto
        this.imagenBase64 = producto.getImagenBase64();
        
        // Debug mejorado
        if (this.imagenBase64 != null) {
            System.out.println("✅ ProductoDTO - ID: " + id_producto + 
                             " | " + nombre_producto + 
                             " | Imagen: Base64[" + imagenBase64.length() + " chars]");
        } else {
            System.out.println("⚠️ ProductoDTO - ID: " + id_producto + 
                             " | " + nombre_producto + 
                             " | Sin imagen");
        }
    }

    // Getters y Setters
    public int getId_producto() {
        return id_producto;
    }
    
    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }
    
    public String getNombre_producto() {
        return nombre_producto;
    }
    
    public void setNombre_producto(String nombre_producto) {
        this.nombre_producto = nombre_producto;
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
    
    // ⭐ GETTER IMPORTANTE: debe llamarse getImagenBase64 para que Gson lo serialice como "imagenBase64"
    public String getImagenBase64() {
        return imagenBase64;
    }
    
    public void setImagenBase64(String imagenBase64) {
        this.imagenBase64 = imagenBase64;
    }
    
    public int getId_categoria() {
        return id_categoria;
    }
    
    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }
    
    public Timestamp getFecha_registro() {
        return fecha_registro;
    }
    
    public void setFecha_registro(Timestamp fecha_registro) {
        this.fecha_registro = fecha_registro;
    }
    
    public String getNombre_categoria() {
        return nombre_categoria;
    }
    
    public void setNombre_categoria(String nombre_categoria) {
        this.nombre_categoria = nombre_categoria;
    }
    
    // Método para verificar si tiene imagen
    public boolean tieneImagen() {
        return imagenBase64 != null && !imagenBase64.trim().isEmpty();
    }
    
    @Override
    public String toString() {
        return "ProductoDTO{" +
                "id_producto=" + id_producto +
                ", nombre_producto='" + nombre_producto + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", precio=" + precio +
                ", stock=" + stock +
                ", id_categoria=" + id_categoria +
                ", fecha_registro=" + fecha_registro +
                ", nombre_categoria='" + nombre_categoria + '\'' +
                ", tieneImagen=" + tieneImagen() +
                '}';
    }

    
}