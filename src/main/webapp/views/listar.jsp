<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Contribuyentes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>

<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<div class="content list-page">
    
    <%
        List<Map<String, Object>> lista = (List<Map<String, Object>>) request.getAttribute("lista");
        Integer paginaActual = (Integer) request.getAttribute("paginaActual");
        Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
        Integer totalRegistros = (Integer) request.getAttribute("totalRegistros");
        String busquedaActual = (String) request.getAttribute("busqueda");
        
        if (paginaActual == null) paginaActual = 1;
        if (totalPaginas == null) totalPaginas = 1;
        if (totalRegistros == null) totalRegistros = 0;
        if (busquedaActual == null) busquedaActual = "";
    %>

    <!-- Header Personalizado con Efecto -->
    <div class="list-header-custom">
        <div class="header-glass-effect"></div>
        <div class="header-content-wrapper">
            <div class="header-icon-box">
                <svg width="40" height="40" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                </svg>
            </div>
            <div class="header-text-area">
                <h1 class="custom-page-title">Gestion de Contribuyentes</h1>
                <p class="custom-page-subtitle">Sistema integral de busqueda y administracion</p>
            </div>
            <div class="header-counter">
                <span class="counter-number"><%= totalRegistros %></span>
                <span class="counter-label">Registrados</span>
            </div>
        </div>
    </div>

    <!-- Panel de Busqueda Unico -->
    <div class="unique-search-panel">
        <div class="search-panel-decoration"></div>
        <div class="search-panel-body">
            <div class="search-icon-holder">
                <div class="animated-search-icon">
                    <svg width="32" height="32" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"/>
                    </svg>
                </div>
            </div>
            
            <div class="search-main-area">
                <h3 class="search-title-unique">Busqueda Avanzada</h3>
                <p class="search-description">Encuentra contribuyentes por nombre, apellido, codigo o razon social</p>
                
                <form action="${pageContext.request.contextPath}/ListarContribuyentesServlet" method="get" class="modern-search-form">
                    <div class="search-input-container">
                        <svg class="search-prefix-icon" width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"/>
                        </svg>
                        <input type="text" 
                               name="busqueda" 
                               class="modern-search-input" 
                               placeholder="Escribe para buscar..." 
                               value="<%= busquedaActual %>">
                        <button type="submit" class="modern-search-button">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"/>
                            </svg>
                            Buscar
                        </button>
                    </div>
                    <% if (!busquedaActual.isEmpty()) { %>
                    <div class="search-filter-active">
                        <span class="filter-text">Filtrando por: "<strong><%= busquedaActual %></strong>"</span>
                        <a href="${pageContext.request.contextPath}/ListarContribuyentesServlet" class="clear-filter">
                            <svg width="16" height="16" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                            </svg>
                            Limpiar
                        </a>
                    </div>
                    <% } %>
                </form>
                
                <!-- Estadisticas -->
                <div class="stats-row">
                    <div class="stat-box">
                        <span class="stat-value"><%= lista != null ? lista.size() : 0 %></span>
                        <span class="stat-name">Mostrando</span>
                    </div>
                    <div class="stat-separator"></div>
                    <div class="stat-box">
                        <span class="stat-value"><%= totalRegistros %></span>
                        <span class="stat-name">Total</span>
                    </div>
                    <div class="stat-separator"></div>
                    <div class="stat-box highlighted">
                        <span class="stat-value">10</span>
                        <span class="stat-name">Por Pagina</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla con Diseño Moderno -->
    <div class="modern-table-wrapper">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Codigo</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Razon Social</th>
                    <th>Tipo</th>
                </tr>
            </thead>
            <tbody>
                <% if (lista != null && !lista.isEmpty()) {
                    for (Map<String, Object> c : lista) { %>
                    <tr class="table-row-hover">
                        <td><%= c.get("id") %></td>
                        <td><span class="badge badge-code"><%= c.get("codigo") %></span></td>
                        <td><%= c.get("nombres") != null ? c.get("nombres") : "-" %></td>
                        <td><%= c.get("apellidos") != null ? c.get("apellidos") : "-" %></td>
                        <td><%= c.get("razon") != null ? c.get("razon") : "-" %></td>
                        <td>
                            <% if ("1".equals(c.get("tipo").toString())) { %>
                                <span class="badge badge-natural">Natural</span>
                            <% } else { %>
                                <span class="badge badge-juridica">Juridica</span>
                            <% } %>
                        </td>
                    </tr>
                <% } 
                } else { %>
                    <tr>
                        <td colspan="6" class="no-data">
                            <div class="no-data-message">
                                <svg width="64" height="64" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                </svg>
                                <h4>Sin Resultados</h4>
                                <p>No se encontraron contribuyentes con los criterios de busqueda</p>
                                <% if (!busquedaActual.isEmpty()) { %>
                                    <a href="${pageContext.request.contextPath}/ListarContribuyentesServlet" class="btn-link">Ver Todos</a>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Paginacion Mejorada -->
    <% if (totalPaginas > 1) { %>
    <div class="custom-pagination">
        <% if (paginaActual > 1) { %>
            <a href="?pagina=<%= paginaActual - 1 %>&busqueda=<%= busquedaActual %>" class="pag-btn pag-prev">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                </svg>
                Anterior
            </a>
        <% } %>
        
        <div class="pag-numbers">
            <% 
            int inicio = Math.max(1, paginaActual - 2);
            int fin = Math.min(totalPaginas, paginaActual + 2);
            
            if (inicio > 1) { %>
                <a href="?pagina=1&busqueda=<%= busquedaActual %>" class="pag-num">1</a>
                <% if (inicio > 2) { %>
                    <span class="pag-dots">...</span>
                <% } %>
            <% }
            
            for (int i = inicio; i <= fin; i++) { 
                if (i == paginaActual) { %>
                    <span class="pag-num active"><%= i %></span>
                <% } else { %>
                    <a href="?pagina=<%= i %>&busqueda=<%= busquedaActual %>" class="pag-num"><%= i %></a>
                <% } 
            }
            
            if (fin < totalPaginas) {
                if (fin < totalPaginas - 1) { %>
                    <span class="pag-dots">...</span>
                <% } %>
                <a href="?pagina=<%= totalPaginas %>&busqueda=<%= busquedaActual %>" class="pag-num"><%= totalPaginas %></a>
            <% } %>
        </div>
        
        <% if (paginaActual < totalPaginas) { %>
            <a href="?pagina=<%= paginaActual + 1 %>&busqueda=<%= busquedaActual %>" class="pag-btn pag-next">
                Siguiente
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"/>
                </svg>
            </a>
        <% } %>
    </div>
    <% } %>

</div>

<%@ include file="/includes/footer.jsp" %>
</body>
</html>
