package com.tributaria.dao;

import com.tributaria.model.Persona;
import com.tributaria.config.Conexion;
import java.sql.*;

public class PersonaDAO {

    public long insertar(Persona p) throws Exception {

        String sql = "INSERT INTO persona (nombres, apellidos, razon_social, tipo_persona_id) " +
                     "VALUES (?, ?, ?, ?)";

        PreparedStatement ps = Conexion.getConexion().prepareStatement(
                sql, Statement.RETURN_GENERATED_KEYS
        );

        ps.setString(1, p.getNombres());
        ps.setString(2, p.getApellidos());

        // Manejo correcto de null
        if (p.getRazonSocial() == null || p.getRazonSocial().isEmpty()) {
            ps.setNull(3, Types.VARCHAR);
        } else {
            ps.setString(3, p.getRazonSocial());
        }

        ps.setInt(4, p.getTipoPersonaId());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getLong(1);
        }
        return -1;
    }
}
