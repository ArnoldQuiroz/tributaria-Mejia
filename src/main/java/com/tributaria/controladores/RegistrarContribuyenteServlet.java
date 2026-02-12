package com.tributaria.controladores;

import com.tributaria.Negocio.ContribuyenteService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/RegistrarContribuyenteServlet")
public class RegistrarContribuyenteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nombres = req.getParameter("nombres");
        String apellidos = req.getParameter("apellidos");
        String razonSocial = req.getParameter("razon_social");
        String tipoPersonaStr = req.getParameter("tipo_persona");

        int tipoPersona = Integer.parseInt(tipoPersonaStr); // 1 = Natural, 2 = Jurídica

        try {
            ContribuyenteService service = new ContribuyenteService();

            // Registrar contribuyente (service manejará natural / jurídica)
            String codigoGenerado = service.registrarContribuyente(
                    nombres,
                    apellidos,
                    razonSocial,
                    tipoPersona);

            // Guardamos mensaje en sesión
            HttpSession session = req.getSession();
            session.setAttribute("msg_exito",
                    "Contribuyente registrado correctamente. Código generado: " + codigoGenerado);

            resp.sendRedirect("views/agregarContribuyente.jsp");

        } catch (Exception e) {
            e.printStackTrace();

            HttpSession session = req.getSession();
            session.setAttribute("msg_error",
                    "Error al registrar contribuyente: " + e.getMessage());

            resp.sendRedirect("views/agregarContribuyente.jsp");
        }
    }
}
