<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.reflect.Method"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.sql.Timestamp"%>
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
        
        /* Estilos para la sección de pedidos */
        .messages-container {
            display: block;
        }
        .messages-list {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            border-top: 3px solid var(--primary-color);
            overflow-x: auto;
        }
        .light-mode .messages-list {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        /* Estilos específicos para pedidos */
        .table-admin { 
            width: 100%; 
            border-collapse: collapse; 
            color: var(--text-color);
        }
        .table-admin th { 
            text-align: left; 
            padding: 15px; 
            border-bottom: 2px solid var(--border-color); 
            color: var(--primary-color);
            font-weight: 600;
        }
        .table-admin td { 
            padding: 15px; 
            border-bottom: 1px solid var(--border-color); 
            vertical-align: middle; 
        }
        .table-admin tr:hover { 
            background: rgba(255,255,255,0.05); 
        }
        .light-mode .table-admin tr:hover {
            background: rgba(0,0,0,0.05);
        }
        
        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .status-pendiente {
            background: rgba(255, 193, 7, 0.15);
            color: var(--warning-color);
            border: 1px solid rgba(255, 193, 7, 0.3);
        }
        
        .status-pagado {
            background: rgba(0, 224, 255, 0.15);
            color: var(--primary-color);
            border: 1px solid rgba(0, 224, 255, 0.3);
        }
        
        .status-enviado {
            background: rgba(0, 102, 204, 0.15);
            color: var(--secondary-color);
            border: 1px solid rgba(0, 102, 204, 0.3);
        }
        
        .status-entregado {
            background: rgba(0, 204, 102, 0.15);
            color: var(--success-color);
            border: 1px solid rgba(0, 204, 102, 0.3);
        }
        
        .status-cancelado {
            background: rgba(255, 77, 77, 0.15);
            color: var(--danger-color);
            border: 1px solid rgba(255, 77, 77, 0.3);
        }
        
        /* Botones de acción */
        .actions-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }
        
        .btn-action {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            text-decoration: none;
        }
        
        .btn-view {
            background: rgba(255, 193, 7, 0.1);
            color: var(--warning-color);
            border: 1px solid rgba(255, 193, 7, 0.3);
        }
        
        .btn-view:hover {
            background: var(--warning-color);
            color: #000;
            box-shadow: 0 0 15px var(--warning-color);
            transform: scale(1.1);
        }
        
        .btn-change {
            background: rgba(0, 224, 255, 0.1);
            color: var(--primary-color);
            border: 1px solid rgba(0, 224, 255, 0.3);
        }
        
        .btn-change:hover {
            background: var(--primary-color);
            color: #000;
            box-shadow: 0 0 15px var(--primary-color);
            transform: scale(1.1);
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
        }
        .btn-logout:hover {
            background: var(--danger-color);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
        }

        /* Interruptor de foquito (Diseño original) */
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

        /* Estilos para modales */
        .modal-detalle-pedido {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }
        
        .modal-detalle-pedido.active {
            display: flex;
        }
        
        .modal-detalle-pedido-content {
            background: var(--card-bg);
            border-radius: 15px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            border: 2px solid var(--primary-color);
            animation: modalAppear 0.3s ease;
        }
        
        @keyframes modalAppear {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }
        
        .modal-detalle-pedido-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 20px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-detalle-pedido-header .modal-title {
            color: #000;
            font-weight: 700;
            margin: 0;
            font-size: 1.5rem;
        }
        
        .modal-close {
            background: none;
            border: none;
            color: #000;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 5px;
            border-radius: 50%;
            transition: all 0.3s ease;
        }
        
        .modal-close:hover {
            background: rgba(0, 0, 0, 0.1);
            transform: rotate(90deg);
        }
        
        .detalle-pedido-body {
            padding: 25px;
            max-height: 60vh;
            overflow-y: auto;
        }
        
        .detalle-pedido-footer {
            padding: 20px 25px;
            background: rgba(0, 0, 0, 0.1);
            text-align: right;
            border-top: 1px solid var(--border-color);
        }
        
        .btn-detalle {
            background: var(--primary-color);
            color: #000;
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }
        
        .btn-detalle:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
        }
        
        /* Estilos para los detalles del pedido */
        .pedido-detalle-info {
            background: rgba(0, 224, 255, 0.05);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid var(--primary-color);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
        }
        
        .info-label {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-bottom: 5px;
        }
        
        .info-value {
            font-weight: 600;
            color: var(--text-color);
        }
        
        .productos-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        
        .productos-table th {
            background: rgba(0, 224, 255, 0.1);
            padding: 12px 15px;
            text-align: left;
            color: var(--primary-color);
            border-bottom: 2px solid var(--border-color);
        }
        
        .productos-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .productos-table tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }
        
        .producto-imagen {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .resumen-total {
            background: rgba(0, 224, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            text-align: right;
            border-top: 2px solid var(--primary-color);
        }
        
        .total-line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
        
        .total-final {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-color);
            border-top: 1px solid var(--border-color);
            padding-top: 10px;
            margin-top: 10px;
        }

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
            .modal-detalle-pedido-content { width: 95%; margin: 20px; }
        }
        @media (max-width: 576px) {
            .admin-header { padding: 1rem; flex-direction: column; gap: 15px; }
            .stats-grid { grid-template-columns: 1fr; }
            .actions-container { flex-direction: column; gap: 8px; }
            .info-grid { grid-template-columns: 1fr; }
            .productos-table { font-size: 0.9rem; }
            .productos-table th, .productos-table td { padding: 8px 10px; }
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
                    <%
                        String usuarioNombre = (String) session.getAttribute("usuarioNombre");
                        if (usuarioNombre != null && !usuarioNombre.isEmpty()) {
                            out.print(usuarioNombre.substring(0, 1).toUpperCase());
                        } else {
                            out.print("AD");
                        }
                    %>
                </div>
                <div class="user-details">
                    <div class="user-name" id="userName">
                        <%
                            if (usuarioNombre != null && !usuarioNombre.isEmpty()) {
                                out.print(usuarioNombre);
                            } else {
                                out.print("Administrador");
                            }
                        %>
                    </div>
                    <div class="user-role" id="userRole">
                        <%
                            String usuarioRol = (String) session.getAttribute("usuarioRol");
                            if (usuarioRol != null && !usuarioRol.isEmpty()) {
                                out.print(usuarioRol);
                            } else {
                                out.print("Administrador");
                            }
                        %>
                    </div>
                </div>
            </div>
            
            <button class="btn-logout" onclick="location.href='login.jsp'">
                <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
            </button>
        </div>
    </header>

    <div class="admin-container">
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="Contar"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="AdminController?acc=productos"><i class="bi bi-box"></i> Productos</a></li>
                <li><a href="AdminController?acc=categorias"><i class="bi bi-tags"></i> Categorías</a></li>
                <li><a href="AdminController?acc=usuarios"><i class="bi bi-people"></i> Usuarios</a></li>
                <li><a href="AdminController?acc=mensajesWeb"><i class="bi bi-chat-dots"></i> Mensajes</a></li>
                <li><a href="AdminController?acc=proveedores"><i class="bi bi-truck"></i> Proveedores</a></li>
                <li><a href="AdminController?acc=pedidos" class="active"><i class="bi bi-cart-check"></i> Pedidos</a></li>
            </ul>
        </div>

        <div class="main-content">
            <section id="pedidos">
                <h2 class="section-title">Gestión de Pedidos</h2>
                
                <%
                    // Recuperamos los contadores del request
                    int total = request.getAttribute("totalPedidos") != null ? (Integer)request.getAttribute("totalPedidos") : 0;
                    int pendientes = request.getAttribute("pedidosPendientes") != null ? (Integer)request.getAttribute("pedidosPendientes") : 0;
                    int pagados = request.getAttribute("pedidosPagados") != null ? (Integer)request.getAttribute("pedidosPagados") : 0;
                    int enviados = request.getAttribute("pedidosEnviados") != null ? (Integer)request.getAttribute("pedidosEnviados") : 0;
                    int entregados = request.getAttribute("pedidosEntregados") != null ? (Integer)request.getAttribute("pedidosEntregados") : 0;
                    int cancelados = request.getAttribute("pedidosCancelados") != null ? (Integer)request.getAttribute("pedidosCancelados") : 0;
                %>
                
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-cart"></i></div>
                        <div class="stat-value"><%= total %></div>
                        <div class="stat-label">Total Pedidos</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-clock"></i></div>
                        <div class="stat-value"><%= pendientes %></div>
                        <div class="stat-label">Pendientes</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-credit-card"></i></div>
                        <div class="stat-value"><%= pagados %></div>
                        <div class="stat-label">Pagados</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-truck"></i></div>
                        <div class="stat-value"><%= enviados %></div>
                        <div class="stat-label">Enviados</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-check-circle"></i></div>
                        <div class="stat-value"><%= entregados %></div>
                        <div class="stat-label">Entregados</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="bi bi-x-circle"></i></div>
                        <div class="stat-value"><%= cancelados %></div>
                        <div class="stat-label">Cancelados</div>
                    </div>
                </div>
                
                <div class="messages-list">
                    <table class="table-admin table-pedidos">
                        <thead>
                            <tr>
                                <th>ID Pedido</th>
                                <th>Cliente</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Estado</th>
                                <th style="text-align: center;">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Object listaObj = request.getAttribute("listaPedidos");
                                if (listaObj != null) {
                                    List<?> lista = (List<?>) listaObj;
                                    if (!lista.isEmpty()) {
                                        for (Object obj : lista) {
                                            // EXTRAEMOS LOS DATOS USANDO REFLEXIÓN
                                            Class<?> c = obj.getClass();
                                            
                                            // 1. ID Pedido
                                            int id = (int) c.getMethod("getIdPedido").invoke(obj);
                                            
                                            // 2. Nombre Usuario (Manejo de nulls)
                                            String usuario = "Desconocido";
                                            try { usuario = (String) c.getMethod("getNombreUsuario").invoke(obj); } catch(Exception e){}
                                            if(usuario == null) usuario = "Cliente #" + c.getMethod("getIdUsuario").invoke(obj);
                                            
                                            // 3. Fecha
                                            Object fechaObj = c.getMethod("getFechaPedido").invoke(obj);
                                            String fecha = (fechaObj != null) ? fechaObj.toString() : "N/A";
                                            if(fecha.length() > 16) fecha = fecha.substring(0, 16);
                                            
                                            // 4. Total
                                            Object totalObj = c.getMethod("getTotal").invoke(obj);
                                            String totalStr = (totalObj != null) ? String.format("%.2f", totalObj) : "0.00";
                                            
                                            // 5. Estado
                                            String estado = (String) c.getMethod("getEstado").invoke(obj);
                                            if(estado == null) estado = "pendiente";
                                            
                                            // Determinamos la clase del badge
                                            String badgeClass = "status-pendiente";
                                            if(estado.equalsIgnoreCase("pagado")) badgeClass = "status-pagado";
                                            else if(estado.equalsIgnoreCase("enviado")) badgeClass = "status-enviado";
                                            else if(estado.equalsIgnoreCase("entregado")) badgeClass = "status-entregado";
                                            else if(estado.equalsIgnoreCase("cancelado")) badgeClass = "status-cancelado";
                            %>
                                    <tr>
                                        <td><strong style="color:var(--primary-color);">#<%= id %></strong></td>
                                        <td><%= usuario %></td>
                                        <td style="color:var(--text-muted);"><%= fecha %></td>
                                        <td><strong>S/ <%= totalStr %></strong></td>
                                        <td>
                                            <span class="badge-status <%= badgeClass %>">
                                                <i class="bi bi-circle-fill" style="font-size:0.5rem;"></i>
                                                <%= estado %>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="actions-container">
                                                <button class="btn-action btn-view" title="Ver Detalles" onclick="verDetallesPedido(<%= id %>)">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                
                                                <button class="btn-action btn-change" 
                                                        onclick="cambiarEstado(<%= id %>, '<%= estado %>')" 
                                                        title="Cambiar Estado">
                                                    <i class="bi bi-arrow-repeat"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                            <%
                                        }
                                    } else {
                            %>
                                <tr>
                                    <td colspan="6" style="text-align:center;padding:40px;color:var(--text-muted);">
                                        <i class="bi bi-cart-x" style="font-size:3rem;opacity:0.5;"></i>
                                        <p style="margin-top:10px;">No hay pedidos registrados</p>
                                    </td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="6" style="text-align:center;padding:40px;color:var(--danger-color);">
                                        <i class="bi bi-exclamation-triangle" style="font-size:3rem;"></i>
                                        <p style="margin-top:10px;">Error: No se pudo cargar la lista de pedidos.</p>
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

    <!-- Modal Detalle de Pedido -->
    <div class="modal-detalle-pedido" id="modalDetallePedido">
        <div class="modal-detalle-pedido-content">
            <div class="modal-detalle-pedido-header">
                <h2 class="modal-title"><i class="bi bi-clipboard-data me-2"></i>Detalle del Pedido</h2>
                <button class="modal-close" onclick="cerrarModalDetallePedido()"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="detalle-pedido-body" id="detallePedidoBody">
                <div class="text-center text-muted py-5">
                    <i class="bi bi-hourglass-split display-1"></i>
                    <p class="mt-3">Cargando detalles del pedido...</p>
                </div>
            </div>
            <div class="detalle-pedido-footer">
                <button class="btn-detalle" onclick="cerrarModalDetallePedido()">
                    <i class="bi bi-x-circle me-2"></i> Cerrar
                </button>
            </div>
        </div>
    </div>

    <script>
        // Variables globales
        var isLightMode = false;

        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {
            // Cargar info básica
            cargarInformacionUsuario();
            
            // Inicializar el foquito
            inicializarFoquito();
        });

        // Inicializar el foquito
        function inicializarFoquito() {
            const lightbulbToggle = document.getElementById('lightbulbToggle');
            const lightbulbCord = document.getElementById('lightbulbCord');
            
            // Verificar preferencia guardada
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme === 'light') {
                activarModoClaro();
            } else {
                activarModoOscuro();
            }
            
            // Evento Click
            lightbulbToggle.addEventListener('click', function() {
                // Animación
                lightbulbCord.classList.add('pull-animation');
                setTimeout(() => {
                    lightbulbCord.classList.remove('pull-animation');
                }, 500);
                
                // Cambiar modo con pequeño delay
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
            if(toggleText) toggleText.textContent = 'Modo Oscuro';
            
            isLightMode = false;
            localStorage.setItem('theme', 'dark');
            
            const lightbulbGlow = document.getElementById('lightbulbGlow');
            if(lightbulbGlow) lightbulbGlow.classList.remove('active');
        }

        // Activar modo claro
        function activarModoClaro() {
            document.body.classList.add('light-mode');
            const toggleText = document.querySelector('.lightbulb-toggle-text');
            if(toggleText) toggleText.textContent = 'Modo Claro';
            
            isLightMode = true;
            localStorage.setItem('theme', 'light');
            
            const lightbulbGlow = document.getElementById('lightbulbGlow');
            if(lightbulbGlow) lightbulbGlow.classList.add('active');
        }

        // Cargar información del usuario
        function cargarInformacionUsuario() {
            const nombreElement = document.getElementById('userName');
            const rolElement = document.getElementById('userRole');
            const avatarElement = document.getElementById('userAvatar');
            
            const nombreCompleto = nombreElement ? nombreElement.textContent.trim() : 'Usuario';
            
            if (nombreCompleto && nombreCompleto !== 'Administrador') {
                const iniciales = obtenerIniciales(nombreCompleto);
                if(avatarElement) avatarElement.textContent = iniciales;
            } else {
                if(avatarElement) avatarElement.textContent = 'AD';
            }
        }

        function obtenerIniciales(nombreCompleto) {
            return nombreCompleto.split(' ').map(n => n.charAt(0)).join('').toUpperCase().substring(0, 2);
        }

        // FUNCIÓN CORREGIDA PARA CAMBIAR ESTADO
        function cambiarEstado(id, estadoActual) {
            // Definir el ciclo de estados
            const estados = ['pendiente', 'pagado', 'enviado', 'entregado', 'cancelado'];
            
            // Encontrar el siguiente estado
            let index = estados.indexOf(estadoActual.toLowerCase());
            if (index === -1) index = 0; // Si no encuentra, asume pendiente
            
            // Calcular siguiente (circular)
            let siguiente = estados[(index + 1) % estados.length];

            // Confirmación clara
            if(confirm("¿Cambiar estado del pedido #" + id + "\nDe: " + estadoActual + "\nA: " + siguiente + "?")) {
                // Redirección al servlet cambiarEstadoPedido
                window.location.href = "cambiarEstadoPedido?idPedido=" + id + "&nuevoEstado=" + siguiente;
            }
        }

        // FUNCIÓN MEJORADA PARA VER DETALLES DEL PEDIDO
        function verDetallesPedido(idPedido) {
            console.log("Solicitando detalles del pedido:", idPedido);
            
            // Mostrar modal con loading
            document.getElementById('modalDetallePedido').classList.add('active');
            document.getElementById('detallePedidoBody').innerHTML = 
                '<div class="text-center text-muted py-5">' +
                '<i class="bi bi-hourglass-split display-1"></i>' +
                '<p class="mt-3">Cargando detalles del pedido...</p>' +
                '</div>';
            
            // Realizar petición al servlet
            fetch('PedidosServlet?accion=detalle&id=' + idPedido)
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error('Error en la respuesta del servidor: ' + response.status);
                    }
                    return response.json();
                })
                .then(function(data) {
                    console.log('Detalles del pedido recibidos:', data);
                    renderizarDetallesPedido(data, idPedido);
                })
                .catch(function(error) {
                    console.error('Error al cargar detalles del pedido:', error);
                    document.getElementById('detallePedidoBody').innerHTML = 
                        '<div class="text-center text-danger py-5">' +
                        '<i class="bi bi-exclamation-triangle display-1"></i>' +
                        '<p class="mt-3">Error al cargar los detalles del pedido</p>' +
                        '<p class="small">' + error.message + '</p>' +
                        '</div>';
                });
        }

        // FUNCIÓN PARA RENDERIZAR LOS DETALLES DEL PEDIDO
        function renderizarDetallesPedido(data, idPedido) {
            const body = document.getElementById('detallePedidoBody');
            
            if (!data || data.error) {
                body.innerHTML = 
                    '<div class="text-center text-danger py-5">' +
                    '<i class="bi bi-exclamation-triangle display-1"></i>' +
                    '<p class="mt-3">' + (data ? data.error : 'Error desconocido') + '</p>' +
                    '</div>';
                return;
            }

            // Determinar clase del estado
            var estadoClass = 'status-pendiente';
            if(data.estado === 'pagado') estadoClass = 'status-pagado';
            else if(data.estado === 'enviado') estadoClass = 'status-enviado';
            else if(data.estado === 'entregado') estadoClass = 'status-entregado';
            else if(data.estado === 'cancelado') estadoClass = 'status-cancelado';

            var html = '';
            html += '<div class="pedido-detalle-info">';
            html += '<div class="info-grid">';
            html += '<div class="info-item">';
            html += '<span class="info-label">N° Pedido</span>';
            html += '<span class="info-value">#' + idPedido + '</span>';
            html += '</div>';
            html += '<div class="info-item">';
            html += '<span class="info-label">Cliente</span>';
            html += '<span class="info-value">' + (data.cliente || 'No especificado') + '</span>';
            html += '</div>';
            html += '<div class="info-item">';
            html += '<span class="info-label">Fecha</span>';
            html += '<span class="info-value">' + (data.fecha || 'No especificada') + '</span>';
            html += '</div>';
            html += '<div class="info-item">';
            html += '<span class="info-label">Estado</span>';
            html += '<span class="badge-status ' + estadoClass + '">';
            html += '<i class="bi bi-circle-fill" style="font-size:0.5rem;"></i>';
            html += (data.estado || 'pendiente');
            html += '</span>';
            html += '</div>';
            html += '</div>';
            
            // Información de dirección si existe
            if (data.direccion) {
                html += '<div class="info-item">';
                html += '<span class="info-label">Dirección de Envío</span>';
                html += '<span class="info-value">' + data.direccion + '</span>';
                html += '</div>';
            }
            
            // Información de teléfono si existe
            if (data.telefono) {
                html += '<div class="info-item">';
                html += '<span class="info-label">Teléfono</span>';
                html += '<span class="info-value">' + data.telefono + '</span>';
                html += '</div>';
            }
            
            html += '</div>';

            // Productos del pedido
            if (data.productos && data.productos.length > 0) {
                html += '<h4 class="mb-3" style="color: var(--primary-color);">';
                html += '<i class="bi bi-box-seam me-2"></i>Productos (' + data.productos.length + ')';
                html += '</h4>';
                html += '<div class="table-responsive">';
                html += '<table class="productos-table">';
                html += '<thead>';
                html += '<tr>';
                html += '<th>Producto</th>';
                html += '<th>Precio</th>';
                html += '<th>Cantidad</th>';
                html += '<th>Subtotal</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';

                // Iterar sobre cada producto
                for (var i = 0; i < data.productos.length; i++) {
                    var producto = data.productos[i];
                    var subtotal = (producto.precio * producto.cantidad).toFixed(2);
                    
                    html += '<tr>';
                    html += '<td>';
                    html += '<div class="d-flex align-items-center">';
                    
                    if (producto.imagen) {
                        html += '<img src="' + producto.imagen + '" alt="' + (producto.nombre || 'Producto') + '" class="producto-imagen me-3">';
                    } else {
                        html += '<div class="producto-imagen me-3 bg-secondary d-flex align-items-center justify-content-center">';
                        html += '<i class="bi bi-image text-muted"></i>';
                        html += '</div>';
                    }
                    
                    html += '<div>';
                    html += '<div class="fw-bold">' + (producto.nombre || 'Producto sin nombre') + '</div>';
                    if (producto.codigo) {
                        html += '<small class="text-muted">Código: ' + producto.codigo + '</small>';
                    }
                    html += '</div>';
                    html += '</div>';
                    html += '</td>';
                    html += '<td>S/ ' + (producto.precio ? parseFloat(producto.precio).toFixed(2) : '0.00') + '</td>';
                    html += '<td>' + (producto.cantidad || 1) + '</td>';
                    html += '<td class="fw-bold">S/ ' + subtotal + '</td>';
                    html += '</tr>';
                }

                html += '</tbody>';
                html += '</table>';
                html += '</div>';
            } else {
                html += '<div class="text-center text-muted py-4">';
                html += '<i class="bi bi-cart-x display-1"></i>';
                html += '<p class="mt-3">No hay productos en este pedido</p>';
                html += '</div>';
            }

            // Resumen total
            html += '<div class="resumen-total">';
            html += '<div class="total-line">';
            html += '<span>Subtotal:</span>';
            html += '<span>S/ ' + (data.subtotal ? parseFloat(data.subtotal).toFixed(2) : '0.00') + '</span>';
            html += '</div>';
            
            if (data.envio) {
                html += '<div class="total-line">';
                html += '<span>Envío:</span>';
                html += '<span>S/ ' + parseFloat(data.envio).toFixed(2) + '</span>';
                html += '</div>';
            }
            
            html += '<div class="total-line total-final">';
            html += '<span>TOTAL:</span>';
            html += '<span>S/ ' + (data.total ? parseFloat(data.total).toFixed(2) : '0.00') + '</span>';
            html += '</div>';
            html += '</div>';

            body.innerHTML = html;
        }

        // Cerrar modal de detalles
        function cerrarModalDetallePedido() {
            document.getElementById('modalDetallePedido').classList.remove('active');
        }

        // Cerrar modal al presionar ESC
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                cerrarModalDetallePedido();
            }
        });

        // Cerrar modal al hacer click fuera del contenido
        document.getElementById('modalDetallePedido').addEventListener('click', function(event) {
            if (event.target === this) {
                cerrarModalDetallePedido();
            }
        });
    </script>
</body>
</html>