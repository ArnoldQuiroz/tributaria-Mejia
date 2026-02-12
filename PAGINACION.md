# 📄 Sistema de Paginación - Documentación Técnica

## 🎯 Descripción General

Este proyecto implementa un **sistema completo de paginación** para la lista de contribuyentes, mostrando exactamente **10 registros por página** con navegación intuitiva y búsqueda persistente.

---

## ✨ Características Implementadas

### 1. **Límite de Registros**
- ✅ 10 registros exactos por página
- ✅ Cálculo automático de páginas totales
- ✅ Contador de resultados visible

### 2. **Navegación**
- ✅ Botones "Anterior" y "Siguiente"
- ✅ Números de página clickeables (1, 2, 3...)
- ✅ Página actual resaltada con gradiente
- ✅ Puntos suspensivos para muchas páginas

### 3. **Búsqueda Integrada**
- ✅ La búsqueda se mantiene al cambiar de página
- ✅ Filtros persistentes en la URL
- ✅ Contador actualizado según filtros

---

## 🔧 Implementación Técnica

### Backend (Java)

#### **ContribuyenteDAO.java**
```java
// Método con paginación
public List<Map<String, Object>> listarConPaginacion(
    int pagina, 
    int registrosPorPagina, 
    String busqueda
) throws Exception {
    
    int offset = (pagina - 1) * registrosPorPagina;
    
    StringBuilder sql = new StringBuilder(
        "SELECT c.id_contribuyente, c.codigo_contribuyente, " +
        "p.nombres, p.apellidos, p.razon_social, p.tipo_persona_id " +
        "FROM contribuyente c " +
        "INNER JOIN persona p ON c.id_persona = p.id_persona " +
        "WHERE 1=1 "
    );
    
    // Agregar filtro de búsqueda si existe
    if (busqueda != null && !busqueda.trim().isEmpty()) {
        sql.append("AND (p.nombres LIKE ? OR p.apellidos LIKE ? " +
                   "OR c.codigo_contribuyente LIKE ? OR p.razon_social LIKE ?) ");
    }
    
    // Ordenar y aplicar LIMIT/OFFSET
    sql.append("ORDER BY c.id_contribuyente DESC LIMIT ? OFFSET ?");
    
    PreparedStatement ps = Conexion.getConexion().prepareStatement(sql.toString());
    
    int paramIndex = 1;
    if (busqueda != null && !busqueda.trim().isEmpty()) {
        String searchPattern = "%" + busqueda + "%";
        ps.setString(paramIndex++, searchPattern);
        ps.setString(paramIndex++, searchPattern);
        ps.setString(paramIndex++, searchPattern);
        ps.setString(paramIndex++, searchPattern);
    }
    
    ps.setInt(paramIndex++, registrosPorPagina);
    ps.setInt(paramIndex, offset);
    
    ResultSet rs = ps.executeQuery();
    // ... procesar resultados
}

// Método para contar total de registros
public int contarContribuyentes(String busqueda) throws Exception {
    StringBuilder sql = new StringBuilder(
        "SELECT COUNT(*) FROM contribuyente c " +
        "INNER JOIN persona p ON c.id_persona = p.id_persona " +
        "WHERE 1=1 "
    );
    
    if (busqueda != null && !busqueda.trim().isEmpty()) {
        sql.append("AND (p.nombres LIKE ? OR p.apellidos LIKE ? " +
                   "OR c.codigo_contribuyente LIKE ? OR p.razon_social LIKE ?)");
    }
    
    PreparedStatement ps = Conexion.getConexion().prepareStatement(sql.toString());
    
    if (busqueda != null && !busqueda.trim().isEmpty()) {
        String searchPattern = "%" + busqueda + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        ps.setString(3, searchPattern);
        ps.setString(4, searchPattern);
    }
    
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        return rs.getInt(1);
    }
    return 0;
}
```

#### **ListarContribuyentesServlet.java**
```java
@WebServlet("/ListarContribuyentesServlet")
public class ListarContribuyentesServlet extends HttpServlet {

    private static final int REGISTROS_POR_PAGINA = 10;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        // Verificar sesión
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuarioLogeado") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Obtener parámetros
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
            
            if (busqueda == null) busqueda = "";
            
            ContribuyenteDAO dao = new ContribuyenteDAO();
            
            // Obtener datos con paginación
            List<Map<String, Object>> lista = dao.listarConPaginacion(
                paginaActual, 
                REGISTROS_POR_PAGINA, 
                busqueda
            );
            
            // Calcular total de páginas
            int totalRegistros = dao.contarContribuyentes(busqueda);
            int totalPaginas = (int) Math.ceil((double) totalRegistros / REGISTROS_POR_PAGINA);
            
            // Enviar datos a la vista
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
```

---

### Frontend (JSP)

