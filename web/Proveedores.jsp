<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Iterator"%>
<%@page import="Modelo.Proveedores"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        }

        /* Estilos para la tabla estilo Dashboard */
        .table-dashboard {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            color: #fff;
        }

        .table-dashboard th {
            text-align: left;
            padding: 15px;
            color: #fff;
            font-weight: 600;
            border-bottom: 1px solid #333;
        }

        .table-dashboard td {
            background-color: var(--card-bg, #1a1a1a);
            padding: 15px;
            vertical-align: middle;
            border-top: 1px solid #333;
            border-bottom: 1px solid #333;
        }

        .table-dashboard tr td:first-child {
            border-left: 1px solid #333;
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }

        .table-dashboard tr td:last-child {
            border-right: 1px solid #333;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        /* Columna Empresa (Cyan y Grande) */
        .col-empresa {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #00e0ff;
            font-weight: 600;
            font-size: 1.1rem;
        }

        /* Columna de Contacto (Apilada verticalmente) */
        .info-stack {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #aaa;
            font-size: 0.9rem;
        }

        .info-item i {
            color: #666;
        }

        /* Títulos pequeños dentro de la celda (como 'Asunto' en la imagen) */
        .sub-title {
            display: block;
            color: #fff;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .sub-text {
            color: #aaa;
            font-size: 0.85rem;
        }

        /* BOTONES CIRCULARES - CORREGIDOS */
        .actions-cell {
            display: flex;
            gap: 10px;
            justify-content: flex-start;
        }

        .btn-circle {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: 1px solid;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 1.1rem;
            position: relative;
            z-index: 10;
        }

        /* Asegurar que los botones sean clickeables */
        .btn-circle * {
            pointer-events: none;
        }

        /* Colores de botones */
        .btn-circle.wsp { 
            border-color: #25D366; 
            color: #25D366; 
        }
        .btn-circle.wsp:hover { 
            background: #25D366; 
            color: #000; 
            box-shadow: 0 0 10px #25D366; 
        }

        .btn-circle.mail { 
            border-color: #00e0ff; 
            color: #00e0ff; 
        }
        .btn-circle.mail:hover { 
            background: #00e0ff; 
            color: #000; 
            box-shadow: 0 0 10px #00e0ff; 
        }

        .btn-circle.edit { 
            border-color: #ffc107; 
            color: #ffc107; 
        }
        .btn-circle.edit:hover { 
            background: #ffc107; 
            color: #000; 
            box-shadow: 0 0 10px #ffc107; 
        }

        .btn-circle.del { 
            border-color: #ff4d4d; 
            color: #ff4d4d; 
        }
        .btn-circle.del:hover { 
            background: #ff4d4d; 
            color: #fff; 
            box-shadow: 0 0 10px #ff4d4d; 
        }

        /* Asegurar que los enlaces sean clickeables */
        .btn-circle[href] {
            cursor: pointer;
        }

        /* Estilos para los formularios en modales */
        .form-control {
            background: var(--card-bg) !important;
            border: 1px solid var(--border-color) !important;
            color: var(--text-color) !important;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(0, 224, 255, 0.25) !important;
            border-color: var(--primary-color) !important;
        }

        .form-label {
            color: var(--text-color);
            font-weight: 500;
        }
        /* Botón de Mapa (Naranja) */
        .btn-circle.map { 
            border-color: #fd7e14; 
            color: #fd7e14; 
        }
        .btn-circle.map:hover { 
            background: #fd7e14; 
            color: #fff; /* Texto blanco al pasar el mouse */
            box-shadow: 0 0 10px #fd7e14; 
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
                <li><a href="AdminController?acc=categorias"><i class="bi bi-tags"></i> Categorías</a></li>
                <li><a href="AdminController?acc=usuarios"><i class="bi bi-people"></i> Gestionar Usuarios</a></li>
                <li><a href="AdminController?acc=admin"><i class="bi bi-person-gear"></i> Administradores</a></li>
                <li><a href="AdminController?acc=mensajesWeb"><i class="bi bi-chat-dots"></i> Mensajes Web</a></li>
                <li><a href="AdminController?acc=proveedores" class="active" ><i class="bi bi-truck"></i> Proveedores</a></li>
                
            </ul>
        </div>

        <div class="main-content">
            <section id="proveedores" class="admin-section">
                <h2 class="section-title">Gestionar Proveedores</h2>
                <%
                    int totalProveedores = (Integer) request.getAttribute("totalProveedores");
                    int paisesCubiertos = (Integer) request.getAttribute("paisesCubiertos");
                    int productosSuministrados = (Integer) request.getAttribute("productosSuministrados");
                    
                %>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-truck"></i></div>
                        <div class="stat-value" id="totalProveedores"><%= totalProveedores%></div>
                        <div class="stat-label">Total Proveedores</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-check-circle"></i></div>
                        <div class="stat-value" id="proveedoresActivos"><%= totalProveedores%></div>
                        <div class="stat-label">Proveedores Activos</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-geo-alt"></i></div>
                        <div class="stat-value" id="paisesCubiertos"><%= paisesCubiertos%></div>
                        <div class="stat-label">Países Cubiertos</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-box-seam"></i></div>
                        <div class="stat-value" id="productosSuministrados"><%= productosSuministrados%></div>
                        <div class="stat-label">Productos Suministrados</div>
                    </div>
                </div>
                
                <div class="card-admin">
                    <div class="card-header">
                        <h3 class="card-title">Lista de Proveedores</h3>
                        <button class="btn-admin" onclick="mostrarModalAgregar()">
                            <i class="bi bi-plus-circle"></i> Agregar Proveedor
                        </button>
                    </div>
                       

                    <table class="table-dashboard">
                        <thead>
                            <tr>
                                <th>Proveedor / Empresa</th>
                                <th>Datos de Contacto</th>
                                <th>Ubicación y Encargado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Proveedores> lista = (List<Proveedores>) request.getAttribute("lista");

                                if (lista != null && !lista.isEmpty()) {
                                    Iterator<Proveedores> iter = lista.iterator();
                                    while (iter.hasNext()) {
                                        Proveedores p = iter.next();

                                        // Mensajes predeterminados
                                        String mensajeWsp = "Hola " + p.getNombre_empresa() + ", contacto desde DonGlai LED.";
                                        String mensajeWspEncoded = URLEncoder.encode(mensajeWsp, "UTF-8").replace("+", "%20");

                                        String asunto = "Pedido - DonGlai LED";
                                        String cuerpo = "Estimados " + p.getNombre_empresa() + ", quisiera consultar stock.";
                                        String asuntoEncoded = URLEncoder.encode(asunto, "UTF-8").replace("+", "%20");
                                        String cuerpoEncoded = URLEncoder.encode(cuerpo, "UTF-8").replace("+", "%20");
                                        String direccionDestino = p.getDireccion();
                                        String direccionEncoded = URLEncoder.encode(direccionDestino, "UTF-8").replace("+", "%20");
                            %>
                                <tr>
                                    <td>
                                        <div class="col-empresa">
                                            <i class="bi bi-building-fill-check"></i> <span><%= p.getNombre_empresa() %></span>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="info-stack">
                                            <div class="info-item">
                                                <i class="bi bi-envelope"></i>
                                                <span><%= p.getCorreo() %></span>
                                            </div>
                                            <div class="info-item">
                                                <i class="bi bi-telephone"></i>
                                                <span><%= p.getTelefono() %></span>
                                            </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="info-stack">
                                            <div>
                                                <span class="sub-title"><%= p.getContacto() %></span> <span class="sub-text"><%= p.getDireccion() %></span> </div>
                                        </div>
                                    </td>

                                    <td>
                                        <div class="actions-cell">
                                            <a href="https://www.google.com/maps/dir/?api=1&destination=<%= direccionEncoded %>" 
                                                target="_blank" 
                                                class="btn-circle map" 
                                                title="Ver Ruta en Maps">
                                                 <i class="bi bi-geo-alt-fill"></i>
                                             </a>
                                            <a href="https://wa.me/51<%= p.getTelefono() %>?text=<%= mensajeWspEncoded %>" 
                                               target="_blank" class="btn-circle wsp" title="WhatsApp">
                                                <i class="bi bi-whatsapp"></i>
                                            </a>

                                            <a href="mailto:<%= p.getCorreo() %>?subject=<%= asuntoEncoded %>&body=<%= cuerpoEncoded %>" 
                                               class="btn-circle mail" title="Enviar Correo">
                                                <i class="bi bi-envelope-fill"></i>
                                            </a>

                                            <button onclick="eliminarProveedor(<%= p.getId_proveedor() %>)" 
                                                    class="btn-circle del" title="Eliminar">
                                                <i class="bi bi-trash-fill"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 40px;">
                                        <i class="bi bi-inbox" style="font-size: 3rem; color: #555;"></i>
                                        <p style="color: #888; margin-top: 10px;">No hay proveedores registrados</p>
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
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

    
    
    <div class="modal-confirm" id="modalProveedor">
    <div class="modal-confirm-content" style="max-width: 600px; border-color: var(--primary-color);">
        <div class="modal-confirm-header">
            <h3 class="modal-confirm-title" style="color: var(--primary-color);" id="modalProveedorTitulo">
                <i class="bi bi-plus-circle"></i> Gestionar Proveedor
            </h3>
        </div>
        
        <div class="modal-confirm-body">
            <form id="formProveedor" action="AccionesPServlet" method="post" style="text-align: left;">
                
                <input type="hidden" name="acc" id="accionProveedor" value="insertarProveedor">
                
                <input type="hidden" name="id" id="proveedorId" value="0">

                <div class="mb-3">
                    <label for="nombreEmpresa" class="form-label">Nombre de la Empresa</label>
                    <input type="text" class="form-control" id="nombreEmpresa" name="nombre_empresa" required>
                </div>

                <div class="mb-3">
                    <label for="contacto" class="form-label">Persona de Contacto</label>
                    <input type="text" class="form-control" id="contacto" name="contacto" required>
                </div>

                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono</label>
                    <input type="tel" class="form-control" id="telefono" name="telefono" required>
                </div>

                <div class="mb-3">
                    <label for="correo" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" required>
                </div>

                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección</label>
                    <textarea class="form-control" id="direccion" name="direccion" rows="3" required></textarea>
                </div>
            </form>
        </div>
        
        <div class="modal-confirm-footer">
            <button class="btn-admin" onclick="cancelarProveedor()">
                <i class="bi bi-x-circle"></i> Cancelar
            </button>
            <button class="btn-success" onclick="guardarProveedor()">
                <i class="bi bi-check-circle"></i> Guardar
            </button>
        </div>
    </div>
</div>
    <!-- Modal de confirmación para eliminar -->
   <div class="modal-confirm" id="modalEliminar">
        <div class="modal-confirm-content">
            <h3>¿Eliminar Proveedor?</h3>
            <p>Esta acción no se puede deshacer.</p>
            <div class="modal-confirm-footer">
                <button class="btn-admin" onclick="cerrarModalEliminar()">Cancelar</button>

                <button class="btn-logout" onclick="ejecutarEliminacion()">Sí, Eliminar</button>
            </div>
        </div>
    </div>
 <script>
        // Variables globales
        var productos = [];
        var categorias = [];
        var usuarios = [];
        var administradores = [];
        var proveedores = [];
        var accionConfirmar = null;
        var datosConfirmar = null;
        var isLightMode = false;
        var proveedorAEliminar = null;

        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Inicializando panel de administración...');
            cargarInformacionUsuario();
            inicializarFoquito();
            
            // Asegurar que los botones sean clickeables
            document.addEventListener('click', function(e) {
                console.log('Click en:', e.target);
            });
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

        // =============================================
        // FUNCIONES PARA PROVEEDORES
        // =============================================

        function mostrarModalAgregar() {
            console.log('Mostrando modal para agregar proveedor');
            document.getElementById('modalProveedorTitulo').innerHTML = '<i class="bi bi-plus-circle"></i> Agregar Proveedor';
            document.getElementById('formProveedor').reset();
            document.getElementById('proveedorId').value = '';
            document.getElementById('modalProveedor').classList.add('active');
        }

        function cargarDatosProveedor(boton) {
            console.log('Cargando datos del proveedor para editar');
            document.getElementById('modalProveedorTitulo').innerHTML = '<i class="bi bi-pencil-fill"></i> Editar Proveedor';
            document.getElementById('proveedorId').value = boton.getAttribute('data-id');
            document.getElementById('nombreEmpresa').value = boton.getAttribute('data-nombre');
            document.getElementById('contacto').value = boton.getAttribute('data-contacto');
            document.getElementById('telefono').value = boton.getAttribute('data-telefono');
            document.getElementById('correo').value = boton.getAttribute('data-correo');
            document.getElementById('direccion').value = boton.getAttribute('data-direccion');
            document.getElementById('modalProveedor').classList.add('active');
        }

        function cancelarProveedor() {
            console.log('Cancelando operación de proveedor');
            document.getElementById('modalProveedor').classList.remove('active');
        }

        // --- 1. ABRIR MODAL (Modo Agregar) ---
        function mostrarModalAgregarProveedor() {
            // Limpiamos el formulario por si tenía datos viejos
            document.getElementById('formProveedor').reset();

            // Configuramos para INSERTAR
            document.getElementById('accionProveedor').value = 'insertarProveedor';
            document.getElementById('proveedorId').value = '0';
            document.getElementById('modalProveedorTitulo').innerHTML = '<i class="bi bi-plus-circle"></i> Agregar Proveedor';

            // Mostramos el modal
            document.getElementById('modalProveedor').classList.add('active');
        }

        // --- 2. CERRAR MODAL ---
        function cancelarProveedor() {
            document.getElementById('modalProveedor').classList.remove('active');
        }

        // --- 3. GUARDAR (Enviar al Servlet) ---
        function guardarProveedor() {
            var form = document.getElementById('formProveedor');

            // Validamos que los campos requeridos estén llenos
            if (form.checkValidity()) {
                form.submit(); // ENVÍA LOS DATOS AL SERVLET
            } else {
                // Muestra los mensajes de error nativos del navegador (campos vacíos)
                form.reportValidity();
            }
        }

       // Variable global para recordar qué ID queremos borrar
        var proveedorAEliminar = 0;

        // FUNCIÓN 1: Se llama desde la tabla (ícono de basura)
        function eliminarProveedor(id) {
            console.log('Solicitando eliminar proveedor ID:', id);

            // 1. Guardamos el ID en la variable global
            proveedorAEliminar = id; 

            // 2. Solo mostramos el modal (NO REDIRECCIONAMOS AÚN)
            document.getElementById('modalEliminar').classList.add('active');
        }

        // FUNCIÓN 2: Se llama desde el botón "Sí, Eliminar" del modal
        function ejecutarEliminacion() {
            if (proveedorAEliminar > 0) {
                // 3. Aquí sí hacemos la redirección usando el ID guardado
                // Asegúrate que 'acc' coincida con lo que pusiste en tu Servlet
                window.location.href = "AccionesPServlet?acc=eliminarProveedor&id=" + proveedorAEliminar;
            }
        }

        // Función auxiliar para cerrar el modal si se arrepiente
        function cerrarModalEliminar() {
            document.getElementById('modalEliminar').classList.remove('active');
            proveedorAEliminar = 0; // Limpiamos la variable por seguridad
        }

        function cancelarEliminar() {
            console.log('Cancelando eliminación');
            proveedorAEliminar = null;
            document.getElementById('modalEliminar').classList.remove('active');
        }

        function confirmarEliminar() {
            if (proveedorAEliminar) {
                console.log('Confirmando eliminación del proveedor ID:', proveedorAEliminar);
                
                // Aquí iría la lógica para eliminar el proveedor
                console.log('Eliminando proveedor ID:', proveedorAEliminar);
                
                // Simulación de eliminación exitosa
                alert('Proveedor eliminado correctamente');
                document.getElementById('modalEliminar').classList.remove('active');
                proveedorAEliminar = null;
                
                // En una implementación real, aquí harías una petición AJAX o recargarías la página
                // window.location.reload();
            }
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
    </script>
</body>
</html>