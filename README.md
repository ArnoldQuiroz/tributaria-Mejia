# 🏛️ Sistema de Gestión Tributaria

Sistema web para la gestión integral de contribuyentes y pagos tributarios.

## 📋 Descripción

Sistema de Gestión Tributaria es una aplicación web desarrollada en Java que permite administrar contribuyentes, registrar pagos y realizar consultas con búsqueda avanzada y paginación.

## ✨ Características Principales

### 🔐 Sistema de Autenticación
- Login seguro con gestión de sesiones
- Protección de rutas privadas
- Cierre de sesión con mensaje de confirmación
- Validación de credenciales en tiempo real

### 👥 Gestión Completa de Contribuyentes
- ✅ **Registro de personas naturales y jurídicas**
- ✅ **Búsqueda Avanzada**: Búsqueda multi-campo (nombre, apellido, código, razón social)
- ✅ **Paginación Inteligente**: 
  - Exactamente 10 registros por página
  - Navegación con botones Anterior/Siguiente
  - Números de página clickeables
  - Indicador visual de página actual
  - Contador de resultados: "Mostrando X de Y registros"
  - Persistencia de búsqueda entre páginas
- ✅ **Interfaz moderna con efectos hover**
- ✅ **Badges coloridos** por tipo de contribuyente

### 💰 Gestión de Pagos
- Registro de pagos tributarios
- Consulta de historial de pagos
- Validación de datos

### 🎨 Diseño Moderno y Profesional
- **Interfaz 100% Responsive** para todos los dispositivos
- **Animaciones CSS** suaves y profesionales
- **Efectos visuales** al pasar el mouse
- **Paleta de colores** moderna (gradientes morado-violeta)
- **Iconos SVG** integrados
- **Panel único** para listado de contribuyentes

## 🛠️ Tecnologías Utilizadas

### Backend
- **Java 8** - Lenguaje de programación
- **Servlets** - Lógica de negocio
- **JSP** - Vistas dinámicas
- **JDBC** - Conexión a base de datos
- **MySQL** - Base de datos

### Frontend
- **HTML5** - Estructura
- **CSS3** - Estilos y animaciones
- **JavaScript** - Interactividad
- **Responsive Design** - Adaptable a todos los dispositivos

### Herramientas
- **Maven** - Gestión de dependencias
- **Apache Tomcat 9** - Servidor de aplicaciones
- **Git** - Control de versiones

## 📦 Instalación

### Requisitos Previos
- Java JDK 8 o superior
- Apache Tomcat 9.0
- MySQL 8.0
- Maven 3.6+

### Configuración de Base de Datos

1. Crear la base de datos:
```sql
CREATE DATABASE tributo;
```

2. Ejecutar los scripts SQL necesarios (crear tablas, procedimientos almacenados, etc.)

3. Configurar la conexión en `src/main/java/com/tributaria/config/Conexion.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/tributo";
private static final String USER = "root";
private static final String PASS = "tu_password";
```

### Despliegue

1. Clonar el repositorio:
```bash
git clone https://github.com/ArnoldQuiroz/tributaria-Mejia.git
cd tributaria-Mejia
```

2. Compilar el proyecto:
```bash
mvn clean package
```

3. Copiar el WAR a Tomcat:
```bash
copy target\tributaria.war C:\Tomcat 9.0\webapps\
```

4. Iniciar Tomcat y acceder a:
```
http://localhost:8080/tributaria/
```

## 👤 Credenciales de Prueba

Usuario: `admin`
Contraseña: `(configurar según tu BD)`

## 📸 Capturas de Pantalla

### Login
- Diseño moderno con gradiente morado
- Mensajes de éxito al cerrar sesión
- Validación de credenciales

### Dashboard
- Cards con estadísticas
- Interfaz intuitiva
- Navegación clara

### Listado de Contribuyentes
- Búsqueda avanzada
- Paginación de 10 registros
- Filtros en tiempo real
- Badges coloridos por tipo

## 🏗️ Estructura del Proyecto

```
tributaria/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── tributaria/
│       │           ├── config/         # Configuración
│       │           ├── controladores/  # Servlets
│       │           ├── dao/            # Acceso a datos
│       │           ├── model/          # Modelos
│       │           └── Negocio/        # Lógica de negocio
│       └── webapp/
│           ├── css/                    # Estilos
│           ├── includes/               # Componentes reutilizables
│           ├── views/                  # Vistas JSP
│           ├── WEB-INF/                # Configuración web
│           └── login.jsp               # Página de inicio
├── pom.xml                             # Dependencias Maven
└── README.md                           # Este archivo
```

## 🚀 Funcionalidades Principales

### 📄 Sistema de Paginación Completo
Implementación profesional con las siguientes características:

- ✅ **Límite de registros**: Exactamente 10 registros por página
- ✅ **Navegación intuitiva**: Botones "Anterior" y "Siguiente"
- ✅ **Números de página**: Click directo en cualquier página (1, 2, 3...)
- ✅ **Página actual destacada**: Con gradiente morado
- ✅ **Puntos suspensivos**: Para muchas páginas (1 ... 5 6 7 ... 20)
- ✅ **Contador de resultados**: "Mostrando 10 de 50 registros"
- ✅ **Badge informativo**: "10 por página"
- ✅ **Persistencia**: La búsqueda se mantiene al cambiar de página
- ✅ **Cálculo automático**: Total de páginas basado en registros
- ✅ **Responsive**: Adaptado para móviles y tablets

**Tecnología Backend:**
```java
// Servlet con parámetros de paginación
int paginaActual = request.getParameter("pagina");
int registrosPorPagina = 10;
int offset = (paginaActual - 1) * registrosPorPagina;

// DAO con LIMIT y OFFSET
SELECT * FROM contribuyente 
WHERE nombre LIKE ? 
ORDER BY id DESC 
LIMIT ? OFFSET ?
```

**Tecnología Frontend:**
- JSP con lógica de paginación
- CSS con efectos hover
- Navegación dinámica generada

### 🔍 Sistema de Búsqueda Avanzada
- Búsqueda por múltiples campos simultáneamente
- Resultados filtrados en tiempo real
- Búsqueda persistente entre páginas
- Panel de búsqueda con animación
- Icono animado con efecto pulso

### 🔐 Seguridad
- Protección de sesiones en todos los Servlets
- Validación de credenciales
- Redirección automática al login si no está autenticado
- Gestión segura de sesiones HTTP

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add: AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto fue desarrollado como parte de un proyecto académico.

## 👨‍💻 Autor

**Mejia Quiroz Arnold**

- GitHub: [@ArnoldQuiroz](https://github.com/ArnoldQuiroz)
- Email: arnoldquiroz@example.com

## 🙏 Agradecimientos

- A los profesores y mentores que guiaron este proyecto
- A la comunidad de desarrolladores por sus recursos

---

⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub

**Desarrollado con ❤️ para la gestión eficiente de tributos**
