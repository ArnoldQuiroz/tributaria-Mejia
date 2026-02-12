<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario - Contribuyente</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>

<div class="form-container">
    <h2>Crear Usuario</h2>

    <!-- Mensaje de error -->
    <c:if test="${not empty sessionScope.msg_error}">
        <p style="color:red; font-weight:bold;">
            ${sessionScope.msg_error}
        </p>
        <c:remove var="msg_error" scope="session"/>
    </c:if>

    <!-- Mensaje de éxito -->
    <c:if test="${not empty sessionScope.msg_exito}">
        <p style="color:green; font-weight:bold;">
            ${sessionScope.msg_exito}
        </p>
        <c:remove var="msg_exito" scope="session"/>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/CrearUsuarioServlet">

        <label>Código de contribuyente</label>
        <input type="text" name="codigo" required>

        <label>Nombre de usuario</label>
        <input type="text" name="username" required>

        <label>Contraseña</label>
        <input type="password" name="password" required>

        <button type="submit">Crear Cuenta</button>
    </form>

</div>

</body>
</html>
