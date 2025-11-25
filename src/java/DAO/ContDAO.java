package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ContDAO {
    Conexion conexion = new Conexion();
    private Connection cn = conexion.getConexion();
    private PreparedStatement pt = null;
    private ResultSet rs = null;
    
    public int contarProductos() {
        int numProductos = 0;
        String sql = "SELECT COUNT(*) AS total FROM productos;";
        try {
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();

            // Mover el cursor a la primera fila del resultado
            if (rs.next()) {
                numProductos = rs.getInt("total");
            }

            System.out.println("Número de productos: " + numProductos);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return numProductos;
    }
    public int contarCategorias(){
        int num = 0;
        String sql = "SELECT COUNT(*) AS nn FROM categorias;";
        try{
            pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();
            
            if(rs.next()){
                num = rs.getInt("nn");
            }
            System.out.println("num = " + num);
        }catch(Exception e){
            e.printStackTrace();
        }
        return num;
    }
    public int contarClientes(){
        int num = 0;
        String sql = "SELECT COUNT(*) AS cc FROM usuarios WHERE rol = 'cliente'";
        try{
             pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();

            // Mover el cursor a la primera fila del resultado
            if (rs.next()) {
                num = rs.getInt("cc");
            }
            System.out.println("num = " + num);
        }catch(Exception e){
            e.printStackTrace();
        }
        return num;
    }
    public int contarAdmin(){
        int num = 0;
        String sql = "SELECT COUNT(*) AS cc FROM usuarios WHERE rol = 'admin'";
        try{
             pt = cn.prepareStatement(sql);
            rs = pt.executeQuery();

            // Mover el cursor a la primera fila del resultado
            if (rs.next()) {
                num = rs.getInt("cc");
            }
            System.out.println("num = " + num);
        }catch(Exception e){
            e.printStackTrace();
        }
        return num;
    }
    
 
}