#### **listar.jsp - Paginación**
```jsp
<%
    // Obtener datos del servlet
    Integer paginaActual = (Integer) request.getAttribute("paginaActual");
    Integer totalPaginas = (Integer) request.getAttribute("totalPaginas");
    String busquedaActual = (String) request.getAttribute("busqueda");
    
    if (paginaActual == null) paginaActual = 1;
    if (totalPaginas == null) totalPaginas = 1;
    if (busquedaActual == null) busquedaActual = "";
%>

<!-- Paginación -->
<% if (totalPaginas > 1) { %>
<div class="custom-pagination">
    <!-- Botón Anterior -->
    <% if (paginaActual > 1) { %>
        <a href="?pagina=<%= paginaActual - 1 %>&busqueda=<%= busquedaActual %>" 
           class="pag-btn pag-prev">
            Anterior
        </a>
    <% } %>
    
    <!-- Números de página -->
    <div class="pag-numbers">
        <% 
        int inicio = Math.max(1, paginaActual - 2);
        int fin = Math.min(totalPaginas, paginaActual + 2);
        
        // Primera página
        if (inicio > 1) { %>
            <a href="?pagina=1&busqueda=<%= busquedaActual %>" class="pag-num">1</a>
            <% if (inicio > 2) { %>
                <span class="pag-dots">...</span>
            <% } %>
        <% }
        
        // Rango de páginas
        for (int i = inicio; i <= fin; i++) { 
            if (i == paginaActual) { %>
                <span class="pag-num active"><%= i %></span>
            <% } else { %>
                <a href="?pagina=<%= i %>&busqueda=<%= busquedaActual %>" 
                   class="pag-num"><%= i %></a>
            <% } 
        }
        
        // Última página
        if (fin < totalPaginas) {
            if (fin < totalPaginas - 1) { %>
                <span class="pag-dots">...</span>
            <% } %>
            <a href="?pagina=<%= totalPaginas %>&busqueda=<%= busquedaActual %>" 
               class="pag-num"><%= totalPaginas %></a>
        <% } %>
    </div>
    
    <!-- Botón Siguiente -->
    <% if (paginaActual < totalPaginas) { %>
        <a href="?pagina=<%= paginaActual + 1 %>&busqueda=<%= busquedaActual %>" 
           class="pag-btn pag-next">
            Siguiente
        </a>
    <% } %>
</div>
<% } %>
```

---

## 🎨 Estilos CSS

### Paginación Moderna
```css
.custom-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 12px;
    margin-top: 32px;
    padding: 24px;
    background: white;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
}

.pag-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 12px 24px;
    background: white;
    color: #667eea;
    text-decoration: none;
    border: 2px solid #667eea;
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.pag-btn:hover {
    background: #667eea;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
}

.pag-num {
    width: 44px;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: white;
    border: 2px solid #e2e8f0;
    border-radius: 12px;
    color: #64748b;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s ease;
}

.pag-num.active {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-color: transparent;
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

.pag-dots {
    color: #cbd5e1;
    font-weight: 700;
    padding: 0 8px;
}
```

---

## 📊 Ejemplo de Funcionamiento

### Escenario: 45 Contribuyentes Totales

**Página 1:**
- Muestra: Contribuyentes 1-10
- URL: `?pagina=1`
- Botones: [1] 2 3 4 5 → Siguiente

**Página 3:**
- Muestra: Contribuyentes 21-30
- URL: `?pagina=3`
- Botones: ← Anterior 1 2 [3] 4 5 → Siguiente

**Página 5:**
- Muestra: Contribuyentes 41-45 (solo 5)
- URL: `?pagina=5`
- Botones: ← Anterior 1 2 3 4 [5]

### Con Búsqueda Activa

**URL:** `?pagina=2&busqueda=Juan`

- Busca "Juan" en: nombres, apellidos, código, razón social
- Muestra página 2 de los resultados filtrados
- Mantiene el filtro al navegar entre páginas

---

## 🔧 Configuración

### Cambiar Registros por Página

En `ListarContribuyentesServlet.java`:
```java
private static final int REGISTROS_POR_PAGINA = 10; // Cambiar aquí
```

---

## 📈 Ventajas de esta Implementación

1. ✅ **Rendimiento**: Solo carga 10 registros a la vez
2. ✅ **Escalabilidad**: Funciona con miles de registros
3. ✅ **UX**: Navegación intuitiva y rápida
4. ✅ **SEO**: URLs amigables con parámetros
5. ✅ **Persistencia**: Búsqueda se mantiene entre páginas
6. ✅ **Responsive**: Adaptado para móviles

---

## 🎯 Tecnologías Utilizadas

- **Java 8** - Lógica de paginación
- **JDBC** - Consultas con LIMIT/OFFSET
- **JSP** - Generación dinámica de HTML
- **CSS3** - Estilos modernos con animaciones
- **MySQL** - Base de datos

---

**Desarrollado por: Mejia Quiroz Arnold**
**Proyecto: Sistema de Gestión Tributaria**
