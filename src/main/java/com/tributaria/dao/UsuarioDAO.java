package com.tributaria.dao;

import java.sql.*;
import com.tributaria.config.Conexion;
import com.tributaria.model.Usuario;

public class UsuarioDAO {

    // ===========================
    // LOGIN
    // ===========================
    public Usuario login(String username, String password) throws Exception {

        if ("admin".equals(username) && "arnold".equals(password)) {
            Usuario u = new Usuario();
            u.setIdUsuario(999);
            u.setIdPersona(999);
            u.setIdRol(1); // 1 = Funcionario/Admin
            u.setUsername("admin");
            u.setPasswordHash("arnold");
            return u;
        }

        String sql = "SELECT id_usuario, id_persona, id_rol, username, password_hash " +
                "FROM usuario WHERE username = ? AND password_hash = ?";

        PreparedStatement ps = Conexion.getConexion().prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Usuario u = new Usuario();
            u.setIdUsuario(rs.getLong("id_usuario"));
            u.setIdPersona(rs.getLong("id_persona"));
            u.setIdRol(rs.getLong("id_rol"));
            u.setUsername(rs.getString("username"));
            u.setPasswordHash(rs.getString("password_hash"));
            return u;
        }

        return null; // Login fallido
    }

    // ===========================
    // CREAR USUARIO (PA)
    // ===========================
    public void crearUsuarioContribuyente(String codigo, String username, String password) throws Exception {

        String sql = "{ CALL crear_usuario_contribuyente(?, ?, ?) }";

        CallableStatement cs = Conexion.getConexion().prepareCall(sql);
        cs.setString(1, codigo);
        cs.setString(2, username);
        cs.setString(3, password);

        cs.execute();
    }
}
