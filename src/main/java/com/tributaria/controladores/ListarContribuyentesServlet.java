package com.tributaria.controladores;

import com.tributaria.dao.ContribuyenteDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/ListarContribuyentesServlet")
public class ListarContribuyentesServlet extends HttpServlet {

    private static final int REGISTROS_POR_PAGINA = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Verificar sesion
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuarioLogeado") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Obtener parametros
            String paginaParam = req.getParameter("pagina");
            String busqueda = req.getParameter("busqueda");
            
            int paginaActual = 1;
            if (paginaParam != null && !paginaParam.isEmpty()) {
                try {
                    paginaActual = Integer.parseInt(paginaParam);
                    if (paginaActual < 1) paginaActual = 1;
                } catch (NumberFormatException e) {
                    paginaActual = 1;
                }
            }
            
            if (busqueda == null) {
                busqueda = "";
            }
            
            ContribuyenteDAO dao = new ContribuyenteDAO();
            
            // Obtener lista con paginacion
            List<Map<String, Object>> lista = dao.listarConPaginacion(
                paginaActual, 
                REGISTROS_POR_PAGINA, 
                busqueda
            );
            
            // Obtener total de registros
            int totalRegistros = dao.contarContribuyentes(busqueda);
            int totalPaginas = (int) Math.ceil((double) totalRegistros / REGISTROS_POR_PAGINA);
            
            // Establecer atributos
            req.setAttribute("lista", lista);
            req.setAttribute("paginaActual", paginaActual);
            req.setAttribute("totalPaginas", totalPaginas);
            req.setAttribute("totalRegistros", totalRegistros);
            req.setAttribute("busqueda", busqueda);
            
            req.getRequestDispatcher("views/listar.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("views/panelFuncionario.jsp?error=1");
        }
    }
}
