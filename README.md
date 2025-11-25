<div align="center">
  <h1 align="center">🛒 Sistema de E-Commerce & Gestión de Inventario</h1>
  <h3>Proyecto Integral de Tienda Web con Panel Administrativo</h3>

  <p align="center">
    <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white" />
    <img src="https://img.shields.io/badge/JSP-Servlet-orange?style=for-the-badge" />
    <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" />
    <img src="https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white" />
    <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black" />
  </p>

  <img src="ruta/a/tu/imagen_collage.jpg" alt="Vista Previa del Proyecto" width="100%">
</div>

---

## 📖 Descripción del Proyecto

Este proyecto es una solución completa de **Comercio Electrónico (E-Commerce)** desarrollada bajo la arquitectura **MVC (Modelo-Vista-Controlador)**. 

El sistema permite a los usuarios navegar por un catálogo de productos y realizar pedidos, mientras que los administradores cuentan con un **Dashboard robusto** para gestionar todo el negocio: desde el control de stock y proveedores hasta la administración de usuarios y reportes.

## 🚀 Características Principales

### 🛍️ Módulo Cliente (Frontend)
* **Catálogo Dinámico:** Visualización de productos con imágenes, precios y stock en tiempo real.
* **Contacto Directo:** Integración con **WhatsApp API** y **Correo Electrónico** para consultas rápidas.
* **Ubicación:** Enlaces directos a Google Maps para localizar tiendas o proveedores.
* **Diseño Responsive:** Interfaz moderna y adaptable a móviles (Mobile-First) usando Bootstrap 5.

### 🛠️ Panel Administrativo (Backend)
* **Dashboard Interactivo:** Métricas en tiempo real (Total productos, Stock bajo, Categorías).
* **Gestión de Productos (CRUD):** Agregar, editar (con Modal), eliminar y actualizar stock.
* **Gestión de Proveedores:** Base de datos de proveedores con botones de acción rápida (Llamar, WSP, Correo).
* **Control de Usuarios:** Administración de roles y accesos.
* **Modo Oscuro/Claro:** Funcionalidad de cambio de tema con persistencia.

---

## 🛠️ Tecnologías Utilizadas

| Área | Tecnología |
| :--- | :--- |
| **Backend** | Java (JDK 8+), JSP (JavaServer Pages), Servlets |
| **Frontend** | HTML5, CSS3, JavaScript (ES6), Bootstrap 5 |
| **Base de Datos** | MySQL (Uso intensivo de **Stored Procedures**) |
| **Patrón** | MVC (Modelo Vista Controlador) + DAO (Data Access Object) |
| **Herramientas** | Git, NetBeans/Eclipse, Apache Tomcat |

---

## 📸 Galería de Capturas

> El sistema cuenta con múltiples interfaces diseñadas para la mejor experiencia de usuario.

| Login / Registro | Panel Administrativo |
| :---: | :---: |
| <img src="ruta/a/login.jpg" width="400"> | <img src="ruta/a/dashboard.jpg" width="400"> |
| *Acceso seguro con roles* | *Gestión centralizada* |

| Gestión de Productos | Lista de Proveedores |
| :---: | :---: |
| <img src="ruta/a/productos.jpg" width="400"> | <img src="ruta/a/proveedores.jpg" width="400"> |
| *Edición modal y control de stock* | *Acciones rápidas de contacto* |

*(Nota: Las imágenes son referenciales del proyecto actual)*

---

## 💾 Instalación y Despliegue

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/JAIMES4224D/Tienda_Web.git](https://github.com/JAIMES4224D/Tienda_Web.git)
    ```
2.  **Base de Datos:**
    * Importar el archivo `.sql` ubicado en la carpeta `/db` en tu gestor MySQL.
    * Asegurarse de que los **Procedimientos Almacenados** (`insertar_proveedor`, `actualizar_stock`, etc.) se ejecuten correctamente.
3.  **Configuración:**
    * Abrir el proyecto en NetBeans o Eclipse.
    * Configurar la conexión a la BD en la clase `Conexion.java`.
4.  **Ejecutar:**
    * Desplegar sobre servidor **Apache Tomcat**.

---

## ✒️ Autor

**Jeferson Jaimes** *Desarrollador Full Stack Java*

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/JAIMES4224D)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/tu-usuario) 

---
<div align="center">
  <sub>Desarrollado con ❤️ y mucho café ☕</sub>
</div>
