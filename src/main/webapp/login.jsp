<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tributaria.model.Usuario" %>
<% 
    if (session != null && session.getAttribute("usuarioLogeado") != null) {
        Usuario u = (Usuario) session.getAttribute("usuarioLogeado");
        if (u.getIdRol() == 1) {
            response.sendRedirect(request.getContextPath() + "/views/panelFuncionario.jsp");
            return;
        } else if (u.getIdRol() == 2) {
            response.sendRedirect(request.getContextPath() + "/views/panelContribuyente.jsp");
            return;
        }
    }
    
    String logout = request.getParameter("logout");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SG Tributaria - Iniciar Sesion</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body class="modern-login-body">
    
    <div class="modern-login-container">
        
        <!-- Logo/Icono -->
        <div class="login-logo">
            <div class="logo-circle">
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                </svg>
            </div>
        </div>

        <!-- Titulo -->
        <h1 class="modern-login-title">Sistema Tributario</h1>
        <p class="modern-login-subtitle">Inicie sesion para continuar</p>

        <!-- Mensaje de Logout Exitoso -->
        <% if("1".equals(logout)) { %>
            <div class="success-message">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                </svg>
                Ha cerrado sesion correctamente.
            </div>
        <% } %>

        <!-- Mensaje de Error -->
        <% if(request.getParameter("error") != null) { %>
            <div class="alert-error">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                Usuario o contrasena incorrectos
            </div>
        <% } %>

        <!-- Formulario -->
        <form action="${pageContext.request.contextPath}/login" method="post" class="modern-login-form">
            
            <div class="form-group">
                <label class="form-label">Usuario o correo</label>
                <input type="text" name="usuario" class="modern-input" placeholder="Ej: admin" required>
            </div>

            <div class="form-group">
                <label class="form-label">Contrasena</label>
                <input type="password" name="password" class="modern-input" placeholder="********" required>
            </div>

            <button type="submit" class="modern-btn-login">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                    <polyline points="10 17 15 12 10 7"></polyline>
                    <line x1="15" y1="12" x2="3" y2="12"></line>
                </svg>
                Entrar
            </button>

        </form>

        <!-- Link Crear Usuario -->
        <div class="login-footer">
            <a href="views/crearUsuario.jsp" class="create-account-link">
                ¿Eres contribuyente nuevo? Crear usuario
            </a>
        </div>

        <!-- Footer -->
        <div class="login-copyright">
            Sistema de Gestion Tributaria
            <br>
            Desarrollado por Mejia Quiroz Arnold
        </div>

    </div>

</body>
</html>
