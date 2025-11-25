<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tienda | DonGlai - Iluminación LED</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/donglai.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #00e0ff;
            --secondary-color: #00a2ff;
            --dark-bg: #0d0d0d;
            --card-bg: #1a1a1a;
            --cursor-hue: 180;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: #fff;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            cursor: none;
        }

        /* Header Simple */
        .tienda-header {
            background: linear-gradient(90deg, #000000, #0a0a0a, #141414);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--primary-color);
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo {
            height: 50px;
            border-radius: 8px;
        }

        .brand-text {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.5rem;
        }

        /* Información del usuario */
        .user-info-section {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-welcome {
            background: rgba(0, 224, 255, 0.1);
            border: 1px solid var(--primary-color);
            border-radius: 10px;
            padding: 8px 15px;
            text-align: center;
        }

        .user-name {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            display: block;
        }

        .user-email {
            color: #888;
            font-size: 0.8rem;
            display: block;
        }

        .user-role {
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid #ffc107;
            border-radius: 15px;
            padding: 4px 12px;
            font-size: 0.8rem;
            color: #ffc107;
            font-weight: 600;
        }

        /* Botón del carrito - AHORA OCULTO */
        .btn-carrito-header {
            position: relative;
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-right: 15px;
            display: none; /* OCULTAMOS EL BOTÓN DEL CARRITO */
        }

        .btn-carrito-header:hover {
            background: var(--primary-color);
            color: #000;
            transform: translateY(-2px);
        }

        .carrito-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff4444;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .btn-logout {
            background: transparent;
            border: 2px solid #ff4d4d;
            color: #ff4d4d;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn-logout:hover {
            background: #ff4d4d;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.3);
        }

        .btn-logout:active {
            transform: translateY(0);
        }

        .btn-logout.loading {
            pointer-events: none;
            opacity: 0.7;
        }

        .btn-logout.loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: loading-shine 1.5s infinite;
        }

        @keyframes loading-shine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        /* Efecto LED del Mouse */
        .cursor-led {
            position: fixed;
            width: 24px;
            height: 24px;
            pointer-events: none;
            z-index: 9999;
            mix-blend-mode: screen;
            transition: transform 0.1s ease, width 0.3s ease, height 0.3s ease;
            filter: drop-shadow(0 0 8px hsl(var(--cursor-hue), 100%, 50%));
        }

        .cursor-led::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, 
                hsl(var(--cursor-hue), 100%, 70%) 0%, 
                hsl(calc(var(--cursor-hue) + 30), 100%, 50%) 30%, 
                transparent 70%);
            border-radius: 50%;
            animation: pulse 2s infinite ease-in-out;
            filter: blur(8px);
        }

        .cursor-led::after {
            content: '';
            position: absolute;
            width: 10px;
            height: 10px;
            background: hsl(var(--cursor-hue), 100%, 50%);
            border-radius: 50%;
            top: 7px;
            left: 7px;
            box-shadow: 
                0 0 15px hsl(var(--cursor-hue), 100%, 50%), 
                0 0 30px hsl(var(--cursor-hue), 100%, 50%),
                0 0 45px hsl(calc(var(--cursor-hue) + 30), 100%, 50%);
            animation: inner-pulse 1.5s infinite alternate;
        }

        .cursor-trail {
            position: fixed;
            width: 8px;
            height: 8px;
            background: hsl(var(--trail-hue, 180), 100%, 50%);
            border-radius: 50%;
            pointer-events: none;
            z-index: 9998;
            box-shadow: 
                0 0 12px hsl(var(--trail-hue, 180), 100%, 50%), 
                0 0 24px hsl(var(--trail-hue, 180), 100%, 50%);
            opacity: 0;
            animation: trail-fade 0.8s ease-out forwards;
        }

        .cursor-particle {
            position: fixed;
            width: 4px;
            height: 4px;
            background: hsl(var(--particle-hue, 180), 100%, 60%);
            border-radius: 50%;
            pointer-events: none;
            z-index: 9997;
            box-shadow: 0 0 8px hsl(var(--particle-hue, 180), 100%, 60%);
            opacity: 0;
            animation: particle-fly 1s ease-out forwards;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.7; }
            50% { transform: scale(1.3); opacity: 0.4; }
        }

        @keyframes inner-pulse {
            0% { transform: scale(1); }
            100% { transform: scale(1.2); }
        }

        @keyframes trail-fade {
            0% { transform: scale(1) translate(0, 0); opacity: 0.8; }
            100% { transform: scale(0.2) translate(var(--trail-dx, 0), var(--trail-dy, 0)); opacity: 0; }
        }

        @keyframes particle-fly {
            0% { transform: translate(0, 0) scale(1); opacity: 0.8; }
            100% { transform: translate(var(--particle-dx, 0), var(--particle-dy, 0)) scale(0); opacity: 0; }
        }

        .cursor-hover {
            transform: scale(1.8);
            width: 30px;
            height: 30px;
        }

        .cursor-hover::after {
            background: #ff00ff;
        }

        .cursor-click {
            transform: scale(0.7);
        }

        .cursor-click::after {
            background: #ffff00;
        }

        .hero {
            background: radial-gradient(circle at center, #1b1b1b 0%, #000000 100%);
            text-align: center;
            padding: 60px 20px;
        }

        .hero h1 {
            color: var(--primary-color);
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 0 10px rgba(0, 224, 255, 0.5);
        }

        .hero p {
            font-size: 1.2rem;
            color: #ccc;
            max-width: 600px;
            margin: 0 auto;
        }

        .tienda-section {
            padding: 60px 20px;
            background: linear-gradient(to bottom, #0d0d0d, #1a1a1a);
            min-height: 100vh;
        }
        
        .filtros-container {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            border-left: 4px solid var(--primary-color);
        }
        
        .filtros-title {
            color: var(--primary-color);
            font-size: 1.5rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .categorias-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .categoria-btn {
            background: #2a2a2a;
            border: 2px solid #444;
            border-radius: 10px;
            padding: 15px;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            font-weight: 600;
            text-decoration: none;
            display: block;
        }
        
        .categoria-btn:hover {
            border-color: var(--primary-color);
            transform: translateY(-2px);
            color: #fff;
            text-decoration: none;
        }
        
        .categoria-btn.active {
            background: rgba(0, 224, 255, 0.1);
            border-color: var(--primary-color);
            box-shadow: 0 0 15px rgba(0, 224, 255, 0.3);
        }
        
        .search-form {
            position: relative;
            margin-bottom: 20px;
        }
        
        .search-input {
            background: #2a2a2a;
            border: 1px solid #444;
            border-radius: 25px;
            color: #fff;
            padding: 12px 50px 12px 20px;
            width: 100%;
            font-size: 1rem;
        }
        
        .search-input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 10px rgba(0, 224, 255, 0.3);
        }
        
        .search-button {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--primary-color);
            font-size: 1.2rem;
            cursor: pointer;
        }
        
        .productos-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 30px;
        }
        
        .producto-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            border-top: 3px solid var(--primary-color);
        }
        
        .producto-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 224, 255, 0.3);
        }
        
        .producto-imagen {
            width: 100%;
            height: 250px;
            background: linear-gradient(135deg, #2a2a2a, #333);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 3rem;
            overflow: hidden;
            position: relative;
        }

        .producto-imagen img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .producto-card:hover .producto-imagen img {
            transform: scale(1.05);
        }
        
        .producto-info {
            padding: 20px;
        }
        
        .producto-categoria {
            background: rgba(0, 224, 255, 0.1);
            color: var(--primary-color);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .producto-nombre {
            color: #fff;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px;
            line-height: 1.3;
        }
        
        .producto-descripcion {
            color: #ccc;
            font-size: 0.9rem;
            margin-bottom: 15px;
            line-height: 1.5;
            height: 60px;
            overflow: hidden;
        }
        
        .producto-precio {
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .producto-stock {
            color: #aaa;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        
        .stock-disponible {
            color: #00cc66;
        }
        
        .stock-agotado {
            color: #ff4d4d;
        }
        
        /* BOTÓN PEDIR PRODUCTO - NUEVO ESTILO */
        .btn-pedir {
            background: linear-gradient(135deg, #25D366, #128C7E);
            border: none;
            color: white;
            font-weight: 700;
            border-radius: 25px;
            padding: 12px 25px;
            width: 100%;
            transition: all 0.3s ease;
            cursor: pointer;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-pedir:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 211, 102, 0.4);
            background: linear-gradient(135deg, #20bd5f, #0f7a5f);
            color: white;
            text-decoration: none;
        }
        
        .btn-pedir:disabled {
            background: #555;
            color: #888;
            cursor: not-allowed;
        }
        
        .btn-detalle {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-weight: 600;
            border-radius: 25px;
            padding: 10px 20px;
            width: 100%;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .btn-detalle:hover {
            background: var(--primary-color);
            color: #000;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
        }
        
        .no-products {
            text-align: center;
            padding: 60px 20px;
            color: #aaa;
            grid-column: 1 / -1;
        }
        
        .no-products i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        footer {
            background-color: #000;
            color: #aaa;
            text-align: center;
            padding: 25px 0;
            margin-top: 50px;
        }

        .resultados-info {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .clear-filters {
            display: inline-block;
            margin-left: 15px;
            color: #ccc;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .clear-filters:hover {
            color: var(--primary-color);
        }

        .producto-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.8);
            color: var(--primary-color);
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .loading {
            text-align: center;
            padding: 60px 20px;
            color: var(--primary-color);
            grid-column: 1 / -1;
        }

        .loading i {
            font-size: 3rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .error-details {
            background: rgba(255, 77, 77, 0.1);
            border: 1px solid #ff4d4d;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            text-align: left;
            font-size: 0.9rem;
            color: #ffaaaa;
        }

        /* Modal de detalles */
        .modal-detalle {
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

        .modal-detalle.active {
            opacity: 1;
            visibility: visible;
        }

        .modal-detalle-content {
            background: var(--card-bg);
            border-radius: 20px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 20px 50px rgba(0, 224, 255, 0.3);
            border: 2px solid var(--primary-color);
            transform: scale(0.9);
            transition: transform 0.3s ease;
        }

        .modal-detalle.active .modal-detalle-content {
            transform: scale(1);
        }

        .modal-detalle-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid #333;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 20px 20px 0 0;
        }

        .modal-detalle-title {
            color: var(--primary-color);
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
        }

        .modal-detalle-close {
            background: none;
            border: none;
            color: #fff;
            font-size: 1.5rem;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .modal-detalle-close:hover {
            color: var(--primary-color);
        }

        .modal-detalle-body {
            padding: 25px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .modal-detalle-imagen {
            width: 100%;
            height: 300px;
            background: linear-gradient(135deg, #2a2a2a, #333);
            border-radius: 15px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-detalle-imagen img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .modal-detalle-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .modal-detalle-categoria {
            background: rgba(0, 224, 255, 0.1);
            color: var(--primary-color);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 15px;
            grid-column: 1 / -1;
        }

        .modal-detalle-descripcion {
            color: #ccc;
            font-size: 1rem;
            line-height: 1.6;
            grid-column: 1 / -1;
            margin-bottom: 10px;
        }

        .modal-detalle-precio {
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .modal-detalle-stock {
            color: #aaa;
            font-size: 1rem;
            margin-bottom: 15px;
        }

        .modal-detalle-especificaciones {
            grid-column: 1 / -1;
            margin-top: 10px;
        }

        .modal-detalle-especificaciones h4 {
            color: var(--primary-color);
            margin-bottom: 10px;
            font-size: 1.2rem;
        }

        .modal-detalle-especificaciones ul {
            padding-left: 20px;
            color: #ccc;
        }

        .modal-detalle-especificaciones li {
            margin-bottom: 8px;
            line-height: 1.5;
        }

        .modal-detalle-actions {
            display: flex;
            gap: 15px;
            grid-column: 1 / -1;
            margin-top: 15px;
        }

        .modal-detalle-actions .btn-pedir {
            width: auto;
            flex: 1;
        }

        .modal-detalle-actions .btn-detalle {
            width: auto;
            flex: 1;
        }

        /* Notificaciones */
        .notificacion {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            z-index: 10001;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transform: translateX(400px);
            transition: transform 0.3s ease;
            max-width: 350px;
        }

        .notificacion.show {
            transform: translateX(0);
        }

        .notificacion.success {
            background: linear-gradient(135deg, #00cc66, #00a852);
            border-left: 4px solid #00ff88;
        }

        .notificacion.error {
            background: linear-gradient(135deg, #ff4d4d, #cc0000);
            border-left: 4px solid #ff8888;
        }

        .notificacion.warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            border-left: 4px solid #ffd54f;
            color: #000;
        }

        /* Modal de Confirmación de Cierre de Sesión */
        .modal-confirmacion {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 10002;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .modal-confirmacion.active {
            opacity: 1;
            visibility: visible;
        }

        .modal-confirmacion-content {
            background: var(--card-bg);
            border-radius: 20px;
            width: 90%;
            max-width: 450px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 20px 50px rgba(0, 224, 255, 0.3);
            border: 2px solid var(--primary-color);
            transform: scale(0.9);
            transition: transform 0.3s ease;
        }

        .modal-confirmacion.active .modal-confirmacion-content {
            transform: scale(1);
        }

        .modal-confirmacion-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .modal-confirmacion-title {
            color: var(--primary-color);
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .modal-confirmacion-message {
            color: #ccc;
            font-size: 1rem;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .modal-confirmacion-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn-cancelar {
            background: transparent;
            border: 2px solid #6c757d;
            color: #6c757d;
            font-weight: 600;
            border-radius: 25px;
            padding: 12px 25px;
            transition: all 0.3s ease;
            cursor: pointer;
            flex: 1;
        }

        .btn-cancelar:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-2px);
        }

        .btn-confirmar {
            background: linear-gradient(135deg, #ff4d4d, #cc0000);
            border: none;
            color: white;
            font-weight: 700;
            border-radius: 25px;
            padding: 12px 25px;
            transition: all 0.3s ease;
            cursor: pointer;
            flex: 1;
        }

        .btn-confirmar:hover {
            background: linear-gradient(135deg, #ff3333, #b30000);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
        }

        /* Loading durante cierre de sesión */
        .logout-loading {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 10003;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .logout-loading.active {
            display: flex;
        }

        .logout-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(0, 224, 255, 0.3);
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 20px;
        }

        .logout-text {
            color: var(--primary-color);
            font-size: 1.2rem;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .productos-grid {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 20px;
            }
            
            .categorias-grid {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
            
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .tienda-header {
                padding: 1rem;
                flex-direction: column;
                gap: 15px;
            }
            
            .user-info-section {
                flex-direction: column;
                gap: 10px;
            }
            
            body {
                cursor: auto;
            }
            
            .cursor-led, .cursor-trail, .cursor-particle {
                display: none;
            }
            
            .modal-detalle-info {
                grid-template-columns: 1fr;
            }
            
            .modal-detalle-actions {
                flex-direction: column;
            }
            
            .modal-confirmacion-actions {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <!-- Efecto LED del Mouse -->
    <div class="cursor-led" id="cursorLed"></div>

    <!-- Header Simple -->
    <header class="tienda-header">
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/img/donglai.jpg" alt="DonGlai Logo" class="logo">
            <div class="brand-text">DonGlai LED</div>
        </div>
        
        <!-- Información del usuario y carrito -->
        <div class="user-info-section" id="userInfoSection" style="display: none;">
            <!-- Botón del Carrito - OCULTO -->
            <button class="btn-carrito-header" onclick="verCarrito()" style="display: none;">
                <i class="bi bi-cart3"></i>
                Carrito
                <span class="carrito-badge" id="carritoBadge" style="display: none;">0</span>
            </button>
            
            <div class="user-welcome">
                <span class="user-name" id="userName">
                    <i class="bi bi-person-circle me-1"></i>
                    <span id="userNameText">Cargando...</span>
                </span>
                <span class="user-email" id="userEmail"></span>
            </div>
            <div class="user-role" id="userRole">Cliente</div>
            <button class="btn-logout" onclick="mostrarConfirmacionCerrarSesion()" id="btnLogout">
                <i class="bi bi-box-arrow-right"></i>
                Cerrar Sesión
            </button>
        </div>
    </header>

    <!-- Modal de Confirmación de Cierre de Sesión -->
    <div class="modal-confirmacion" id="modalConfirmacion">
        <div class="modal-confirmacion-content">
            <div class="modal-confirmacion-icon">
                <i class="bi bi-question-circle"></i>
            </div>
            <h2 class="modal-confirmacion-title">¿Cerrar Sesión?</h2>
            <p class="modal-confirmacion-message" id="confirmacionMensaje">
                Estás a punto de cerrar tu sesión. ¿Estás seguro de que quieres continuar?
            </p>
            <div class="modal-confirmacion-actions">
                <button class="btn-cancelar" onclick="ocultarConfirmacionCerrarSesion()">
                    <i class="bi bi-x-circle me-2"></i>Cancelar
                </button>
                <button class="btn-confirmar" onclick="confirmarCerrarSesion()" id="btnConfirmarLogout">
                    <i class="bi bi-check-circle me-2"></i>Sí, Cerrar Sesión
                </button>
            </div>
        </div>
    </div>

    <!-- Loading durante cierre de sesión -->
    <div class="logout-loading" id="logoutLoading">
        <div class="logout-spinner"></div>
        <div class="logout-text">Cerrando sesión...</div>
    </div>

    <!-- Hero -->
    <section class="hero">
        <h1>Nuestra Tienda LED</h1>
        <p>Descubre nuestra amplia gama de productos de iluminación LED de alta calidad</p>
    </section>
    
    <!-- Tienda -->
    <section class="tienda-section">
        <div class="container">
            <div class="filtros-container">
                <h2 class="filtros-title">Filtrar Productos</h2>
                
                <!-- Formulario de búsqueda -->
                <div class="search-form">
                    <input type="text" class="search-input" id="searchInput" 
                           placeholder="Buscar productos por nombre, descripción o categoría...">
                    <button type="button" class="search-button" onclick="buscarProductos()">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                
                <!-- Categorías -->
                <div class="categorias-grid" id="categoriasContainer">
                    <a href="javascript:void(0)" onclick="filtrarPorCategoria('todas')" 
                       class="categoria-btn active" data-categoria="todas">
                        <i class="bi bi-grid-3x3-gap me-2"></i>Todas las Categorías
                    </a>
                </div>
            </div>
            
            <!-- Información de resultados -->
            <div class="resultados-info" id="resultadosInfo">
                <i class="bi bi-info-circle me-2"></i>
                Cargando productos...
            </div>
            
            <!-- Productos -->
            <div class="productos-grid" id="productosContainer">
                <div class="loading">
                    <i class="bi bi-arrow-repeat"></i>
                    <h3>Cargando productos...</h3>
                </div>
            </div>
        </div>
    </section>

    <!-- Modal para detalles del producto -->
    <div class="modal-detalle" id="modalDetalle">
        <div class="modal-detalle-content">
            <div class="modal-detalle-header">
                <h2 class="modal-detalle-title" id="modalDetalleTitle">Detalles del Producto</h2>
                <button class="modal-detalle-close" id="modalDetalleClose">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
            <div class="modal-detalle-body" id="modalDetalleBody">
                <!-- El contenido se llenará dinámicamente con JavaScript -->
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p>© 2025 DonGlai - Innovando en Iluminación LED</p>
            <p class="small mt-2">
                <i class="bi bi-truck me-1"></i>Envíos a todo el Perú 
                <i class="bi bi-shield-check ms-3 me-1"></i>Garantía incluida
                <i class="bi bi-headset ms-3 me-1"></i>Soporte 24/7
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // =============================================
        // VERIFICACIÓN DE SESIÓN Y INICIALIZACIÓN
        // =============================================

        document.addEventListener('DOMContentLoaded', function() {
            console.log('🔄 Verificando sesión de usuario...');
            
            // Inicializar tienda sin verificar sesión primero
            iniciarTienda();
        });

        function iniciarTienda() {
            console.log('🏪 Iniciando tienda...');
            
            // Inicializar efecto LED del mouse mejorado
            initLedCursor();
            
            // Configurar el modal
            setupModal();
            
            // Intentar cargar datos del usuario (puede fallar si no hay sesión)
            cargarDatosUsuario();
            
            // Cargar productos
            cargarProductos();
            
            // Listener para búsqueda con Enter
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    buscarProductos();
                }
            });
        }

        // =============================================
        // EFECTO LED DEL MOUSE MEJORADO
        // =============================================
        var cursorLed = document.getElementById('cursorLed');
        var trails = [];
        var particles = [];
        var lastX = 0;
        var lastY = 0;
        var trailTimer = null;
        var hue = 180;
        var hueDirection = 1;
        var lastTrailTime = 0;
        var trailInterval = 30;

        function updateCursorColor() {
            hue += hueDirection;
            if (hue >= 300) hueDirection = -1;
            if (hue <= 150) hueDirection = 1;
            document.documentElement.style.setProperty('--cursor-hue', hue);
            requestAnimationFrame(updateCursorColor);
        }

        function createTrail(x, y) {
            var currentTime = Date.now();
            if (currentTime - lastTrailTime < trailInterval) return;
            lastTrailTime = currentTime;
            
            var trail = document.createElement('div');
            trail.className = 'cursor-trail';
            var trailHue = (hue + Math.random() * 60 - 30) % 360;
            trail.style.setProperty('--trail-hue', trailHue);
            
            var angle = Math.random() * Math.PI * 2;
            var distance = 5 + Math.random() * 10;
            var dx = Math.cos(angle) * distance;
            var dy = Math.sin(angle) * distance;
            
            trail.style.setProperty('--trail-dx', dx + 'px');
            trail.style.setProperty('--trail-dy', dy + 'px');
            trail.style.left = (x - 4) + 'px';
            trail.style.top = (y - 4) + 'px';
            document.body.appendChild(trail);
            trails.push(trail);
            
            setTimeout(function() {
                if (trail.parentNode) trail.parentNode.removeChild(trail);
                var index = trails.indexOf(trail);
                if (index > -1) trails.splice(index, 1);
            }, 800);
            
            if (Math.random() > 0.7) createParticle(x, y);
        }

        function createParticle(x, y) {
            var particle = document.createElement('div');
            particle.className = 'cursor-particle';
            var particleHue = (hue + Math.random() * 120 - 60) % 360;
            particle.style.setProperty('--particle-hue', particleHue);
            
            var angle = Math.random() * Math.PI * 2;
            var distance = 20 + Math.random() * 50;
            var dx = Math.cos(angle) * distance;
            var dy = Math.sin(angle) * distance;
            
            particle.style.setProperty('--particle-dx', dx + 'px');
            particle.style.setProperty('--particle-dy', dy + 'px');
            particle.style.left = (x - 2) + 'px';
            particle.style.top = (y - 2) + 'px';
            document.body.appendChild(particle);
            particles.push(particle);
            
            setTimeout(function() {
                if (particle.parentNode) particle.parentNode.removeChild(particle);
                var index = particles.indexOf(particle);
                if (index > -1) particles.splice(index, 1);
            }, 1000);
        }

        function moveCursor(e) {
            var x = e.clientX;
            var y = e.clientY;
            cursorLed.style.left = (x - 12) + 'px';
            cursorLed.style.top = (y - 12) + 'px';
            
            var distance = Math.sqrt(Math.pow(x - lastX, 2) + Math.pow(y - lastY, 2));
            if (distance > 5) {
                createTrail(x, y);
                lastX = x;
                lastY = y;
            }
        }

        function setupHoverEffects() {
            var hoverElements = document.querySelectorAll('a, button, .categoria-btn, .producto-card, .btn-pedir, .btn-detalle, .search-input, .btn-logout');
            
            for (var i = 0; i < hoverElements.length; i++) {
                var element = hoverElements[i];
                element.addEventListener('mouseenter', function() {
                    cursorLed.classList.add('cursor-hover');
                });
                element.addEventListener('mouseleave', function() {
                    cursorLed.classList.remove('cursor-hover');
                });
            }
            
            document.addEventListener('mousedown', function() {
                cursorLed.classList.add('cursor-click');
            });
            document.addEventListener('mouseup', function() {
                cursorLed.classList.remove('cursor-click');
            });
        }

        function initLedCursor() {
            if (window.matchMedia("(pointer: coarse)").matches) {
                cursorLed.style.display = 'none';
                return;
            }
            document.addEventListener('mousemove', moveCursor);
            setupHoverEffects();
            updateCursorColor();
        }

        // =============================================
        // FUNCIONES PARA MANEJAR DATOS DEL USUARIO
        // =============================================

        function cargarDatosUsuario() {
            console.log('👤 Cargando datos del usuario...');
            
            fetch('UsuarioServlet?accion=obtenerDatos', {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al obtener datos del usuario');
                }
                return response.json();
            })
            .then(usuario => {
                console.log('✅ Datos del usuario recibidos:', usuario);
                mostrarDatosUsuario(usuario);
            })
            .catch(error => {
                console.error('❌ Error al cargar datos del usuario:', error);
                // Ocultar sección de usuario si hay error
                document.getElementById('userInfoSection').style.display = 'none';
            });
        }

        function mostrarDatosUsuario(usuario) {
            const userInfoSection = document.getElementById('userInfoSection');
            const userNameText = document.getElementById('userNameText');
            const userEmail = document.getElementById('userEmail');
            const userRole = document.getElementById('userRole');
            
            if (usuario && usuario.id > 0) {
                // Mostrar información del usuario
                userNameText.textContent = usuario.nombre || 'Usuario';
                userEmail.textContent = usuario.email || '';
                
                // Configurar rol
                if (usuario.rol === 'admin') {
                    userRole.textContent = 'Administrador';
                    userRole.style.background = 'rgba(220, 53, 69, 0.1)';
                    userRole.style.borderColor = '#dc3545';
                    userRole.style.color = '#dc3545';
                } else {
                    userRole.textContent = 'Cliente';
                }
                
                // Mostrar la sección
                userInfoSection.style.display = 'flex';
                
                console.log('👋 Bienvenido: ' + (usuario.nombre || 'Usuario'));
            } else {
                // Ocultar si no hay datos válidos
                userInfoSection.style.display = 'none';
            }
        }

        // =============================================
        // SISTEMA MEJORADO DE CIERRE DE SESIÓN
        // =============================================

        // Variables para el control de sesión
        let logoutInProgress = false;

        // Función para mostrar confirmación de cierre de sesión
        function mostrarConfirmacionCerrarSesion() {
            if (logoutInProgress) return;
            
            const modal = document.getElementById('modalConfirmacion');
            const userName = document.getElementById('userNameText').textContent;
            const mensaje = document.getElementById('confirmacionMensaje');
            
            // Personalizar mensaje con el nombre del usuario
            mensaje.innerHTML = `Hola <strong>${userName}</strong>,<br>¿Estás seguro de que quieres cerrar sesión?`;
            
            modal.classList.add('active');
            
            // Agregar listener para tecla Escape
            document.addEventListener('keydown', manejarTecladoConfirmacion);
        }

        // Función para ocultar confirmación
        function ocultarConfirmacionCerrarSesion() {
            const modal = document.getElementById('modalConfirmacion');
            modal.classList.remove('active');
            document.removeEventListener('keydown', manejarTecladoConfirmacion);
        }

        // Manejar teclado en la confirmación
        function manejarTecladoConfirmacion(e) {
            if (e.key === 'Escape') {
                ocultarConfirmacionCerrarSesion();
            } else if (e.key === 'Enter') {
                confirmarCerrarSesion();
            }
        }

        // Función principal de cierre de sesión
        async function confirmarCerrarSesion() {
            if (logoutInProgress) return;
            
            logoutInProgress = true;
            
            const modal = document.getElementById('modalConfirmacion');
            const loading = document.getElementById('logoutLoading');
            const btnConfirmar = document.getElementById('btnConfirmarLogout');
            const btnLogout = document.getElementById('btnLogout');
            
            // Ocultar modal y mostrar loading
            modal.classList.remove('active');
            loading.classList.add('active');
            btnLogout.classList.add('loading');
            btnConfirmar.disabled = true;
            btnConfirmar.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Procesando...';
            
            try {
                console.log('🚪 Iniciando cierre de sesión...');
                
                const response = await fetch('UsuarioServlet?accion=logout', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                });

                const data = await response.json();
                
                if (data.success) {
                    console.log('✅ Sesión cerrada exitosamente');
                    mostrarNotificacion('👋 Sesión cerrada correctamente', 'success');
                    
                    // Redirigir después de un breve delay
                    setTimeout(() => {
                        window.location.href = 'login.jsp';
                    }, 1500);
                    
                } else {
                    throw new Error(data.error || 'Error desconocido al cerrar sesión');
                }
                
            } catch (error) {
                console.error('❌ Error al cerrar sesión:', error);
                manejarErrorCerrarSesion(error);
            } finally {
                // Re-enable buttons even on error
                setTimeout(() => {
                    resetearEstadoBotones();
                }, 2000);
            }
        }

        // Manejar errores de cierre de sesión
        function manejarErrorCerrarSesion(error) {
            const mensajeError = obtenerMensajeError(error);
            mostrarNotificacion(`❌ ${mensajeError}`, 'error');
            
            // Si es error de conexión, forzar redirección
            if (error.message.includes('Failed to fetch') || error.message.includes('Network')) {
                setTimeout(() => {
                    mostrarNotificacion('🔃 Redirigiendo al login...', 'warning');
                    setTimeout(() => {
                        window.location.href = 'login.jsp';
                    }, 1000);
                }, 2000);
            }
        }

        // Obtener mensaje de error amigable
        function obtenerMensajeError(error) {
            const mensajes = {
                'Failed to fetch': 'Error de conexión. Verifica tu internet.',
                'Network Error': 'Error de red. Intenta nuevamente.',
                'timeout': 'Tiempo de espera agotado.'
            };
            
            for (const [key, mensaje] of Object.entries(mensajes)) {
                if (error.message.includes(key)) {
                    return mensaje;
                }
            }
            
            return error.message || 'Error al cerrar sesión';
        }

        // Resetear estado de los botones
        function resetearEstadoBotones() {
            const btnConfirmar = document.getElementById('btnConfirmarLogout');
            const btnLogout = document.getElementById('btnLogout');
            const loading = document.getElementById('logoutLoading');
            
            btnConfirmar.disabled = false;
            btnConfirmar.innerHTML = '<i class="bi bi-check-circle me-2"></i>Sí, Cerrar Sesión';
            btnLogout.classList.remove('loading');
            loading.classList.remove('active');
            logoutInProgress = false;
        }

        // =============================================
        // CÓDIGO ORIGINAL DE LA TIENDA
        // =============================================
        var productosOriginales = [];
        var productosFiltrados = [];
        var categoriaActual = 'todas';
        var busquedaActual = '';

        // Configurar el modal de detalles
        function setupModal() {
            var modal = document.getElementById('modalDetalle');
            var closeBtn = document.getElementById('modalDetalleClose');
            
            closeBtn.addEventListener('click', function() {
                modal.classList.remove('active');
            });
            
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.classList.remove('active');
                }
            });
            
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('active')) {
                    modal.classList.remove('active');
                }
            });
        }

        // Función para cargar productos desde el servlet
        function cargarProductos() {
            var url = 'ProductosServlet';
            console.log('📡 Solicitando productos a:', url);
            
            fetch(url, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            })
            .then(function(response) {
                console.log('📨 Respuesta recibida - Status:', response.status);
                
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ' - ' + response.statusText);
                }
                
                return response.text();
            })
            .then(function(texto) {
                console.log('📄 Respuesta del servidor (primeros 500 caracteres):', texto.substring(0, 500));
                
                try {
                    var data = JSON.parse(texto);
                    console.log('✅ JSON parseado correctamente');
                    
                    if (!Array.isArray(data)) {
                        throw new Error('La respuesta no es un array. Tipo recibido: ' + typeof data);
                    }
                    
                    if (data.length === 0) {
                        mostrarMensajeSinProductos();
                        return;
                    }
                    
                    productosOriginales = data;
                    productosFiltrados = data;
                    
                    console.log('✅ Productos cargados:', data.length);
                    
                    cargarCategorias(data);
                    mostrarProductos(data);
                    actualizarInfoResultados();
                    
                } catch (parseError) {
                    console.error('❌ Error al parsear JSON:', parseError);
                    throw new Error('El servidor no devolvió un JSON válido: ' + parseError.message);
                }
            })
            .catch(function(error) {
                console.error('❌ Error completo:', error);
                mostrarErrorCarga(error);
            });
        }

        function mostrarMensajeSinProductos() {
            var container = document.getElementById('productosContainer');
            container.innerHTML = 
                '<div class="no-products">' +
                '<i class="bi bi-inbox"></i>' +
                '<h3>No hay productos disponibles</h3>' +
                '<p>La base de datos no contiene productos en este momento</p>' +
                '<button class="btn btn-pedir mt-3" onclick="cargarProductos()" style="width: auto; padding: 10px 20px;">' +
                '<i class="bi bi-arrow-repeat me-2"></i>Reintentar' +
                '</button>' +
                '</div>';
            
            document.getElementById('resultadosInfo').innerHTML = 
                '<i class="bi bi-info-circle me-2"></i>No hay productos disponibles';
        }

        function mostrarErrorCarga(error) {
            console.error('❌ Mostrando error de carga:', error);
            
            var container = document.getElementById('productosContainer');
            var mensajeError = error.message || 'Error desconocido';
            
            container.innerHTML = 
                '<div class="no-products">' +
                '<i class="bi bi-exclamation-triangle"></i>' +
                '<h3>Error al cargar productos</h3>' +
                '<p>' + mensajeError + '</p>' +
                '<div class="error-details">' +
                '<strong>Información técnica:</strong><br>' +
                'URL: ${pageContext.request.contextPath}/ProductosServlet<br>' +
                'Verifica:<br>' +
                '• El servlet está configurado correctamente<br>' +
                '• La base de datos tiene conexión<br>' +
                '• Los procedimientos almacenados existen<br>' +
                '• Revisa la consola del navegador (F12) para más detalles' +
                '</div>' +
                '<button class="btn btn-pedir mt-3" onclick="cargarProductos()" style="width: auto; padding: 10px 20px;">' +
                '<i class="bi bi-arrow-repeat me-2"></i>Reintentar' +
                '</button>' +
                '</div>';
            
            document.getElementById('resultadosInfo').innerHTML = 
                '<i class="bi bi-exclamation-triangle me-2"></i>Error al cargar productos';
        }

        function cargarCategorias(productos) {
            console.log('🏷️ Extrayendo categorías de', productos.length, 'productos');
            
            var categoriasMap = {};
            
            for (var i = 0; i < productos.length; i++) {
                var p = productos[i];
                if (p.id_categoria && p.nombre_categoria) {
                    categoriasMap[p.id_categoria] = p.nombre_categoria;
                }
            }
            
            console.log('📂 Categorías encontradas:', categoriasMap);

            var iconos = {
                1: 'bi-lightbulb',
                2: 'bi-lightning',
                3: 'bi-lamp',
                4: 'bi-display',
                5: 'bi-cpu'
            };

            var html = 
                '<a href="javascript:void(0)" onclick="filtrarPorCategoria(\'todas\')" ' +
                'class="categoria-btn active" data-categoria="todas">' +
                '<i class="bi bi-grid-3x3-gap me-2"></i>Todas las Categorías' +
                '</a>';

            for (var id in categoriasMap) {
                var nombre = categoriasMap[id];
                var icono = iconos[id] || 'bi-box';
                html += 
                    '<a href="javascript:void(0)" onclick="filtrarPorCategoria(' + id + ')" ' +
                    'class="categoria-btn" data-categoria="' + id + '">' +
                    '<i class="bi ' + icono + ' me-2"></i>' + nombre +
                    '</a>';
            }

            document.getElementById('categoriasContainer').innerHTML = html;
        }

        function mostrarProductos(productos) {
            console.log('🛍️ Mostrando', productos.length, 'productos');
            
            var container = document.getElementById('productosContainer');
            
            if (productos.length === 0) {
                container.innerHTML = 
                    '<div class="no-products">' +
                    '<i class="bi bi-search"></i>' +
                    '<h3>No se encontraron productos</h3>' +
                    '<p>Intenta con otros términos de búsqueda o categorías</p>' +
                    '<button class="btn btn-pedir mt-3" onclick="limpiarFiltros()" style="width: auto; padding: 10px 20px;">' +
                    '<i class="bi bi-arrow-counterclockwise me-2"></i>Ver todos los productos' +
                    '</button>' +
                    '</div>';
                return;
            }

            var html = '';
            
            for (var i = 0; i < productos.length; i++) {
                var p = productos[i];
                
                var stockClass = p.stock > 0 ? 'stock-disponible' : 'stock-agotado';
                var stockText = p.stock > 0 ? 'Stock: ' + p.stock : 'Agotado';
                var disabled = p.stock > 0 ? '' : 'disabled';
                var btnText = p.stock > 0 ? 'Pedir por WhatsApp' : 'Agotado';
                var badge = p.stock > 10 ? 'Disponible' : (p.stock > 0 ? 'Últimas unidades' : 'Agotado');
                var badgeClass = p.stock > 10 ? 'bg-success' : (p.stock > 0 ? 'bg-warning' : 'bg-danger');
                
                var imagenHtml;
                if (p.imagenBase64 && p.imagenBase64.length > 0) {
                    imagenHtml = '<img src="data:image/jpeg;base64,' + p.imagenBase64 + '" ' +
                                'alt="' + p.nombre_producto + '" ' +
                                'onerror="this.style.display=\'none\'; this.parentElement.innerHTML=\'<i class=\\\'bi bi-lightbulb\\\'></i>\';">';
                } else {
                    imagenHtml = '<i class="bi bi-lightbulb"></i>';
                }

                html += 
                    '<div class="producto-card">' +
                    '<div class="producto-imagen">' +
                    imagenHtml +
                    '<span class="producto-badge ' + badgeClass + '">' + badge + '</span>' +
                    '</div>' +
                    '<div class="producto-info">' +
                    '<span class="producto-categoria">' + (p.nombre_categoria || 'Sin categoría') + '</span>' +
                    '<h3 class="producto-nombre">' + (p.nombre_producto || 'Producto sin nombre') + '</h3>' +
                    '<p class="producto-descripcion">' + (p.descripcion || 'Sin descripción disponible') + '</p>' +
                    '<div class="producto-precio">S/ ' + parseFloat(p.precio || 0).toFixed(2) + '</div>' +
                    '<div class="producto-stock ' + stockClass + '">' +
                    '<i class="bi ' + (p.stock > 0 ? 'bi-check-circle' : 'bi-x-circle') + ' me-1"></i>' +
                    stockText +
                    '</div>' +
                    '<a href="javascript:void(0)" class="btn-pedir" ' + disabled + ' onclick="pedirPorWhatsApp(' + p.id_producto + ')">' +
                    '<i class="bi bi-whatsapp me-2"></i> ' + btnText +
                    '</a>' +
                    '<button class="btn-detalle" onclick="verDetalle(' + p.id_producto + ')">' +
                    '<i class="bi bi-eye me-2"></i> Ver Detalle' +
                    '</button>' +
                    '</div>' +
                    '</div>';
            }

            container.innerHTML = html;
        }

        // Función para mostrar detalles del producto
        function verDetalle(idProducto) {
            var producto = productosOriginales.find(function(p) {
                return p.id_producto == idProducto;
            });

            if (!producto) {
                alert('Producto no encontrado');
                return;
            }

            var contenido = 
                '<div class="modal-detalle-imagen">' +
                    (producto.imagenBase64 ? 
                        '<img src="data:image/jpeg;base64,' + producto.imagenBase64 + '" alt="' + producto.nombre_producto + '">' :
                        '<i class="bi bi-lightbulb" style="font-size: 5rem; color: var(--primary-color);"></i>'
                    ) +
                '</div>' +
                '<div class="modal-detalle-info">' +
                    '<span class="modal-detalle-categoria">' + (producto.nombre_categoria || 'Sin categoría') + '</span>' +
                    '<h3 class="modal-detalle-title">' + (producto.nombre_producto || 'Producto sin nombre') + '</h3>' +
                    '<p class="modal-detalle-descripcion">' + (producto.descripcion || 'Sin descripción disponible') + '</p>' +
                    '<div class="modal-detalle-precio">S/ ' + parseFloat(producto.precio || 0).toFixed(2) + '</div>' +
                    '<div class="modal-detalle-stock ' + (producto.stock > 0 ? 'stock-disponible' : 'stock-agotado') + '">' +
                        '<i class="bi ' + (producto.stock > 0 ? 'bi-check-circle' : 'bi-x-circle') + ' me-1"></i>' +
                        (producto.stock > 0 ? 'Stock disponible: ' + producto.stock + ' unidades' : 'Producto agotado') +
                    '</div>' +
                    '<div class="modal-detalle-especificaciones">' +
                        '<h4>Especificaciones Técnicas</h4>' +
                        '<ul>' +
                            '<li><strong>ID Producto:</strong> ' + (producto.id_producto || 'N/A') + '</li>' +
                            '<li><strong>Categoría ID:</strong> ' + (producto.id_categoria || 'N/A') + '</li>' +
                            (producto.potencia ? '<li><strong>Potencia:</strong> ' + producto.potencia + 'W</li>' : '') +
                            (producto.temperatura_color ? '<li><strong>Temperatura de Color:</strong> ' + producto.temperatura_color + 'K</li>' : '') +
                            (producto.vida_util ? '<li><strong>Vida Útil:</strong> ' + producto.vida_util + ' horas</li>' : '') +
                            (producto.eficiencia ? '<li><strong>Eficiencia Energética:</strong> ' + producto.eficiencia + '</li>' : '') +
                            (producto.garantia ? '<li><strong>Garantía:</strong> ' + producto.garantia + ' meses</li>' : '') +
                            '<li><strong>Estado:</strong> ' + (producto.estado || 'N/A') + '</li>' +
                        '</ul>' +
                    '</div>' +
                    '<div class="modal-detalle-actions">' +
                        '<a href="javascript:void(0)" class="btn-pedir" ' + (producto.stock > 0 ? '' : 'disabled') + ' onclick="pedirPorWhatsApp(' + producto.id_producto + '); cerrarModalDetalle();">' +
                            '<i class="bi bi-whatsapp me-2"></i> Pedir por WhatsApp' +
                        '</a>' +
                        '<button class="btn-detalle" onclick="cerrarModalDetalle()">' +
                            '<i class="bi bi-x-circle me-2"></i> Cerrar' +
                        '</button>' +
                    '</div>' +
                '</div>';

            document.getElementById('modalDetalleBody').innerHTML = contenido;
            document.getElementById('modalDetalleTitle').textContent = producto.nombre_producto || 'Detalles del Producto';
            document.getElementById('modalDetalle').classList.add('active');
        }

        // Función para cerrar el modal de detalles
        function cerrarModalDetalle() {
            document.getElementById('modalDetalle').classList.remove('active');
        }

        function filtrarPorCategoria(categoria) {
            console.log('🔍 Filtrando por categoría:', categoria);
            categoriaActual = categoria;
            
            var botones = document.querySelectorAll('.categoria-btn');
            for (var i = 0; i < botones.length; i++) {
                botones[i].classList.remove('active');
            }
            document.querySelector('[data-categoria="' + categoria + '"]').classList.add('active');
            
            aplicarFiltros();
        }

        function buscarProductos() {
            busquedaActual = document.getElementById('searchInput').value.toLowerCase().trim();
            console.log('🔍 Buscando:', busquedaActual);
            aplicarFiltros();
        }

        function aplicarFiltros() {
            productosFiltrados = [];
            
            for (var i = 0; i < productosOriginales.length; i++) {
                var p = productosOriginales[i];
                
                var cumpleCategoria = categoriaActual === 'todas' || 
                                     String(p.id_categoria) === String(categoriaActual);
                
                var cumpleBusqueda = busquedaActual === '' ||
                    (p.nombre_producto && p.nombre_producto.toLowerCase().indexOf(busquedaActual) !== -1) ||
                    (p.descripcion && p.descripcion.toLowerCase().indexOf(busquedaActual) !== -1) ||
                    (p.nombre_categoria && p.nombre_categoria.toLowerCase().indexOf(busquedaActual) !== -1);
                
                if (cumpleCategoria && cumpleBusqueda) {
                    productosFiltrados.push(p);
                }
            }

            console.log('📊 Productos filtrados:', productosFiltrados.length);
            mostrarProductos(productosFiltrados);
            actualizarInfoResultados();
        }

        function actualizarInfoResultados() {
            var info = document.getElementById('resultadosInfo');
            var texto = '<i class="bi bi-info-circle me-2"></i>Mostrando ' + productosFiltrados.length + ' producto(s)';
            
            if (busquedaActual) {
                texto += ' para "<strong>' + busquedaActual + '</strong>"';
            }
            
            if (categoriaActual !== 'todas' && productosFiltrados.length > 0) {
                texto += ' en <strong>' + productosFiltrados[0].nombre_categoria + '</strong>';
            }
            
            if (busquedaActual || categoriaActual !== 'todas') {
                texto += ' <a href="javascript:void(0)" onclick="limpiarFiltros()" class="clear-filters">' +
                    '<i class="bi bi-x-circle me-1"></i>Limpiar filtros' +
                    '</a>';
            }
            
            info.innerHTML = texto;
        }

        function limpiarFiltros() {
            console.log('🧹 Limpiando filtros');
            categoriaActual = 'todas';
            busquedaActual = '';
            document.getElementById('searchInput').value = '';
            
            var botones = document.querySelectorAll('.categoria-btn');
            for (var i = 0; i < botones.length; i++) {
                botones[i].classList.remove('active');
            }
            document.querySelector('[data-categoria="todas"]').classList.add('active');
            
            aplicarFiltros();
        }

        // =============================================
        // FUNCIÓN PARA PEDIR POR WHATSAPP
        // =============================================
        function pedirPorWhatsApp(idProducto) {
            console.log('📱 Solicitando producto por WhatsApp ID:', idProducto);

            // Encontrar el producto en los datos
            var producto = productosOriginales.find(function(p) {
                return p.id_producto == idProducto;
            });

            if (!producto) {
                mostrarNotificacion('❌ Producto no encontrado', 'error');
                return;
            }

            if (producto.stock <= 0) {
                mostrarNotificacion('❌ Producto agotado', 'error');
                return;
            }

            // Número de WhatsApp (cambia este número por el tuyo)
            var numeroWhatsApp = "51931976361"; // Reemplaza con tu número (código país + número sin espacios)
            
            // Mensaje predeterminado
            var mensaje = "¡Hola! Me interesa el siguiente producto:%0A%0A" +
                         "📦 *Producto:* " + (producto.nombre_producto || 'Producto') + "%0A" +
                         "💰 *Precio:* S/ " + parseFloat(producto.precio || 0).toFixed(2) + "%0A" +
                         "📋 *Categoría:* " + (producto.nombre_categoria || 'General') + "%0A" +
                         "📝 *Descripción:* " + (producto.descripcion || 'Sin descripción') + "%0A%0A" +
                         "Me gustaría solicitar una cotización y más información sobre este producto.%0A%0A" +
                         "¡Gracias!";
            
            // Crear enlace de WhatsApp
            var urlWhatsApp = "https://wa.me/" + numeroWhatsApp + "?text=" + mensaje;
            
            // Abrir en nueva pestaña
            window.open(urlWhatsApp, '_blank');
            
            // Mostrar notificación de éxito
            mostrarNotificacion('✅ Redirigiendo a WhatsApp...', 'success');
        }

        // =============================================
        // FUNCIÓN PARA MOSTRAR NOTIFICACIONES
        // =============================================
        function mostrarNotificacion(mensaje, tipo) {
            // Eliminar notificaciones anteriores
            var notificacionesAnteriores = document.querySelectorAll('.notificacion');
            notificacionesAnteriores.forEach(function(notif) {
                notif.remove();
            });

            var notificacion = document.createElement('div');
            notificacion.className = 'notificacion ' + tipo;
            notificacion.innerHTML = mensaje;

            document.body.appendChild(notificacion);

            // Mostrar con animación
            setTimeout(function() {
                notificacion.classList.add('show');
            }, 100);

            // Ocultar después de 3 segundos
            setTimeout(function() {
                notificacion.classList.remove('show');
                setTimeout(function() {
                    if (notificacion.parentNode) {
                        notificacion.parentNode.removeChild(notificacion);
                    }
                }, 300);
            }, 3000);
        }

        // =============================================
        // FUNCIONES DEL CARRITO (MANTENIDAS PERO NO USADAS)
        // =============================================
        function verCarrito() {
            // Esta función ya no se usa, pero la mantenemos por si acaso
            console.log('🛒 Función del carrito deshabilitada');
        }

        function actualizarContadorCarrito() {
            // Esta función ya no se usa
            console.log('🔢 Contador del carrito deshabilitado');
        }
    </script>
</body>
</html>