<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="sidebar-logo">
        <h2>SG Tributaria</h2>
    </div>

    <a href="${pageContext.request.contextPath}/views/panelFuncionario.jsp">
        Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/views/registrarPago.jsp">
        Registrar Pago
    </a>

    <a href="${pageContext.request.contextPath}/views/verPagos.jsp">
        Ver Pagos
    </a>

    <a href="${pageContext.request.contextPath}/views/agregarContribuyente.jsp">
        Registrar Contribuyente
    </a>

    <a href="${pageContext.request.contextPath}/ListarContribuyentesServlet">
        Listar Contribuyentes
    </a>

    <a href="${pageContext.request.contextPath}/LogoutServlet" style="margin-top: 20px; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 20px;">
        Cerrar Sesion
    </a>
</div>