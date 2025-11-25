package Modelo;

import java.sql.Timestamp;
import java.util.Base64;

public class Producto {
    private int id_producto;
    private String nombre_producto;
    private String descripcion;
    private double precio;
    private int stock;
    private byte[] imagen;  // ✅ Usar byte[] es más simple y compatible
    private int id_categoria;
    private Timestamp fecha_registro;
    private String nombre_categoria;
    
    // Constructores
    public Producto() {
    }
    
    public Producto(int id_producto, String nombre_producto, String descripcion, 
                   double precio, int stock, byte[] imagen, int id_categoria) {
        this.id_producto = id_producto;
        this.nombre_producto = nombre_producto;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.imagen = imagen;
        this.id_categoria = id_categoria;
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
    
    public byte[] getImagen() {
        return imagen;
    }
    
    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }
    
    // ⭐ MÉTODO CLAVE: Convierte byte[] a Base64 para el frontend
    public String getImagenBase64() {
        if (imagen != null && imagen.length > 0) {
            try {
                return Base64.getEncoder().encodeToString(imagen);
            } catch (Exception e) {
                System.err.println("❌ Error convirtiendo imagen a Base64: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return null;
    }
    
    // Método para verificar si tiene imagen
    public boolean tieneImagen() {
        return imagen != null && imagen.length > 0;
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
    
    @Override
    public String toString() {
        return "Producto{" +
                "id_producto=" + id_producto +
                ", nombre_producto='" + nombre_producto + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", precio=" + precio +
                ", stock=" + stock +
                ", id_categoria=" + id_categoria +
                ", nombre_categoria='" + nombre_categoria + '\'' +
                ", fecha_registro=" + fecha_registro +
                ", tieneImagen=" + tieneImagen() +
                '}';
    }
}