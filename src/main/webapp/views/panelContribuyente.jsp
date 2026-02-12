<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<link rel="stylesheet" href="css/styles.css">

<div class="content">
    <h2>Bienvenido Contribuyente</h2>

    <div class="card">
        <h3>Tu información</h3>
        <p>Nombre: ${sessionScope.usuarioLogeado.username}</p>
        <p>ID Persona: ${sessionScope.usuarioLogeado.idPersona}</p>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
