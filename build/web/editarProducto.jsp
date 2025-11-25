<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.ProductoDTO"%>
<%@page import="Modelo.Categoria"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto - DonGlai LED</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        :root {
            --primary-color: #00e0ff;
            --secondary-color: #00a2ff;
            --dark-bg: #0d0d0d;
            --card-bg: #1a1a1a;
            --card-hover: #222222;
            --success-color: #00cc66;
            --warning-color: #ffc107;
            --danger-color: #ff4d4d;
            --text-color: #ffffff;
            --text-muted: #aaaaaa;
            --border-color: #333333;
        }

        .light-mode {
            --primary-color: #0066cc;
            --secondary-color: #0088ff;
            --dark-bg: #f5f5f5;
            --card-bg: #ffffff;
            --card-hover: #f0f0f0;
            --success-color: #00aa55;
            --warning-color: #e6a700;
            --danger-color: #dd3333;
            --text-color: #333333;
            --text-muted: #666666;
            --border-color: #dddddd;
        }

        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: var(--text-color);
            overflow-x: hidden;
            transition: all 0.5s ease;
        }
        
        .admin-header {
            background: linear-gradient(135deg, #000000 0%, #0a0a0a 50%, #141414 100%);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--primary-color);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .light-mode .admin-header {
            background: linear-gradient(135deg, #ffffff 0%, #f0f0f0 50%, #e8e8e8 100%);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .logo-section { 
            display: flex; 
            align-items: center; 
            gap: 15px; 
        }
        
        .logo { 
            height: 50px; 
            border-radius: 8px; 
            transition: transform 0.3s ease; 
        }
        
        .logo:hover { 
            transform: scale(1.05); 
        }
        
        .brand-text {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.5rem;
            text-shadow: 0 0 10px rgba(0, 224, 255, 0.5);
        }
        
        .light-mode .brand-text {
            text-shadow: 0 0 10px rgba(0, 102, 204, 0.3);
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            background: rgba(0, 224, 255, 0.1);
            border-radius: 25px;
            border: 1px solid rgba(0, 224, 255, 0.3);
        }
        
        .light-mode .user-profile {
            background: rgba(0, 102, 204, 0.1);
            border: 1px solid rgba(0, 102, 204, 0.3);
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.1rem;
            color: #000;
        }
        
        .user-details {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-weight: 600;
            color: var(--text-color);
            font-size: 0.9rem;
        }
        
        .user-role {
            font-size: 0.8rem;
            color: var(--primary-color);
            font-weight: 500;
        }
        
        .admin-container { 
            display: flex; 
            min-height: calc(100vh - 80px); 
        }
        
        .sidebar {
            width: 280px;
            background: linear-gradient(to bottom, var(--card-bg) 0%, #151515 100%);
            padding: 25px 0;
            border-right: 1px solid var(--border-color);
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }
        
        .light-mode .sidebar {
            background: linear-gradient(to bottom, var(--card-bg) 0%, #f0f0f0 100%);
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.05);
        }
        
        .sidebar-menu { 
            list-style: none; 
            padding: 0; 
            margin: 0; 
        }
        
        .sidebar-menu li { 
            margin-bottom: 5px; 
            padding: 0 15px; 
        }
        
        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: var(--text-muted);
            text-decoration: none;
            transition: all 0.3s ease;
            border-radius: 10px;
            position: relative;
            overflow: hidden;
        }
        
        .sidebar-menu a:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.1), transparent);
            transition: left 0.5s ease;
        }
        
        .light-mode .sidebar-menu a:before {
            background: linear-gradient(90deg, transparent, rgba(0, 102, 204, 0.1), transparent);
        }
        
        .sidebar-menu a:hover:before { 
            left: 100%; 
        }
        
        .sidebar-menu a:hover {
            background: rgba(0, 224, 255, 0.1);
            color: var(--primary-color);
            transform: translateX(5px);
        }
        
        .light-mode .sidebar-menu a:hover {
            background: rgba(0, 102, 204, 0.1);
        }
        
        .sidebar-menu a.active {
            background: rgba(0, 224, 255, 0.15);
            color: var(--primary-color);
            border-left: 4px solid var(--primary-color);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.2);
        }
        
        .light-mode .sidebar-menu a.active {
            background: rgba(0, 102, 204, 0.15);
            box-shadow: 0 5px 15px rgba(0, 102, 204, 0.2);
        }
        
        .sidebar-menu i {
            margin-right: 12px;
            font-size: 1.2rem;
            width: 24px;
            text-align: center;
        }
        
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
            background: linear-gradient(135deg, #0d0d0d 0%, #111111 100%);
        }
        
        .light-mode .main-content {
            background: linear-gradient(135deg, #f5f5f5 0%, #f0f0f0 100%);
        }
        
        .section-title {
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--primary-color);
            position: relative;
            display: inline-block;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 50px;
            height: 2px;
            background: var(--secondary-color);
        }
        
        .card-admin {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            border-top: 3px solid var(--primary-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .light-mode .card-admin {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        /* CORRECCIÓN CRÍTICA DE DUDU: pointer-events: none */
        .card-admin:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 224, 255, 0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none; /* ESTO ARREGLA EL PROBLEMA DE ESCRITURA */
            z-index: 0;
        }
        
        /* Aseguramos que el formulario esté por encima del fondo decorativo */
        .card-admin > * {
            position: relative;
            z-index: 1;
        }
        
        .light-mode .card-admin:before {
            background: linear-gradient(135deg, rgba(0, 102, 204, 0.05) 0%, transparent 100%);
        }
        
        .card-admin:hover:before { 
            opacity: 1; 
        }
        
        .card-admin:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
        }
        
        .light-mode .card-admin:hover {
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .card-title {
            color: var(--primary-color);
            font-size: 1.4rem;
            font-weight: 600;
            margin: 0;
        }
        
        .btn-admin {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }
        
        .btn-admin:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .light-mode .btn-admin:before {
            background: linear-gradient(90deg, transparent, rgba(0, 102, 204, 0.2), transparent);
        }
        
        .btn-admin:hover:before { 
            left: 100%; 
        }
        
        .btn-admin:hover {
            background: var(--primary-color);
            color: #000;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
        }
        
        .light-mode .btn-admin:hover {
            box-shadow: 0 5px 15px rgba(0, 102, 204, 0.4);
        }
        
        .btn-logout {
            background: transparent;
            border: 2px solid var(--danger-color);
            color: var(--danger-color);
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }
        
        .btn-logout:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 77, 77, 0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .btn-logout:hover:before { 
            left: 100%; 
        }
        
        .btn-logout:hover {
            background: var(--danger-color);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
        }
        
        .btn-success { 
            background: transparent; 
            border: 2px solid var(--success-color); 
            color: var(--success-color); 
        }
        
        .btn-success:hover { 
            background: var(--success-color); 
            color: #000; 
            box-shadow: 0 5px 15px rgba(0, 204, 102, 0.4); 
        }
        
        .btn-warning { 
            background: transparent; 
            border: 2px solid var(--warning-color); 
            color: var(--warning-color); 
        }
        
        .btn-warning:hover { 
            background: var(--warning-color); 
            color: #000; 
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4); 
        }
        
        .btn-danger { 
            background: transparent; 
            border: 2px solid var(--danger-color); 
            color: var(--danger-color); 
        }
        
        .btn-danger:hover { 
            background: var(--danger-color); 
            color: #fff; 
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4); 
        }
        
        /* Estilos para el formulario */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text-color);
            font-size: 1rem;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 16px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            color: var(--text-color);
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 224, 255, 0.25);
        }
        
        .light-mode .form-control:focus {
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.25);
        }
        
        .form-text {
            color: var(--text-muted);
            font-size: 0.875rem;
            margin-top: 8px;
        }
        
        .required::after {
            content: " *";
            color: var(--danger-color);
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        .form-col {
            flex: 1;
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .alert i {
            font-size: 1.2rem;
        }
        
        .alert-info {
            background: rgba(0, 224, 255, 0.1);
            color: var(--primary-color);
            border: 1px solid rgba(0, 224, 255, 0.3);
        }
        
        .light-mode .alert-info {
            background: rgba(0, 102, 204, 0.1);
            border: 1px solid rgba(0, 102, 204, 0.3);
        }
        
        .alert-warning {
            background: rgba(255, 193, 7, 0.1);
            color: var(--warning-color);
            border: 1px solid rgba(255, 193, 7, 0.3);
        }
        
        .light-mode .alert-warning {
            background: rgba(230, 167, 0, 0.1);
            border: 1px solid rgba(230, 167, 0, 0.3);
        }
        
        .btn-cancel {
            background: transparent;
            border: 2px solid var(--text-muted);
            color: var(--text-muted);
        }
        
        .btn-cancel:hover {
            background: var(--text-muted);
            color: var(--dark-bg);
            box-shadow: 0 5px 15px rgba(170, 170, 170, 0.4);
        }
        
        .light-mode .btn-cancel:hover {
            color: var(--card-bg);
        }
        
        /* Vista previa de imagen */
        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: 10px;
            border: 2px solid var(--border-color);
            margin-top: 12px;
            display: none;
        }
        
        .current-image {
            max-width: 200px;
            max-height: 200px;
            border-radius: 10px;
            border: 2px solid var(--primary-color);
            margin-bottom: 12px;
        }
        
        .no-image {
            width: 200px;
            height: 150px;
            background: var(--border-color);
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        .no-image i {
            font-size: 2rem;
            margin-bottom: 8px;
        }
        
        /* Botones del formulario */
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }
        
        /* Mensajes de éxito/error */
        .mensaje-flotante {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 10px;
            z-index: 1000;
            animation: slideIn 0.5s ease;
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @media (max-width: 992px) {
            .admin-container { flex-direction: column; }
            .sidebar { width: 100%; border-right: none; border-bottom: 1px solid var(--border-color); padding: 15px 0; }
            .sidebar-menu { display: flex; overflow-x: auto; padding: 0 15px; }
            .sidebar-menu li { flex-shrink: 0; margin-bottom: 0; }
            .sidebar-menu a { padding: 12px 15px; white-space: nowrap; }
            .main-content { padding: 20px; }
            .user-info { flex-direction: column; gap: 10px; }
            .user-profile { order: 2; }
        }
        
        @media (max-width: 768px) {
            .form-row { flex-direction: column; gap: 0; }
            .form-actions { flex-direction: column; }
            .admin-header { padding: 1rem; flex-direction: column; gap: 15px; }
            .card-admin { padding: 20px; }
            .image-row-responsive { flex-direction: column; }
        }
        
        @media (max-width: 576px) {
            .user-profile { padding: 6px 12px; }
            .user-name { font-size: 0.8rem; }
            .user-role { font-size: 0.7rem; }
        }
    </style>
</head>
<body>

    <header class="admin-header">
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/img/donglai.jpg" alt="DonGlai Logo" class="logo">
            <div class="brand-text">Panel de Administración</div>
        </div>

        <div class="user-info">
            <div class="user-profile">
                <div class="user-avatar">
                    AD
                </div>
                <div class="user-details">
                    <div class="user-name">Administrador</div>
                    <div class="user-role">Administrador</div>
                </div>
            </div>
            <button class="btn-logout" onclick="window.location.href='AdminController?acc=productos'">
                <i class="bi bi-arrow-left"></i> Volver
            </button>
        </div>
    </header>

    <div class="admin-container">
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="Contar"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="AdminController?acc=productos"><i class="bi bi-box"></i> Productos</a></li>
                <li><a href="AdminController?acc=categorias"><i class="bi bi-tags"></i> Categorías</a></li>
                <li><a href="AdminController?acc=usuarios"><i class="bi bi-people"></i> Gestionar Usuarios</a></li>
                <li><a href="AdminController?acc=admin"><i class="bi bi-person-gear"></i> Administradores</a></li>
                <li><a href="AdminController?acc=mensajesWeb"><i class="bi bi-chat-dots"></i> Mensajes Web</a></li>
                <li><a href="AdminController?acc=proveedores"><i class="bi bi-truck"></i> Proveedores</a></li>
                <li><a href="AdminController?acc=reportes"><i class="bi bi-graph-up"></i> Reportes</a></li>
            </ul>
        </div>

        <div class="main-content">
            <section id="editar-producto" class="admin-section">
                <h2 class="section-title">Editar Producto</h2>

                <div class="card-admin">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="bi bi-pencil-square"></i> Modificar Producto
                        </h3>
                    </div>
                    
                    <%
                        ProductoDTO p = (ProductoDTO) request.getAttribute("producto");
                        List<Categoria> listaCategorias = (List<Categoria>) request.getAttribute("listaCategorias");
                        
                        if (p != null) {
                    %>
                    
                    <form id="formEditarProducto" action="AccionesPServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="acc" value="actualizar">
                        <input type="hidden" name="id_producto" value="<%= p.getId_producto() %>">
                        
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i> Complete los campos que desea modificar. Los campos marcados con (*) son obligatorios.
                        </div>
                        
                        <div class="form-group">
                            <label for="nombre_producto" class="form-label required">Nombre del Producto</label>
                            <input type="text" class="form-control" id="nombre_producto" name="nombre_producto" 
                                   value="<%= p.getNombre_producto() != null ? p.getNombre_producto() : "" %>" 
                                   maxlength="100" required>
                            <div class="form-text">Máximo 100 caracteres</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="descripcion" class="form-label">Descripción</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" rows="4" 
                                      placeholder="Ingrese una descripción del producto..."><%= p.getDescripcion() != null ? p.getDescripcion() : "" %></textarea>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <div class="form-group">
                                    <label for="precio" class="form-label required">Precio (S/.)</label>
                                    <input type="number" class="form-control" id="precio" name="precio" 
                                           value="<%= p.getPrecio() %>" step="0.01" min="0.01" required
                                           placeholder="0.00">
                                    <div class="form-text">Formato: 0.00</div>
                                </div>
                            </div>
                            <div class="form-col">
                                <div class="form-group">
                                    <label for="stock" class="form-label">Stock Disponible</label>
                                    <input type="number" class="form-control" id="stock" name="stock" 
                                           value="<%= p.getStock() %>" min="0"
                                           placeholder="0">
                                    <div class="form-text">Cantidad disponible en inventario</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="id_categoria" class="form-label required">Categoría</label>
                            <select class="form-control" id="id_categoria" name="id_categoria" required>
                                <option value="">Seleccione una categoría</option>
                                <%
                                    if (listaCategorias != null) {
                                        for (Categoria categoria : listaCategorias) {
                                            String selected = "";
                                            if (categoria.getId_categoria() == p.getId_categoria()) {
                                                selected = "selected";
                                            }
                                %>
                                    <option value="<%= categoria.getId_categoria() %>" <%= selected %>>
                                        <%= categoria.getNombre_categoria() %>
                                    </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Gestión de Imagen</label>
                            <div class="d-flex gap-4 image-row-responsive" style="align-items: flex-start; padding: 15px; border: 1px solid var(--border-color); border-radius: 10px; background: rgba(0,0,0,0.2);">
                                <div class="text-center" style="min-width: 150px;">
                                    <label class="form-label text-muted" style="font-size: 0.8rem;">Imagen Actual</label>
                                    <% if (p.getImagenBase64() != null && !p.getImagenBase64().isEmpty()) { %>
                                        <img src="data:image/jpeg;base64,<%= p.getImagenBase64() %>" 
                                             alt="Imagen actual" class="current-image" style="width: 100%; max-width: 150px; height: auto;">
                                    <% } else { %>
                                        <div class="no-image" style="width: 150px; height: 110px;">
                                            <i class="bi bi-image"></i>
                                            <div>Sin imagen</div>
                                        </div>
                                    <% } %>
                                </div>

                                <div style="flex-grow: 1;">
                                    <label for="imagen" class="form-label">¿Desea cambiar la imagen?</label>
                                    <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*">
                                    <div class="form-text text-info">
                                        <i class="bi bi-info-circle"></i> Deje este campo vacío si desea mantener la imagen actual.
                                    </div>
                                    
                                    <div id="preview-container" class="mt-3" style="display:none;">
                                        <p class="mb-1 text-success fw-bold" style="font-size: 0.9rem;">Nueva imagen seleccionada:</p>
                                        <img id="image-preview" class="image-preview" style="display:block; max-width: 150px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" class="btn-admin btn-cancel" onclick="window.location.href='AdminController?acc=productos'">
                                <i class="bi bi-x-circle"></i> Cancelar
                            </button>
                            <button type="submit" class="btn-admin btn-success">
                                <i class="bi bi-check-circle"></i> Actualizar Producto
                            </button>
                        </div>
                    </form>
                    
                    <% } else { %>
                    
                    <div style="text-align: center; padding: 60px 20px;">
                        <i class="bi bi-exclamation-triangle" style="font-size: 4rem; color: var(--warning-color); margin-bottom: 20px;"></i>
                        <h3 style="color: var(--warning-color); margin-bottom: 15px;">Producto no encontrado</h3>
                        <p style="color: var(--text-muted); margin-bottom: 30px; font-size: 1.1rem;">
                            El producto que intentas editar no existe o ha sido eliminado.
                        </p>
                        <button class="btn-admin" onclick="window.location.href='AdminController?acc=productos'">
                            <i class="bi bi-arrow-left"></i> Volver a la lista de productos
                        </button>
                    </div>
                    
                    <% } %>
                </div>
            </section>
        </div>
    </div>

    <script>
        // Vista previa de imagen y validación (MEJORADO)
        document.getElementById('imagen').addEventListener('change', function() {
            const preview = document.getElementById('image-preview');
            const previewContainer = document.getElementById('preview-container');
            const file = this.files[0];
            
            if (file) {
                // Validar tamaño de archivo (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    alert('La imagen no puede ser mayor a 5MB');
                    this.value = '';
                    previewContainer.style.display = 'none';
                    return;
                }
                
                // Validar tipo de archivo
                const validTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
                if (!validTypes.includes(file.type)) {
                    alert('Solo se permiten archivos JPG, PNG o GIF');
                    this.value = '';
                    previewContainer.style.display = 'none';
                    return;
                }
                
                const reader = new FileReader();
                
                reader.addEventListener('load', function() {
                    preview.src = reader.result;
                    previewContainer.style.display = 'block';
                });
                
                reader.readAsDataURL(file);
            } else {
                previewContainer.style.display = 'none';
            }
        });

        // Validación del formulario
        document.getElementById('formEditarProducto').addEventListener('submit', function(e) {
            const nombre = document.getElementById('nombre_producto').value.trim();
            const precio = document.getElementById('precio').value;
            const categoria = document.getElementById('id_categoria').value;
            
            // Limpiar mensajes anteriores
            const mensajesAnteriores = document.querySelectorAll('.mensaje-error');
            mensajesAnteriores.forEach(msg => msg.remove());
            
            let isValid = true;
            
            if (!nombre) {
                mostrarError('nombre_producto', 'El nombre del producto es obligatorio');
                isValid = false;
            }
            
            if (!precio || parseFloat(precio) <= 0) {
                mostrarError('precio', 'El precio debe ser un valor mayor a 0');
                isValid = false;
            }
            
            if (!categoria) {
                mostrarError('id_categoria', 'Debe seleccionar una categoría');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
                // Mostrar alerta general
                alert('Por favor, complete todos los campos obligatorios correctamente.');
            }
        });

        // Función para mostrar errores específicos
        function mostrarError(campoId, mensaje) {
            const campo = document.getElementById(campoId);
            const errorDiv = document.createElement('div');
            errorDiv.className = 'mensaje-error';
            errorDiv.style.color = 'var(--danger-color)';
            errorDiv.style.fontSize = '0.875rem';
            errorDiv.style.marginTop = '5px';
            errorDiv.innerHTML = '<i class="bi bi-exclamation-circle"></i> ' + mensaje;
            
            // Insertar después del campo
            campo.parentNode.appendChild(errorDiv);
            
            // Resaltar el campo
            campo.style.borderColor = 'var(--danger-color)';
        }

        // Quitar el resaltado de error cuando el usuario empiece a escribir
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('input', function() {
                this.style.borderColor = 'var(--border-color)';
                const errorMsg = this.parentNode.querySelector('.mensaje-error');
                if (errorMsg) {
                    errorMsg.remove();
                }
            });
        });

        // Mostrar mensajes del servidor si existen
        <% 
            String mensaje = (String) request.getSession().getAttribute("mensaje");
            String error = (String) request.getSession().getAttribute("error");
            
            if (mensaje != null) {
        %>
            mostrarMensaje('<%= mensaje %>', 'success');
            <% request.getSession().removeAttribute("mensaje"); %>
        <%
            }
            if (error != null) {
        %>
            mostrarMensaje('<%= error %>', 'error');
            <% request.getSession().removeAttribute("error"); %>
        <%
            }
        %>

        function mostrarMensaje(mensaje, tipo) {
            const mensajeDiv = document.createElement('div');
            mensajeDiv.className = 'mensaje-flotante';
            mensajeDiv.style.background = tipo === 'success' ? 'var(--success-color)' : 'var(--danger-color)';
            mensajeDiv.style.color = tipo === 'success' ? '#000' : '#fff';
            mensajeDiv.style.padding = '15px 20px';
            mensajeDiv.style.borderRadius = '10px';
            mensajeDiv.style.boxShadow = '0 5px 15px rgba(0,0,0,0.3)';
            mensajeDiv.innerHTML = '<i class="bi ' + (tipo === 'success' ? 'bi-check-circle' : 'bi-exclamation-triangle') + '"></i> ' + mensaje;
            
            document.body.appendChild(mensajeDiv);
            
            // Auto-eliminar después de 5 segundos
            setTimeout(() => {
                mensajeDiv.remove();
            }, 5000);
        }
    </script>
</body>
</html>