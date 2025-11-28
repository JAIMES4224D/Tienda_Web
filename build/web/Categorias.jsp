<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page isELIgnored="false" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <title>Panel de Administración - DonGlai LED</title>
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
        
        /* Variables para modo claro */
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
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
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
        .logo-section { display: flex; align-items: center; gap: 15px; }
        .logo { height: 50px; border-radius: 8px; transition: transform 0.3s ease; }
        .logo:hover { transform: scale(1.05); }
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
        .admin-container { display: flex; min-height: calc(100vh - 80px); }
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
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-menu li { margin-bottom: 5px; padding: 0 15px; }
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
        .sidebar-menu a:hover:before { left: 100%; }
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
        }
        .light-mode .card-admin:before {
            background: linear-gradient(135deg, rgba(0, 102, 204, 0.05) 0%, transparent 100%);
        }
        .card-admin:hover:before { opacity: 1; }
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
        .btn-admin:hover:before { left: 100%; }
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
        .btn-logout:hover:before { left: 100%; }
        .btn-logout:hover {
            background: var(--danger-color);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
        }
        .btn-success { background: transparent; border: 2px solid var(--success-color); color: var(--success-color); }
        .btn-success:hover { background: var(--success-color); color: #000; box-shadow: 0 5px 15px rgba(0, 204, 102, 0.4); }
        .btn-warning { background: transparent; border: 2px solid var(--warning-color); color: var(--warning-color); }
        .btn-warning:hover { background: var(--warning-color); color: #000; box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4); }
        .btn-danger { background: transparent; border: 2px solid var(--danger-color); color: var(--danger-color); }
        .btn-danger:hover { background: var(--danger-color); color: #fff; box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4); }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            border-top: 3px solid var(--primary-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .light-mode .stat-card {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        .stat-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 224, 255, 0.05) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .light-mode .stat-card:before {
            background: linear-gradient(135deg, rgba(0, 102, 204, 0.05) 0%, transparent 100%);
        }
        .stat-card:hover:before { opacity: 1; }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
        }
        .light-mode .stat-card:hover {
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }
        .stat-icon {
            font-size: 2.8rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            text-shadow: 0 0 15px rgba(0, 224, 255, 0.5);
        }
        .light-mode .stat-icon {
            text-shadow: 0 0 15px rgba(0, 102, 204, 0.3);
        }
        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 10px;
            text-shadow: 0 0 10px rgba(0, 224, 255, 0.3);
        }
        .light-mode .stat-value {
            text-shadow: 0 0 10px rgba(0, 102, 204, 0.2);
        }
        .stat-label { color: var(--text-muted); font-size: 1rem; font-weight: 500; }
        .hidden-section { display: none; }
        
        /* Estilos para la tabla de categorías */
        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            margin-top: 20px;
        }
        .table-admin {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .light-mode .table-admin {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .table-admin th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: #000;
            font-weight: 600;
            padding: 15px 12px;
            text-align: left;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .table-admin td {
            padding: 12px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
            font-size: 0.9rem;
        }
        .table-admin tr:last-child td {
            border-bottom: none;
        }
        .table-admin tr:hover td {
            background: rgba(0, 224, 255, 0.05);
        }
        .light-mode .table-admin tr:hover td {
            background: rgba(0, 102, 204, 0.05);
        }
        .table-actions {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
        .btn-table {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 4px;
            transition: all 0.3s ease;
        }
        .btn-table i {
            font-size: 0.9rem;
        }
        .estado-activo {
            color: var(--success-color);
            font-weight: 600;
        }
        .estado-inactivo {
            color: var(--danger-color);
            font-weight: 600;
        }
        
        /* Interruptor de foquito */
        .lightbulb-toggle {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 20px;
            cursor: pointer;
            position: relative;
        }
        .lightbulb-toggle-text {
            font-size: 0.8rem;
            color: var(--text-muted);
            font-weight: 500;
            margin-bottom: 5px;
            transition: all 0.3s ease;
        }
        .lightbulb-container {
            position: relative;
            width: 50px;
            height: 70px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .lightbulb {
            width: 30px;
            height: 30px;
            background: #ffcc00;
            border-radius: 50% 50% 50% 50% / 60% 60% 40% 40%;
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
            box-shadow: 0 0 20px rgba(255, 204, 0, 0.7);
        }
        .light-mode .lightbulb {
            background: #cccccc;
            box-shadow: 0 0 10px rgba(204, 204, 204, 0.5);
        }
        .lightbulb:before {
            content: '';
            position: absolute;
            top: -5px;
            left: 5px;
            width: 20px;
            height: 10px;
            background: #ffcc00;
            border-radius: 50%;
            filter: blur(5px);
        }
        .light-mode .lightbulb:before {
            background: #cccccc;
        }
        .lightbulb:after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 10px;
            width: 10px;
            height: 10px;
            background: #ffcc00;
            border-radius: 50%;
            filter: blur(3px);
        }
        .light-mode .lightbulb:after {
            background: #cccccc;
        }
        .lightbulb-base {
            width: 15px;
            height: 10px;
            background: #666666;
            border-radius: 0 0 5px 5px;
            position: relative;
            z-index: 2;
        }
        .lightbulb-cord {
            width: 2px;
            height: 30px;
            background: #666666;
            position: absolute;
            top: 40px;
            transition: all 0.5s ease;
            transform-origin: top center;
        }
        .lightbulb-cord.pulled {
            transform: rotate(15deg);
        }
        .lightbulb-cord-handle {
            width: 10px;
            height: 5px;
            background: #666666;
            border-radius: 3px;
            position: absolute;
            bottom: -5px;
            left: -4px;
        }
        .lightbulb-glow {
            position: absolute;
            top: 15px;
            left: 15px;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 200, 0.8);
            box-shadow: 0 0 40px 20px rgba(255, 255, 200, 0.5);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }
        .lightbulb-glow.active {
            opacity: 1;
        }
        .light-mode .lightbulb-glow {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 20px 10px rgba(255, 255, 255, 0.2);
        }
        
        /* Modal de confirmación para cerrar sesión */
        .modal-confirm {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 10000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        .modal-confirm.active {
            opacity: 1;
            visibility: visible;
        }
        .modal-confirm-content {
            background: var(--card-bg);
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            padding: 30px;
            position: relative;
            box-shadow: 0 20px 50px rgba(255, 77, 77, 0.3);
            border: 2px solid var(--danger-color);
            transform: scale(0.9);
            transition: transform 0.3s ease;
        }
        .modal-confirm.active .modal-confirm-content {
            transform: scale(1);
        }
        .modal-confirm-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .modal-confirm-title {
            color: var(--danger-color);
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }
        .modal-confirm-body {
            text-align: center;
            margin-bottom: 25px;
            color: var(--text-muted);
        }
        .modal-confirm-footer {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        @keyframes countUp { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .counting { animation: countUp 1s ease-out forwards; }
        
        @keyframes pullCord {
            0% { transform: rotate(0deg); }
            50% { transform: rotate(15deg); }
            100% { transform: rotate(0deg); }
        }
        .pull-animation {
            animation: pullCord 0.5s ease;
        }
        
        @media (max-width: 992px) {
            .admin-container { flex-direction: column; }
            .sidebar { width: 100%; border-right: none; border-bottom: 1px solid var(--border-color); padding: 15px 0; }
            .sidebar-menu { display: flex; overflow-x: auto; padding: 0 15px; }
            .sidebar-menu li { flex-shrink: 0; margin-bottom: 0; }
            .sidebar-menu a { padding: 12px 15px; white-space: nowrap; }
            .stats-grid { grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); }
            .main-content { padding: 20px; }
            .user-info { flex-direction: column; gap: 10px; }
            .user-profile { order: 2; }
            .lightbulb-toggle { margin-right: 0; margin-bottom: 10px; }
            .table-actions { flex-direction: column; }
        }
        @media (max-width: 576px) {
            .admin-header { padding: 1rem; flex-direction: column; gap: 15px; }
            .stats-grid { grid-template-columns: 1fr; }
            .card-admin { padding: 20px; }
            .modal-confirm-footer { flex-direction: column; }
            .user-profile { padding: 6px 12px; }
            .user-name { font-size: 0.8rem; }
            .user-role { font-size: 0.7rem; }
            .lightbulb-toggle { flex-direction: column; gap: 5px; }
            .table-admin th, .table-admin td { padding: 8px 6px; font-size: 0.8rem; }
            .btn-table { padding: 4px 8px; font-size: 0.7rem; }
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
            <div class="lightbulb-toggle" id="lightbulbToggle">
                <span class="lightbulb-toggle-text">Modo Oscuro</span>
                <div class="lightbulb-container">
                    <div class="lightbulb-glow" id="lightbulbGlow"></div>
                    <div class="lightbulb"></div>
                    <div class="lightbulb-base"></div>
                    <div class="lightbulb-cord" id="lightbulbCord">
                        <div class="lightbulb-cord-handle"></div>
                    </div>
                </div>
            </div>
            
            <div class="user-profile">
                <div class="user-avatar" id="userAvatar">
                    <!-- Se llenará con JavaScript -->
                </div>
                <div class="user-details">
                    <div class="user-name" id="userName">
                        <!-- Se llenará con los datos de la sesión -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioNombre}">
                                ${sessionScope.usuarioNombre}
                            </c:when>
                            <c:otherwise>
                                Administrador
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="user-role" id="userRole">
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioRol}">
                                ${sessionScope.usuarioRol}
                            </c:when>
                            <c:otherwise>
                                Administrador
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <button class="btn-logout" onclick="confirmarCerrarSesion()">
                <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
            </button>
        </div>
    </header>

    <div class="admin-container">
        
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="Contar" ><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="AdminController?acc=productos"><i class="bi bi-box"></i> Productos</a></li>
                <li><a href="AdminController?acc=categorias" class="active" ><i class="bi bi-tags"></i> Categorías</a></li>
                <li><a href="AdminController?acc=usuarios"><i class="bi bi-people"></i> Gestionar Usuarios</a></li>
                <li><a href="AdminController?acc=admin"><i class="bi bi-person-gear"></i> Administradores</a></li>
                <li><a href="AdminController?acc=mensajesWeb"><i class="bi bi-chat-dots"></i> Mensajes Web</a></li>
                <li><a href="AdminController?acc=proveedores"><i class="bi bi-truck"></i> Proveedores</a></li>
                <li><a href="AdminController?acc=pedidos" ><i class="bi bi-cart-check"></i> Pedidos</a></li>
                
            </ul>
        </div>

        <div class="main-content">
            <section id="categorias" class="admin-section">
                <h2 class="section-title">Gestionar Categorías</h2>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-tags"></i></div>
                        <div class="stat-value" id="totalCategorias">${nroCategorias}</div>
                        <div class="stat-label">Total Categorías</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-check-circle"></i></div>
                        <div class="stat-value" id="categoriasActivas">${nroCategorias}</div>
                        <div class="stat-label">Categorías Activas</div>
                    </div>
                    
                </div>
                
                <div class="card-admin">
                    <div class="card-header">
                        <h3 class="card-title">Lista de Categorías</h3>
                        <button class="btn-admin" onclick="mostrarModalAgregarCategoria()">
                            <i class="bi bi-plus-circle"></i> Agregar Categoría
                        </button>
                    </div>
                    
                    <div class="table-container">
                        <table class="table-admin">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Descripción</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty listaCategorias}">
                                        <c:forEach var="categoria" items="${listaCategorias}">
                                            <tr>
                                                <td>${categoria.id_categoria}</td>
                                                <td>${categoria.nombre_categoria}</td>
                                                <td>${categoria.descripcion}</td>
                                                <td>
                                                    <div class="table-actions">
                                                        <button class="btn-admin btn-table" 
                                                                onclick="cargarDatosEditar(this)" 
                                                                data-id="${categoria.id_categoria}"
                                                                data-nombre="${categoria.nombre_categoria}"
                                                                data-descripcion="${categoria.descripcion}">
                                                            <i class="bi bi-pencil"></i> Editar
                                                        </button>
                                                        <button class="btn-admin btn-danger btn-table" onclick="eliminarCategoria(${categoria.id_categoria})">
                                                            <i class="bi bi-trash"></i> Eliminar
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" style="text-align: center; padding: 30px;">
                                                <i class="bi bi-inbox" style="font-size: 3rem; color: var(--text-muted);"></i>
                                                <p style="margin-top: 15px; color: var(--text-muted);">No hay categorías registradas</p>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>
    </div>
    
    <!-- Modal de confirmación para cerrar sesión -->
    <div class="modal-confirm" id="modalCerrarSesion">
        <div class="modal-confirm-content">
            <div class="modal-confirm-header">
                <h3 class="modal-confirm-title"><i class="bi bi-exclamation-triangle"></i> Cerrar Sesión</h3>
            </div>
            <div class="modal-confirm-body">
                <p>¿Estás seguro de que deseas cerrar sesión?</p>
                <p><small>Serás redirigido a la página de inicio de sesión.</small></p>
            </div>
            <div class="modal-confirm-footer">
                <button class="btn-admin" onclick="cancelarCerrarSesion()">
                    <i class="bi bi-x-circle"></i> Cancelar
                </button>
                <button class="btn-logout" onclick="cerrarSesion()">
                    <i class="bi bi-box-arrow-right"></i> Sí, Cerrar Sesión
                </button>
            </div>
        </div>
    </div>
    
    <!-- Modal para agregar categoría (placeholder) -->
    <div class="modal-confirm" id="modalAgregarCategoria">
        <div class="modal-confirm-content">
            <div class="modal-confirm-header">
                <h3 class="modal-confirm-title"><i class="bi bi-plus-circle"></i> Agregar Categoría</h3>
            </div>
            <div class="modal-confirm-body">
                <form action="AccionesPServlet" method="post" >
                    <label>Nombre de Categoria:</label>
                    <input type="text" name="nombre_categoria" />
                    <label>Descripcion de Categoria:</label>
                    <input type="text" name="descripcion" />
                    <input type="submit" name="acc" value="Insertar Categoria"/>
                </form>
            </div>
            <div class="modal-confirm-footer">
                <button class="btn-admin" onclick="cerrarModalAgregarCategoria()">
                    <i class="bi bi-x-circle"></i> Cerrar
                </button>
            </div>
        </div>
    </div>
    <!--modeal editar -->
    
    <div class="modal-confirm" id="modalEditarCategoria">
    <div class="modal-confirm-content">
        <div class="modal-confirm-header">
            <h3 class="modal-confirm-title">
                <i class="bi bi-pencil-square"></i> Editar Categoría
            </h3>
        </div>
        <div class="modal-confirm-body">
            <form id="formEditarCategoria" action="AccionesPServlet" method="post">
                <input type="hidden" name="id_categoria" id="edit_id_categoria">
                
                <input type="hidden" name="acc" value="actualizar_categoria">

                <div class="form-group" style="text-align: left;">
                    <label class="form-label required">Nombre de Categoría:</label>
                    <input type="text" class="form-control" name="nombre_categoria" id="edit_nombre_categoria" required maxlength="100"/>
                </div>
                
                <div class="form-group" style="text-align: left;">
                    <label class="form-label">Descripción:</label>
                    <textarea class="form-control" name="descripcion" id="edit_descripcion" rows="3"></textarea>
                </div>
            </form>
        </div>
        <div class="modal-confirm-footer">
            <button class="btn-admin" onclick="cerrarModalEditarCategoria()">
                <i class="bi bi-x-circle"></i> Cancelar
            </button>
            <button type="submit" form="formEditarCategoria" class="btn-admin btn-success">
                <i class="bi bi-check-circle"></i> Actualizar
            </button>
        </div>
    </div>
</div>
    
 <script>
        // Variables globales
        var productos = [];
        var categorias = [];
        var usuarios = [];
        var administradores = [];
        var accionConfirmar = null;
        var datosConfirmar = null;
        var isLightMode = false;

        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Inicializando panel de administración...');
            cargarInformacionUsuario();
            inicializarFoquito();
            actualizarEstadisticasCategorias();
        });

        // Inicializar el foquito
        function inicializarFoquito() {
            const lightbulbToggle = document.getElementById('lightbulbToggle');
            const toggleText = lightbulbToggle.querySelector('.lightbulb-toggle-text');
            const lightbulbCord = document.getElementById('lightbulbCord');
            const lightbulbGlow = document.getElementById('lightbulbGlow');
            
            // Verificar si hay una preferencia guardada
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme === 'light') {
                activarModoClaro();
            } else {
                activarModoOscuro();
            }
            
            // Agregar evento de clic al foquito
            lightbulbToggle.addEventListener('click', function() {
                // Animación de jalar la pitita
                lightbulbCord.classList.add('pull-animation');
                setTimeout(() => {
                    lightbulbCord.classList.remove('pull-animation');
                }, 500);
                
                // Cambiar modo después de un pequeño delay para la animación
                setTimeout(() => {
                    if (isLightMode) {
                        activarModoOscuro();
                    } else {
                        activarModoClaro();
                    }
                }, 200);
            });
        }

        // Activar modo oscuro
        function activarModoOscuro() {
            document.body.classList.remove('light-mode');
            const toggleText = document.querySelector('.lightbulb-toggle-text');
            toggleText.textContent = 'Modo Oscuro';
            isLightMode = false;
            localStorage.setItem('theme', 'dark');
            
            // Actualizar estado del foquito
            const lightbulbGlow = document.getElementById('lightbulbGlow');
            lightbulbGlow.classList.remove('active');
        }

        // Activar modo claro
        function activarModoClaro() {
            document.body.classList.add('light-mode');
            const toggleText = document.querySelector('.lightbulb-toggle-text');
            toggleText.textContent = 'Modo Claro';
            isLightMode = true;
            localStorage.setItem('theme', 'light');
            
            // Actualizar estado del foquito
            const lightbulbGlow = document.getElementById('lightbulbGlow');
            lightbulbGlow.classList.add('active');
        }

        // Cargar información del usuario desde la sesión
        function cargarInformacionUsuario() {
            // Esta función se ejecuta inmediatamente al cargar la página
            const nombreElement = document.getElementById('userName');
            const rolElement = document.getElementById('userRole');
            const avatarElement = document.getElementById('userAvatar');
            
            // Obtener el nombre del elemento (viene del JSP/EL)
            const nombreCompleto = nombreElement.textContent.trim();
            const rol = rolElement.textContent.trim();
            
            console.log('Información del usuario:', { nombreCompleto, rol });
            
            // Crear avatar con iniciales
            if (nombreCompleto && nombreCompleto !== 'Administrador') {
                const iniciales = obtenerIniciales(nombreCompleto);
                avatarElement.textContent = iniciales;
            } else {
                avatarElement.textContent = 'AD';
            }
            
            console.log('Usuario cargado:', nombreCompleto, '- Rol:', rol);
        }

        // Función para obtener iniciales del nombre
        function obtenerIniciales(nombreCompleto) {
            return nombreCompleto
                .split(' ')
                .map(nombre => nombre.charAt(0))
                .join('')
                .toUpperCase()
                .substring(0, 2);
        }

        // Actualizar estadísticas de categorías
        function actualizarEstadisticasCategorias() {
            // Las estadísticas principales vienen del servlet
            // Esta función puede usarse para actualizaciones dinámicas
            console.log('Estadísticas de categorías cargadas desde el servlet');
        }

        // =============================================
        // FUNCIONES PARA CERRAR SESIÓN
        // =============================================

        function confirmarCerrarSesion() {
            var modal = document.getElementById('modalCerrarSesion');
            modal.classList.add('active');
        }

        function cancelarCerrarSesion() {
            var modal = document.getElementById('modalCerrarSesion');
            modal.classList.remove('active');
        }

        function cerrarSesion() {
            // Aquí puedes agregar lógica adicional si necesitas limpiar datos de sesión
            console.log('Cerrando sesión...');
            
            // Redirigir a la página de login o inicio
            // Cambia 'login.jsp' por la URL de tu página de inicio de sesión
            window.location.href = 'login.jsp';
        }

        // =============================================
        // FUNCIONES PARA LA TABLA DE CATEGORÍAS
        // =============================================

        function mostrarModalAgregarCategoria() {
            var modal = document.getElementById('modalAgregarCategoria');
            modal.classList.add('active');
        }

        function cerrarModalAgregarCategoria() {
            var modal = document.getElementById('modalAgregarCategoria');
            modal.classList.remove('active');
        }

        // Función para abrir el modal con los datos cargados
        function cargarDatosEditar(boton) {
            // 1. Obtener los datos del botón (data-attributes)
            const id = boton.getAttribute('data-id');
            const nombre = boton.getAttribute('data-nombre');
            const descripcion = boton.getAttribute('data-descripcion');

            // 2. Llenar los campos del modal
            document.getElementById('edit_id_categoria').value = id;
            document.getElementById('edit_nombre_categoria').value = nombre;
            document.getElementById('edit_descripcion').value = descripcion;

            // 3. Mostrar el modal (usando tu clase CSS .active)
            const modal = document.getElementById('modalEditarCategoria');
            modal.classList.add('active');
        }

        // Función para cerrar el modal
        function cerrarModalEditarCategoria() {
            const modal = document.getElementById('modalEditarCategoria');
            modal.classList.remove('active');
        }

        function cambiarEstadoCategoria(idCategoria, nuevoEstado) {
            var accion = nuevoEstado == 1 ? 'activar' : 'desactivar';
            if (confirm('¿Estás seguro de que deseas ' + accion + ' esta categoría?')) {
                alert('Cambiar estado de categoría con ID: ' + idCategoria + ' a estado: ' + nuevoEstado);
                // Aquí puedes implementar la lógica para cambiar el estado
            }
        }

        function eliminarCategoria(idCategoria) {
            let confirmacion = confirm("¿Estás seguro de que deseas eliminar esta categoria?");
            
            if (confirmacion) {
                // Redirecciona al Servlet enviando la acción y el ID
                window.location.href = "AccionesPServlet?acc=eliminarCat&id=" + idCategoria;
            }
        }
    </script>
</body>
</html>