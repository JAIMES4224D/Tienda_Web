/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author HP
 */
public class Categoria {
    private int id_categoria;
    private String nombre_categoria;
    private String descripcion;
    
    // Constructores
    public Categoria() {}
    
    public Categoria(int id_categoria, String nombre_categoria, String descripcion) {
        this.id_categoria = id_categoria;
        this.nombre_categoria = nombre_categoria;
        this.descripcion = descripcion;
    }
    
    // Getters y Setters
    public int getId_categoria() {
        return id_categoria;
    }
    
    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }
    
    public String getNombre_categoria() {
        return nombre_categoria;
    }
    
    public void setNombre_categoria(String nombre_categoria) {
        this.nombre_categoria = nombre_categoria;
    }
    
    public String getDescripcion() {
        return descripcion;
    }
    
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    @Override
    public String toString() {
        return "Categoria{" +
                "id_categoria=" + id_categoria +
                ", nombre_categoria='" + nombre_categoria + '\'' +
                ", descripcion='" + descripcion + '\'' +
                '}';
    }
}