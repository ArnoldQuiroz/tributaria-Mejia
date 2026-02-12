package com.tributaria.controladores;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

import com.tributaria.Negocio.LoginService;
import com.tributaria.model.Usuario;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("usuarioLogeado") != null) {
            Usuario u = (Usuario) session.getAttribute("usuarioLogeado");
            redireccionarPorRol(u, req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String user = req.getParameter("usuario");
        String pass = req.getParameter("password");

        try {
            LoginService service = new LoginService();
            Usuario u = service.login(user, pass);

            if (u != null) {
                HttpSession session = req.getSession();
                session.setAttribute("usuarioLogeado", u);
                redireccionarPorRol(u, req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=credenciales");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=500");
        }
    }

    private void redireccionarPorRol(Usuario u, HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        if (u.getIdRol() == 1) {
            resp.sendRedirect(req.getContextPath() + "/views/panelFuncionario.jsp");
        } else if (u.getIdRol() == 2) {
            resp.sendRedirect(req.getContextPath() + "/views/panelContribuyente.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=rol");
        }
    }
}
