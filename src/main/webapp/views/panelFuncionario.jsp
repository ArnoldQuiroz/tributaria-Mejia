<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Funcionario - SG Tributaria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>
    <%@ include file="/includes/header.jsp" %>
    <%@ include file="/includes/navbar.jsp" %>

    <div class="content">
        <h2>Panel del Funcionario</h2>
        <p class="content-subtitle">Bienvenido al sistema de gestión tributaria</p>

        <div class="dashboard-grid">
            <!-- Card Contribuyentes -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon">
                        C
                    </div>
                </div>
                <h3>Contribuyentes Registrados</h3>
                <p class="card-value">${cantidadContribuyentes != null ? cantidadContribuyentes : 0}</p>
                <div class="card-footer">
                    <span class="card-badge">Activos</span>
                    <span>Total en sistema</span>
                </div>
            </div>

            <!-- Card Usuarios -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon secondary">
                        U
                    </div>
                </div>
                <h3>Usuarios Creados</h3>
                <p class="card-value">${cantidadUsuarios != null ? cantidadUsuarios : 0}</p>
                <div class="card-footer">
                    <span class="card-badge">Registrados</span>
                    <span>Usuarios del sistema</span>
                </div>
            </div>

            <!-- Card Pagos -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon accent">
                        P
                    </div>
                </div>
                <h3>Pagos Procesados</h3>
                <p class="card-value">${cantidadPagos != null ? cantidadPagos : 0}</p>
                <div class="card-footer">
                    <span class="card-badge">Completados</span>
                    <span>Este mes</span>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
</body>
</html>

