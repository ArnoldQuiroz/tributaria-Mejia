<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Contribuyente</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>

<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<div class="form-container">
    <h2>Registrar Contribuyente</h2>

    <!-- Mostrar mensajes -->
    <%
        String exito = (String) session.getAttribute("msg_exito");
        String error = (String) session.getAttribute("msg_error");

        if (exito != null) {
    %>
        <p style="color: green; font-weight: bold;"><%= exito %></p>
    <%
            session.removeAttribute("msg_exito");
        }

        if (error != null) {
    %>
        <p style="color: red; font-weight: bold;"><%= error %></p>
    <%
            session.removeAttribute("msg_error");
        }
    %>

    <form method="post" action="${pageContext.request.contextPath}/RegistrarContribuyenteServlet">

        <label>Nombres</label>
        <input type="text" name="nombres" required>

        <label>Apellidos</label>
        <input type="text" name="apellidos" required>

        <label>Razón Social (solo jurídica)</label>
        <input type="text" name="razon_social">

        <label>Tipo de Persona</label>
        <select name="tipo_persona" required>
            <option value="1">Natural</option>
            <option value="2">Jurídica</option>
        </select>

        <button type="submit">Registrar</button>
    </form>
</div>

<%@ include file="/includes/footer.jsp" %>
</body>
</html>
