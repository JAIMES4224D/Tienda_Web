/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.*;
/**
 *
 * @author Jeferson Jaimes Passuni
 */
public class Conexion {
    private static final String URL = "jdbc:mysql://localhost:3306/tienda_led?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSW = "";

    public  Connection getConexion() {
        Connection cn = null;
        try {
            // Driver actualizado para MySQL 8
            Class.forName("com.mysql.jdbc.Driver");
            cn = DriverManager.getConnection(URL, USER, PASSW);
            System.out.println("✅ Conexión exitosa a la base de datos.");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ No se encontró el driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("❌ Error al conectar a la base de datos: " + e.getMessage());
        }
        return cn;
    }
    
    public static void main(String[] args) {
        Conexion cn = new Conexion();
        cn.getConexion();
    }

}