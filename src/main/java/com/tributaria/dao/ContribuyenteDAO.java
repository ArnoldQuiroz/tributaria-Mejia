package com.tributaria.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tributaria.config.Conexion;

public class ContribuyenteDAO {

    public void insertar(long idPersona, String codigo) throws Exception {

        String sql = "INSERT INTO contribuyente (id_persona, codigo_contribuyente) VALUES (?, ?)";

        PreparedStatement ps = Conexion.getConexion().prepareStatement(sql);
        ps.setLong(1, idPersona);
        ps.setString(2, codigo);

        int rows = ps.executeUpdate();

        if (rows == 0) {
            throw new Exception("No se pudo registrar el contribuyente");
        }
    }

    public boolean existeCodigo(String codigo) throws Exception {
        String sql = "SELECT COUNT(*) FROM contribuyente WHERE codigo_contribuyente = ?";
        PreparedStatement ps = Conexion.getConexion().prepareStatement(sql);
        ps.setString(1, codigo);

        ResultSet rs = ps.executeQuery();
        rs.next();
        return rs.getInt(1) > 0;
    }

    public List<Map<String, Object>> listarContribuyentes() throws Exception {

    String sql = "{ CALL listar_contribuyentes() }";
    CallableStatement cs = Conexion.getConexion().prepareCall(sql);

    ResultSet rs = cs.executeQuery();

    List<Map<String, Object>> lista = new ArrayList<>();

    while (rs.next()) {
        Map<String, Object> fila = new HashMap<>();
        fila.put("id", rs.getLong("id_contribuyente"));
        fila.put("codigo", rs.getString("codigo_contribuyente"));
        fila.put("nombres", rs.getString("nombres"));
        fila.put("apellidos", rs.getString("apellidos"));
        fila.put("razon", rs.getString("razon_social"));
        fila.put("tipo", rs.getInt("tipo_persona_id"));
        lista.add(fila);
    }

    return lista;
    }

    // Metodo con paginacion y busqueda
    public List<Map<String, Object>> listarConPaginacion(int pagina, int registrosPorPagina, String busqueda) throws Exception {
        int offset = (pagina - 1) * registrosPorPagina;
        
        StringBuilder sql = new StringBuilder(
            "SELECT c.id_contribuyente, c.codigo_contribuyente, " +
            "p.nombres, p.apellidos, p.razon_social, p.tipo_persona_id " +
            "FROM contribuyente c " +
            "INNER JOIN persona p ON c.id_persona = p.id_persona " +
            "WHERE 1=1 "
        );
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            sql.append("AND (p.nombres LIKE ? OR p.apellidos LIKE ? OR c.codigo_contribuyente LIKE ? OR p.razon_social LIKE ?) ");
        }
        
        sql.append("ORDER BY c.id_contribuyente DESC LIMIT ? OFFSET ?");
        
        PreparedStatement ps = Conexion.getConexion().prepareStatement(sql.toString());
        
        int paramIndex = 1;
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            String searchPattern = "%" + busqueda + "%";
            ps.setString(paramIndex++, searchPattern);
            ps.setString(paramIndex++, searchPattern);
            ps.setString(paramIndex++, searchPattern);
            ps.setString(paramIndex++, searchPattern);
        }
        
        ps.setInt(paramIndex++, registrosPorPagina);
        ps.setInt(paramIndex, offset);
        
        ResultSet rs = ps.executeQuery();
        List<Map<String, Object>> lista = new ArrayList<>();
        
        while (rs.next()) {
            Map<String, Object> fila = new HashMap<>();
            fila.put("id", rs.getLong("id_contribuyente"));
            fila.put("codigo", rs.getString("codigo_contribuyente"));
            fila.put("nombres", rs.getString("nombres"));
            fila.put("apellidos", rs.getString("apellidos"));
            fila.put("razon", rs.getString("razon_social"));
            fila.put("tipo", rs.getInt("tipo_persona_id"));
            lista.add(fila);
        }
        
        return lista;
    }
    
    // Contar total de registros
    public int contarContribuyentes(String busqueda) throws Exception {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM contribuyente c " +
            "INNER JOIN persona p ON c.id_persona = p.id_persona " +
            "WHERE 1=1 "
        );
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            sql.append("AND (p.nombres LIKE ? OR p.apellidos LIKE ? OR c.codigo_contribuyente LIKE ? OR p.razon_social LIKE ?)");
        }
        
        PreparedStatement ps = Conexion.getConexion().prepareStatement(sql.toString());
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            String searchPattern = "%" + busqueda + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
        }
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }
}
