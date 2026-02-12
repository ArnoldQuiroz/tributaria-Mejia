package com.tributaria.controladores;

import com.tributaria.dao.UsuarioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/CrearUsuarioServlet")
public class CrearUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String codigo = req.getParameter("codigo");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            UsuarioDAO dao = new UsuarioDAO();
            dao.crearUsuarioContribuyente(codigo, username, password);

            HttpSession session = req.getSession();
            session.setAttribute("msg_exito", "Usuario creado correctamente. Ya puedes iniciar sesión.");

            resp.sendRedirect("views/crearUsuario.jsp");

        } catch (Exception e) {

            HttpSession session = req.getSession();
            session.setAttribute("msg_error", e.getMessage());

            resp.sendRedirect("views/crearUsuario.jsp");
        }
    }
}