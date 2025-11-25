/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author Jeferson
 */
public class Proveedores {
    private int id_proveedor;
    private String nombre_empresa;
    private String contacto;
    private String telefono;
    private String correo;
    private String direccion;

    public Proveedores() {
    }

    public Proveedores(int id_proveedor, String nombre_empresa, String contacto, String telefono, String correo, String direccion) {
        this.id_proveedor = id_proveedor;
        this.nombre_empresa = nombre_empresa;
        this.contacto = contacto;
        this.telefono = telefono;
        this.correo = correo;
        this.direccion = direccion;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public String getNombre_empresa() {
        return nombre_empresa;
    }

    public void setNombre_empresa(String nombre_empresa) {
        this.nombre_empresa = nombre_empresa;
    }

    public String getContacto() {
        return contacto;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
}
