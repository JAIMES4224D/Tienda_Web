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
            position: sticky;
            top: 0;
            z-index: 1000;
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

        /* Botones del header */
        .header-buttons {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-carrito-header, .btn-pedidos-header {
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
        }

        .btn-carrito-header:hover, .btn-pedidos-header:hover {
            background: var(--primary-color);
            color: #000;
            transform: translateY(-2px);
            box-shadow: 0 0 15px rgba(0, 224, 255, 0.4);
        }

        .carrito-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #ff4444;
            color: white;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 2px solid #000;
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

        /* Resto de estilos se mantienen igual... */
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

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.7; }
            50% { transform: scale(1.3); opacity: 0.4; }
        }

        .cursor-hover { transform: scale(1.8); width: 30px; height: 30px; }
        .cursor-click { transform: scale(0.7); }

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

        .hero p { font-size: 1.2rem; color: #ccc; max-width: 600px; margin: 0 auto; }

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
        
        .filtros-title { color: var(--primary-color); font-size: 1.5rem; margin-bottom: 20px; font-weight: 700; }
        
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
        
        .categoria-btn:hover { border-color: var(--primary-color); transform: translateY(-2px); color: #fff; }
        .categoria-btn.active { background: rgba(0, 224, 255, 0.1); border-color: var(--primary-color); box-shadow: 0 0 15px rgba(0, 224, 255, 0.3); }
        
        .search-form { position: relative; margin-bottom: 20px; }
        
        .search-input {
            background: #2a2a2a; border: 1px solid #444; border-radius: 25px;
            color: #fff; padding: 12px 50px 12px 20px; width: 100%; font-size: 1rem;
        }
        .search-input:focus { border-color: var(--primary-color); outline: none; box-shadow: 0 0 10px rgba(0, 224, 255, 0.3); }
        .search-button { position: absolute; right: 20px; top: 50%; transform: translateY(-50%); background: none; border: none; color: var(--primary-color); font-size: 1.2rem; cursor: pointer; }
        
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
            display: flex;
            flex-direction: column;
        }
        
        .producto-card:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0, 224, 255, 0.3); }
        
        .producto-imagen {
            width: 100%; height: 250px; background: linear-gradient(135deg, #2a2a2a, #333);
            display: flex; align-items: center; justify-content: center;
            color: var(--primary-color); font-size: 3rem; overflow: hidden; position: relative;
        }

        .producto-imagen img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
        .producto-card:hover .producto-imagen img { transform: scale(1.05); }
        
        .producto-info { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
        
        .producto-categoria {
            background: rgba(0, 224, 255, 0.1); color: var(--primary-color);
            padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;
            display: inline-block; margin-bottom: 10px; width: fit-content;
        }
        
        .producto-nombre { color: #fff; font-size: 1.3rem; font-weight: 700; margin-bottom: 10px; line-height: 1.3; }
        .producto-descripcion { color: #ccc; font-size: 0.9rem; margin-bottom: 15px; line-height: 1.5; height: 60px; overflow: hidden; }
        .producto-precio { color: var(--primary-color); font-size: 1.5rem; font-weight: 700; margin-bottom: 15px; }
        .producto-stock { color: #aaa; font-size: 0.9rem; margin-bottom: 15px; }
        .stock-disponible { color: #00cc66; }
        .stock-agotado { color: #ff4d4d; }
        
        /* BOTONES */
        .btn-pedir {
            background: linear-gradient(135deg, #25D366, #128C7E);
            border: none; color: white; font-weight: 700; border-radius: 25px;
            padding: 12px 25px; width: 100%; transition: all 0.3s ease; cursor: pointer;
            margin-bottom: 10px; display: flex; align-items: center; justify-content: center; gap: 8px;
        }

        .btn-agregar-carrito {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-weight: 700;
            border-radius: 25px;
            padding: 10px 25px;
            width: 100%;
            transition: all 0.3s ease;
            cursor: pointer;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-agregar-carrito:hover:not(:disabled) {
            background: var(--primary-color);
            color: #000;
            box-shadow: 0 0 15px rgba(0, 224, 255, 0.4);
        }

        .btn-agregar-carrito:disabled { opacity: 0.5; cursor: not-allowed; border-color: #555; color: #555; }
        
        .btn-detalle {
            background: transparent; border: 1px solid #666; color: #ccc; font-weight: 600;
            border-radius: 25px; padding: 10px 20px; width: 100%; transition: all 0.3s ease; cursor: pointer;
        }
        .btn-detalle:hover { border-color: var(--primary-color); color: var(--primary-color); }
        
        .producto-badge {
            position: absolute; top: 10px; right: 10px; background: rgba(0, 0, 0, 0.8);
            color: var(--primary-color); padding: 5px 10px; border-radius: 15px;
            font-size: 0.8rem; font-weight: 600;
        }

        /* MODALES */
        .modal-detalle, .modal-carrito, .modal-pedidos, .modal-detalle-pedido {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.8); display: flex;
            justify-content: center; align-items: center; z-index: 10000;
            opacity: 0; visibility: hidden; transition: all 0.3s ease;
        }
        .modal-detalle.active, .modal-carrito.active, .modal-pedidos.active, .modal-detalle-pedido.active { opacity: 1; visibility: visible; }

        .modal-detalle-content, .modal-carrito-content, .modal-pedidos-content, .modal-detalle-pedido-content {
            background: var(--card-bg); border-radius: 20px; width: 90%; max-width: 900px;
            max-height: 90vh; overflow-y: auto; position: relative;
            box-shadow: 0 20px 50px rgba(0, 224, 255, 0.3);
            border: 2px solid var(--primary-color); transform: scale(0.9); transition: transform 0.3s ease;
        }
        .modal-detalle.active .modal-detalle-content, .modal-carrito.active .modal-carrito-content, 
        .modal-pedidos.active .modal-pedidos-content, .modal-detalle-pedido.active .modal-detalle-pedido-content { transform: scale(1); }

        .modal-detalle-header, .modal-carrito-header, .modal-pedidos-header, .modal-detalle-pedido-header {
            display: flex; justify-content: space-between; align-items: center;
            padding: 20px 25px; border-bottom: 1px solid #333; background: rgba(0, 0, 0, 0.3);
        }

        .modal-title { color: var(--primary-color); font-size: 1.8rem; font-weight: 700; margin: 0; }
        .modal-close { background: none; border: none; color: #fff; font-size: 1.5rem; cursor: pointer; }
        .modal-close:hover { color: var(--primary-color); }

        /* Estilos del Carrito */
        .carrito-body, .pedidos-body, .detalle-pedido-body { padding: 25px; }
        .carrito-item, .pedido-item, .producto-pedido-item {
            display: flex; gap: 15px; padding: 15px; border-bottom: 1px solid #333; align-items: center;
        }
        .carrito-item-img, .producto-pedido-img {
            width: 80px; height: 80px; border-radius: 10px; object-fit: cover; background: #333;
        }
        .carrito-item-info, .producto-pedido-info { flex-grow: 1; }
        .carrito-item-title, .producto-pedido-title { color: white; font-weight: 600; margin-bottom: 5px; }
        .carrito-item-price, .producto-pedido-price { color: var(--primary-color); font-weight: bold; }
        
        .carrito-controls { display: flex; align-items: center; gap: 10px; }
        .btn-qty {
            background: #333; border: none; color: white; width: 30px; height: 30px;
            border-radius: 50%; cursor: pointer; transition: 0.2s;
        }
        .btn-qty:hover { background: var(--primary-color); color: black; }
        .btn-delete { color: #ff4444; background: none; border: none; cursor: pointer; font-size: 1.2rem; }
        .btn-delete:hover { color: #ff0000; transform: scale(1.1); }

        .carrito-footer, .pedidos-footer, .detalle-pedido-footer {
            padding: 20px 25px; border-top: 1px solid #333; background: rgba(0,0,0,0.2);
        }
        .carrito-total {
            display: flex; justify-content: space-between; font-size: 1.5rem; font-weight: 700; color: white; margin-bottom: 20px;
        }
        .carrito-total span:last-child { color: var(--primary-color); }

        /* Estilos para pedidos */
        .pedido-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary-color);
        }

        .pedido-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .pedido-id {
            color: var(--primary-color);
            font-weight: bold;
        }

        .pedido-fecha {
            color: #aaa;
            font-size: 0.9rem;
        }

        .pedido-estado {
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .estado-pendiente { background: rgba(255, 193, 7, 0.2); color: #ffc107; border: 1px solid #ffc107; }
        .estado-pagado { background: rgba(0, 224, 255, 0.2); color: var(--primary-color); border: 1px solid var(--primary-color); }
        .estado-enviado { background: rgba(0, 150, 255, 0.2); color: #0096ff; border: 1px solid #0096ff; }
        .estado-entregado { background: rgba(0, 200, 83, 0.2); color: #00c853; border: 1px solid #00c853; }
        .estado-cancelado { background: rgba(255, 68, 68, 0.2); color: #ff4444; border: 1px solid #ff4444; }

        .pedido-total {
            text-align: right;
            font-weight: bold;
            color: var(--primary-color);
            margin-top: 10px;
        }

        .pedido-detalles-btn {
            background: transparent;
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            padding: 5px 15px;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pedido-detalles-btn:hover {
            background: var(--primary-color);
            color: #000;
        }

        /* Estilos para productos en detalle de pedido */
        .producto-pedido-cantidad {
            color: #ccc;
            font-size: 0.9rem;
        }

        .producto-pedido-subtotal {
            color: var(--primary-color);
            font-weight: bold;
            margin-left: auto;
        }

        /* Notificaciones */
        .notificacion {
            position: fixed; top: 20px; right: 20px; padding: 15px 20px; border-radius: 10px;
            color: white; font-weight: 600; z-index: 10001;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); transform: translateX(400px);
            transition: transform 0.3s ease; max-width: 350px;
        }
        .notificacion.show { transform: translateX(0); }
        .notificacion.success { background: linear-gradient(135deg, #00cc66, #00a852); border-left: 4px solid #00ff88; }
        .notificacion.error { background: linear-gradient(135deg, #ff4d4d, #cc0000); border-left: 4px solid #ff8888; }
        .notificacion.warning { background: linear-gradient(135deg, #ffc107, #e0a800); border-left: 4px solid #ffd54f; color: #000; }

        
        footer { background-color: #000; color: #aaa; text-align: center; padding: 25px 0; margin-top: 50px; }

        
        .modal-detalle-body { padding: 25px; display: flex; flex-direction: column; gap: 20px; }
        .modal-detalle-imagen { width: 100%; height: 300px; background: #2a2a2a; border-radius: 15px; overflow: hidden; display: flex; align-items: center; justify-content: center; }
        .modal-detalle-imagen img { width: 100%; height: 100%; object-fit: cover; }
        .modal-detalle-actions { display: flex; gap: 15px; grid-column: 1 / -1; margin-top: 15px; }
        
        @media (max-width: 768px) {
            .tienda-header { flex-direction: column; gap: 15px; }
            .user-info-section { flex-direction: column; width: 100%; }
            .header-buttons { width: 100%; justify-content: center; margin: 0; }
            .btn-carrito-header, .btn-pedidos-header { width: 100%; justify-content: center; }
            .modal-detalle-actions, .modal-carrito-header { flex-direction: column; }
            .carrito-item { flex-direction: column; text-align: center; }
            .pedido-header { flex-direction: column; align-items: flex-start; gap: 10px; }
        }

        /* Estilos para el modal de confirmación de compra */
        .modal-compra {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.8); display: flex;
            justify-content: center; align-items: center; z-index: 10000;
            opacity: 0; visibility: hidden; transition: all 0.3s ease;
        }
        .modal-compra.active { opacity: 1; visibility: visible; }
        .modal-compra-content {
            background: var(--card-bg); border-radius: 20px; width: 90%; max-width: 500px;
            max-height: 90vh; overflow-y: auto; position: relative;
            box-shadow: 0 20px 50px rgba(0, 224, 255, 0.3);
            border: 2px solid var(--primary-color); transform: scale(0.9); transition: transform 0.3s ease;
        }
        .modal-compra.active .modal-compra-content { transform: scale(1); }
        .modal-compra-header { display: flex; justify-content: space-between; align-items: center;
            padding: 20px 25px; border-bottom: 1px solid #333; background: rgba(0, 0, 0, 0.3);
        }
        .modal-compra-body { padding: 25px; }
        .modal-compra-footer { padding: 20px 25px; border-top: 1px solid #333; background: rgba(0,0,0,0.2); display: flex; justify-content: flex-end; gap: 10px; }
    </style>
</head>

<body>
    <div class="cursor-led" id="cursorLed"></div>

    <header class="tienda-header">
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/img/donglai.jpg" alt="DonGlai Logo" class="logo">
            <div class="brand-text">DonGlai LED</div>
        </div>
        
        <div class="user-info-section" id="userInfoSection" style="display: none;">
            <div class="header-buttons">
                <button class="btn-carrito-header" onclick="abrirCarrito()">
                    <i class="bi bi-cart3"></i>
                    Carrito
                    <span class="carrito-badge" id="carritoBadge">0</span>
                </button>
                <button class="btn-pedidos-header" onclick="verMisPedidos()">
                    <i class="bi bi-clipboard-check"></i>
                    Mis Pedidos
                </button>
            </div>
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
            </button>
        </div>
    </header>

    <div class="modal-confirmacion" id="modalConfirmacion" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:11000; justify-content:center; align-items:center;">
       <div style="background:var(--card-bg); padding:30px; border-radius:15px; text-align:center; border: 2px solid red;">
           <h2 style="color:var(--primary-color); margin-bottom: 20px;">¿Cerrar Sesión?</h2>
           <button onclick="confirmarCerrarSesion()" class="btn btn-danger mt-3 me-2">Sí, salir</button>
           <button onclick="document.getElementById('modalConfirmacion').style.display='none'" class="btn btn-secondary mt-3">Cancelar</button>
       </div>
    </div>

    <section class="hero">
        <h1>Nuestra Tienda LED</h1>
        <p>Descubre nuestra amplia gama de productos de iluminación LED de alta calidad</p>
    </section>
    
    <section class="tienda-section">
        <div class="container">
            <div class="filtros-container">
                <h2 class="filtros-title">Filtrar Productos</h2>
                <div class="search-form">
                    <input type="text" class="search-input" id="searchInput" placeholder="Buscar productos...">
                    <button type="button" class="search-button" onclick="buscarProductos()"><i class="bi bi-search"></i></button>
                </div>
                <div class="categorias-grid" id="categoriasContainer"></div>
            </div>
            <div class="resultados-info" id="resultadosInfo"><i class="bi bi-info-circle me-2"></i> Cargando productos...</div>
            <div class="productos-grid" id="productosContainer">
                <div class="loading text-center text-info"><h3><i class="bi bi-arrow-repeat spin"></i> Cargando...</h3></div>
            </div>
        </div>
    </section>

    
    <div class="modal-detalle" id="modalDetalle">
        <div class="modal-detalle-content">
            <div class="modal-detalle-header">
                <h2 class="modal-title" id="modalDetalleTitle">Detalle</h2>
                <button class="modal-close" onclick="cerrarModalDetalle()"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="modal-detalle-body" id="modalDetalleBody"></div>
        </div>
    </div>

    
    <div class="modal-carrito" id="modalCarrito">
        <div class="modal-carrito-content">
            <div class="modal-carrito-header">
                <h2 class="modal-title"><i class="bi bi-cart-check me-2"></i>Tu Carrito</h2>
                <button class="modal-close" onclick="cerrarCarrito()"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="carrito-body" id="carritoBody"></div>
            <div class="carrito-footer">
                <div class="carrito-total">
                    <span>Total:</span>
                    <span id="carritoTotal">S/ 0.00</span>
                </div>
                <button class="btn-comprar" id="btnRealizarCompra" onclick="realizarCompra()">
                    <i class="bi bi-credit-card-2-front me-2"></i> Confirmar Compra
                </button>
                <button class="btn-detalle mt-2" onclick="vaciarCarrito()">
                    <i class="bi bi-trash me-2"></i> Vaciar Carrito
                </button>
            </div>
        </div>
    </div>

    
    <div class="modal-pedidos" id="modalPedidos">
        <div class="modal-pedidos-content">
            <div class="modal-pedidos-header">
                <h2 class="modal-title"><i class="bi bi-clipboard-check me-2"></i>Mis Pedidos</h2>
                <button class="modal-close" onclick="cerrarModalPedidos()"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="pedidos-body" id="pedidosBody">
                <div class="text-center text-muted py-5">
                    <i class="bi bi-hourglass-split display-1"></i>
                    <p class="mt-3">Cargando pedidos...</p>
                </div>
            </div>
            <div class="pedidos-footer">
                <button class="btn-detalle" onclick="cerrarModalPedidos()">
                    <i class="bi bi-x-circle me-2"></i> Cerrar
                </button>
            </div>
        </div>
    </div>

    
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

    
    <div class="modal-compra" id="modalCompra">
        <div class="modal-compra-content">
            <div class="modal-compra-header">
                <h2 class="modal-title"><i class="bi bi-cart-check me-2"></i>Confirmar Compra</h2>
                <button class="modal-close" onclick="cerrarModalCompra()"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="modal-compra-body" id="modalCompraBody">
                <p>¿Estás seguro de que deseas realizar esta compra?</p>
                <div id="resumenCompra"></div>
            </div>
            <div class="modal-compra-footer">
                <button class="btn-detalle" onclick="cerrarModalCompra()">Cancelar</button>
                <button class="btn-comprar" id="btnConfirmarCompra" onclick="confirmarCompra()">
                    <i class="bi bi-check-lg me-2"></i> Confirmar
                </button>
            </div>
        </div>
    </div>

    <footer>
        <div class="container"><p>© 2025 DonGlai - Innovando en Iluminación LED</p></div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var carrito = JSON.parse(localStorage.getItem('carritoDonglai')) || [];
        var productosOriginales = [];
        var productosFiltrados = [];
        var categoriaActual = 'todas';
        var busquedaActual = '';

        document.addEventListener('DOMContentLoaded', function() {
            iniciarTienda();
            actualizarBadge();
        });

        function iniciarTienda() {
            initLedCursor();
            cargarDatosUsuario();
            cargarProductos();
            document.getElementById('searchInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') buscarProductos();
            });
        }

        function verMisPedidos() {
            document.getElementById('modalPedidos').classList.add('active');
            cargarMisPedidos();
        }

        function cerrarModalPedidos() {
            document.getElementById('modalPedidos').classList.remove('active');
        }

        function cargarMisPedidos() {
            fetch('PedidosServlet')
            .then(function(response) { 
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json(); 
            })
            .then(function(data) {
                console.log('Pedidos recibidos:', data);
                renderizarPedidos(data);
            })
            .catch(function(error) {
                console.error('Error al cargar pedidos:', error);
                document.getElementById('pedidosBody').innerHTML = 
                    '<div class="text-center text-danger py-5">' +
                    '<i class="bi bi-exclamation-triangle display-1"></i>' +
                    '<p class="mt-3">Error al cargar los pedidos</p>' +
                    '</div>';
            });
        }

        function renderizarPedidos(pedidos) {
            var contenedor = document.getElementById('pedidosBody');
            
            if (!pedidos || pedidos.length === 0) {
                contenedor.innerHTML = 
                    '<div class="text-center text-muted py-5">' +
                    '<i class="bi bi-cart-x display-1"></i>' +
                    '<p class="mt-3">No tienes pedidos realizados</p>' +
                    '</div>';
                return;
            }

            var html = '';
            pedidos.forEach(function(pedido) {
                console.log('Procesando pedido:', pedido);
                
                var estadoClass = 'estado-' + pedido.estado;
                var estadoText = pedido.estado ? pedido.estado.charAt(0).toUpperCase() + pedido.estado.slice(1) : 'Desconocido';
                
                var pedidoId = pedido.id_pedido || 'N/A';
                
                var fechaPedido = 'Fecha no disponible';
                if (pedido.fecha_pedido) {
                    try {
                        fechaPedido = new Date(pedido.fecha_pedido).toLocaleDateString();
                    } catch (e) {
                        fechaPedido = 'Fecha inválida';
                    }
                }
                
                var total = pedido.total ? parseFloat(pedido.total).toFixed(2) : '0.00';
                
                html += '<div class="pedido-card">' +
                        '<div class="pedido-header">' +
                            '<div>' +
                                '<div class="pedido-id">Pedido #' + pedidoId + '</div>' +
                                '<div class="pedido-fecha">' + fechaPedido + '</div>' +
                            '</div>' +
                            '<div class="pedido-estado ' + estadoClass + '">' + estadoText + '</div>' +
                        '</div>' +
                        '<div class="pedido-total">Total: S/ ' + total + '</div>' +
                        '<button class="pedido-detalles-btn" onclick="verDetallesPedido(' + pedidoId + ')">' +
                            '<i class="bi bi-eye me-1"></i>Ver Productos' +
                        '</button>' +
                        '</div>';
            });
            
            contenedor.innerHTML = html;
        }

        function verDetallesPedido(idPedido) {
            document.getElementById('modalDetallePedido').classList.add('active');
            cargarDetallesPedido(idPedido);
        }

        function cerrarModalDetallePedido() {
            document.getElementById('modalDetallePedido').classList.remove('active');
        }

        function cargarDetallesPedido(idPedido) {
            fetch('PedidosServlet?accion=detalle&id=' + idPedido)
            .then(function(response) { 
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json(); 
            })
            .then(function(data) {
                console.log('Detalles del pedido recibidos:', data);
                renderizarDetallesPedido(data);
            })
            .catch(function(error) {
                console.error('Error al cargar detalles del pedido:', error);
                document.getElementById('detallePedidoBody').innerHTML = 
                    '<div class="text-center text-danger py-5">' +
                    '<i class="bi bi-exclamation-triangle display-1"></i>' +
                    '<p class="mt-3">Error al cargar los detalles del pedido</p>' +
                    '</div>';
            });
        }

        function renderizarDetallesPedido(detalles) {
            var contenedor = document.getElementById('detallePedidoBody');
            
            if (!detalles || !detalles.pedido || !detalles.productos || detalles.productos.length === 0) {
                contenedor.innerHTML = 
                    '<div class="text-center text-muted py-5">' +
                    '<i class="bi bi-cart-x display-1"></i>' +
                    '<p class="mt-3">No se encontraron detalles del pedido</p>' +
                    '</div>';
                return;
            }

            var pedido = detalles.pedido;
            var productos = detalles.productos;
            
            var html = '<div class="mb-4">' +
                       '<h4 class="text-primary">Pedido #' + (pedido.id_pedido || 'N/A') + '</h4>' +
                       '<p><strong>Fecha:</strong> ' + (pedido.fecha_pedido ? new Date(pedido.fecha_pedido).toLocaleDateString() : 'N/A') + '</p>' +
                       '<p><strong>Estado:</strong> <span class="pedido-estado estado-' + (pedido.estado || 'pendiente') + '">' + 
                       (pedido.estado ? pedido.estado.charAt(0).toUpperCase() + pedido.estado.slice(1) : 'Pendiente') + '</span></p>' +
                       '</div>';
            
            html += '<h5 class="mb-3">Productos del Pedido:</h5>';
            
            productos.forEach(function(producto) {
                var imgHtml = producto.imagen ? 
                    '<img src="data:image/jpeg;base64,' + producto.imagen + '" class="producto-pedido-img">' : 
                    '<div class="producto-pedido-img d-flex align-items-center justify-content-center"><i class="bi bi-lightbulb text-primary"></i></div>';
                
                var subtotal = (producto.cantidad * producto.precio_unitario).toFixed(2);
                
                html += '<div class="producto-pedido-item">' +
                        imgHtml +
                        '<div class="producto-pedido-info">' +
                        '<div class="producto-pedido-title">' + (producto.nombre_producto || 'Producto') + '</div>' +
                        '<div class="producto-pedido-cantidad">Cantidad: ' + (producto.cantidad || 0) + '</div>' +
                        '<div class="producto-pedido-price">Precio unitario: S/ ' + (producto.precio_unitario ? parseFloat(producto.precio_unitario).toFixed(2) : '0.00') + '</div>' +
                        '</div>' +
                        '<div class="producto-pedido-subtotal">S/ ' + subtotal + '</div>' +
                        '</div>';
            });
            
            html += '<div class="carrito-total mt-4">' +
                    '<span>Total del Pedido:</span>' +
                    '<span>S/ ' + (pedido.total ? parseFloat(pedido.total).toFixed(2) : '0.00') + '</span>' +
                    '</div>';
            
            contenedor.innerHTML = html;
        }

        function actualizarBadge() {
            var totalItems = carrito.reduce(function(acc, item) { return acc + item.cantidad; }, 0);
            var badge = document.getElementById('carritoBadge');
            badge.textContent = totalItems;
            badge.style.display = totalItems > 0 ? 'flex' : 'none';
        }

        function guardarCarrito() {
            localStorage.setItem('carritoDonglai', JSON.stringify(carrito));
            actualizarBadge();
        }

        function agregarAlCarrito(idProducto) {
            var producto = productosOriginales.find(function(p) { return p.id_producto == idProducto; });
            if (!producto || producto.stock <= 0) return;
            var itemExistente = carrito.find(function(item) { return item.id === idProducto; });

            if (itemExistente) {
                if(itemExistente.cantidad < producto.stock) {
                    itemExistente.cantidad++;
                    mostrarNotificacion('✅ Cantidad actualizada', 'success');
                } else {
                    mostrarNotificacion('⚠️ Stock insuficiente', 'warning');
                    return;
                }
            } else {
                carrito.push({
                    id: producto.id_producto,
                    nombre: producto.nombre_producto,
                    precio: parseFloat(producto.precio),
                    imagen: producto.imagenBase64,
                    cantidad: 1,
                    maxStock: producto.stock
                });
                mostrarNotificacion('🛒 Agregado al carrito', 'success');
            }
            guardarCarrito();
        }

        function abrirCarrito() {
            renderizarCarrito();
            document.getElementById('modalCarrito').classList.add('active');
        }

        function cerrarCarrito() {
            document.getElementById('modalCarrito').classList.remove('active');
        }

        function renderizarCarrito() {
            var contenedor = document.getElementById('carritoBody');
            var totalElement = document.getElementById('carritoTotal');
            if (carrito.length === 0) {
                contenedor.innerHTML = '<div class="text-center text-muted py-5"><i class="bi bi-cart-x display-1"></i><p class="mt-3">Vacío</p></div>';
                totalElement.textContent = 'S/ 0.00';
                document.getElementById('btnRealizarCompra').disabled = true;
                return;
            }
            document.getElementById('btnRealizarCompra').disabled = false;
            
            var html = '';
            var total = 0;
            carrito.forEach(function(item, index) {
                var subtotal = item.precio * item.cantidad;
                total += subtotal;
                var imgHtml = item.imagen ? '<img src="data:image/jpeg;base64,' + item.imagen + '" class="carrito-item-img">' : '<div class="carrito-item-img d-flex align-items-center justify-content-center"><i class="bi bi-lightbulb"></i></div>';
                html += '<div class="carrito-item">' + imgHtml + '<div class="carrito-item-info"><div class="carrito-item-title">' + item.nombre + '</div><div class="carrito-item-price">S/ ' + item.precio.toFixed(2) + '</div></div><div class="carrito-controls"><button class="btn-qty" onclick="cambiarCantidad(' + index + ', -1)">-</button><span>' + item.cantidad + '</span><button class="btn-qty" onclick="cambiarCantidad(' + index + ', 1)">+</button></div><button class="btn-delete" onclick="eliminarDelCarrito(' + index + ')"><i class="bi bi-trash"></i></button></div>';
            });
            contenedor.innerHTML = html;
            totalElement.textContent = 'S/ ' + total.toFixed(2);
        }

        function cambiarCantidad(index, delta) {
            var item = carrito[index];
            var nuevaCantidad = item.cantidad + delta;
            if (nuevaCantidad > 0 && nuevaCantidad <= item.maxStock) {
                item.cantidad = nuevaCantidad;
                guardarCarrito(); renderizarCarrito();
            } else if (nuevaCantidad > item.maxStock) {
                mostrarNotificacion('⚠️ Stock máximo alcanzado', 'warning');
            }
        }

        function eliminarDelCarrito(index) {
            carrito.splice(index, 1); guardarCarrito(); renderizarCarrito();
        }

        function vaciarCarrito() {
            if(confirm('¿Vaciar carrito?')) { carrito = []; guardarCarrito(); renderizarCarrito(); }
        }

        function realizarCompra() {
            if (carrito.length === 0) { mostrarNotificacion('❌ El carrito está vacío', 'error'); return; }
            if (!verificarStockDisponible()) { mostrarNotificacion('❌ Stock insuficiente en algunos productos', 'error'); return; }
            mostrarModalConfirmacionCompra();
        }

        function verificarStockDisponible() {
            for (var i = 0; i < carrito.length; i++) {
                var item = carrito[i];
                var producto = productosOriginales.find(function(p) { return p.id_producto == item.id; });
                if (!producto || producto.stock < item.cantidad) return false;
            }
            return true;
        }

        function mostrarModalConfirmacionCompra() {
            var resumenHtml = '<div class="resumen-compra mt-3">';
            var total = 0;
            carrito.forEach(function(item) {
                var subtotal = item.precio * item.cantidad;
                total += subtotal;
                resumenHtml += '<div class="d-flex justify-content-between mb-2"><span>' + item.nombre + ' x' + item.cantidad + '</span><span>S/ ' + subtotal.toFixed(2) + '</span></div>';
            });
            resumenHtml += '<hr><div class="d-flex justify-content-between fw-bold"><span>Total:</span><span>S/ ' + total.toFixed(2) + '</span></div></div>';
            document.getElementById('resumenCompra').innerHTML = resumenHtml;
            document.getElementById('modalCompra').classList.add('active');
        }

        function cerrarModalCompra() { document.getElementById('modalCompra').classList.remove('active'); }

        function confirmarCompra() {
            var btnConfirmar = document.getElementById('btnConfirmarCompra');
            btnConfirmar.disabled = true;
            btnConfirmar.innerHTML = '<i class="bi bi-hourglass-split spin"></i> Procesando...';

            fetch('CarritoServlet?accion=realizarCompra', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'include', 
                body: JSON.stringify(carrito)
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    mostrarNotificacion('✅ ' + data.message, 'success');
                    carrito = []; guardarCarrito(); cerrarCarrito(); cerrarModalCompra(); cargarProductos();
                    // Recargar pedidos si el modal está abierto
                    if (document.getElementById('modalPedidos').classList.contains('active')) {
                        cargarMisPedidos();
                    }
                } else {
                    if(data.message && data.message.indexOf("sesión") !== -1) {
                         mostrarNotificacion('⚠️ ' + data.message, 'warning');
                         setTimeout(function(){ window.location.href = 'login.jsp'; }, 2000);
                    } else {
                        throw new Error(data.message || 'Error desconocido');
                    }
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                mostrarNotificacion('❌ ' + error.message, 'error');
            })
            .finally(function() {
                btnConfirmar.disabled = false;
                btnConfirmar.innerHTML = '<i class="bi bi-check-lg me-2"></i> Confirmar';
            });
        }

        function cargarProductos() {
            fetch('ProductosServlet', { method: 'GET', headers: { 'Accept': 'application/json' } })
            .then(function(r) { return r.json(); })
            .then(function(data) {
                productosOriginales = data; productosFiltrados = data; cargarCategorias(data); mostrarProductos(data); actualizarInfoResultados();
            })
            .catch(function(e) { console.error("Error", e); mostrarErrorCarga(e); });
        }

        function mostrarProductos(productos) {
            var container = document.getElementById('productosContainer');
            if (productos.length === 0) { container.innerHTML = '<div class="no-products"><h3>No se encontraron productos</h3></div>'; return; }
            var html = '';
            productos.forEach(function(p) {
                var tieneStock = p.stock > 0;
                var stockClass = tieneStock ? 'stock-disponible' : 'stock-agotado';
                var badge = p.stock > 10 ? 'Disponible' : (tieneStock ? 'Últimas unidades' : 'Agotado');
                var badgeClass = p.stock > 10 ? 'bg-success' : (tieneStock ? 'bg-warning' : 'bg-danger');
                
                var imgHtml = '';
                if (p.imagenBase64 && p.imagenBase64.length > 0) {
                    imgHtml = '<img src="data:image/jpeg;base64,' + p.imagenBase64 + '" onerror="this.parentElement.innerHTML=\'<i class=\\\'bi bi-lightbulb\\\'></i>\'">';
                } else {
                    imgHtml = '<i class="bi bi-lightbulb"></i>';
                }

                var botonesHtml = '';
                if (tieneStock) {
                    botonesHtml = '<button class="btn-agregar-carrito" onclick="agregarAlCarrito(' + p.id_producto + ')">' +
                                  '<i class="bi bi-cart-plus-fill"></i> Agregar</button>';
                } else {
                    botonesHtml = '<button class="btn-pedir" disabled style="background:#555">Agotado</button>';
                }

                html += '<div class="producto-card">' +
                            '<div class="producto-imagen">' +
                                imgHtml +
                                '<span class="producto-badge ' + badgeClass + '">' + badge + '</span>' +
                            '</div>' +
                            '<div class="producto-info">' +
                                '<span class="producto-categoria">' + (p.nombre_categoria || 'Varios') + '</span>' +
                                '<h3 class="producto-nombre">' + p.nombre_producto + '</h3>' +
                                '<div class="producto-precio">S/ ' + parseFloat(p.precio).toFixed(2) + '</div>' +
                                '<div class="producto-stock ' + stockClass + '">Stock: ' + p.stock + '</div>' +
                                botonesHtml +
                                '<button class="btn-detalle" onclick="verDetalle(' + p.id_producto + ')">' +
                                    '<i class="bi bi-eye"></i> Ver Detalle' +
                                '</button>' +
                            '</div>' +
                        '</div>';
            });
            container.innerHTML = html;
        }

        function verDetalle(id) {
            var p = productosOriginales.find(function(x) { return x.id_producto == id; }); if(!p) return;
            var btnAccion = '';
            if (p.stock > 0) {
                btnAccion = '<button class="btn-agregar-carrito w-100" onclick="agregarAlCarrito(' + p.id_producto + '); cerrarModalDetalle()">Agregar al Carrito</button>';
            } else {
                btnAccion = '<button disabled class="btn-pedir w-100" style="background:#555">Agotado</button>';
            }
            
            var img = '';
            if (p.imagenBase64 && p.imagenBase64.length > 0) {
                img = '<img src="data:image/jpeg;base64,' + p.imagenBase64 + '">';
            } else {
                img = '<i class="bi bi-lightbulb" style="font-size:5rem"></i>';
            }

            var contenido = '<div class="modal-detalle-imagen">' + img + '</div>' +
                            '<div class="modal-detalle-info">' +
                                '<span class="modal-detalle-categoria">' + (p.nombre_categoria || '') + '</span>' +
                                '<h3>' + p.nombre_producto + '</h3>' +
                                '<p style="color:#ccc">' + (p.descripcion || '') + '</p>' +
                                '<div class="modal-detalle-precio">S/ ' + parseFloat(p.precio).toFixed(2) + '</div>' +
                                '<div class="mt-3">' + btnAccion + '</div>' +
                            '</div>';
            document.getElementById('modalDetalleBody').innerHTML = contenido;
            document.getElementById('modalDetalle').classList.add('active');
        }

        function cerrarModalDetalle() { document.getElementById('modalDetalle').classList.remove('active'); }
        
        function cargarDatosUsuario() {
            fetch('UsuarioServlet?accion=obtenerDatos')
            .then(function(response) { return response.json(); })
            .then(function(usuario) {
                if (usuario && (usuario.id_usuario > 0 || usuario.id > 0)) {
                    document.getElementById('userInfoSection').style.display = 'flex';
                    
                    var nombreCompleto = usuario.nombre;
                    if(usuario.apellido) nombreCompleto += " " + usuario.apellido;

                    document.getElementById('userNameText').textContent = nombreCompleto;
                    document.getElementById('userEmail').textContent = usuario.correo;

                    if(usuario.rol) {
                        var rolSpan = document.getElementById('userRole');
                        rolSpan.textContent = usuario.rol;
                        if(usuario.rol === 'admin') {
                            rolSpan.style.color = '#ffc107';
                            rolSpan.style.borderColor = '#ffc107';
                        }
                    }
                }
            })
            .catch(function(error) { console.log("Usuario no logueado o error en fetch"); });
        }
        
        function initLedCursor() { if (window.matchMedia("(pointer: coarse)").matches) return; var cursor = document.getElementById('cursorLed'); document.addEventListener('mousemove', function(e) { cursor.style.left = (e.clientX - 12) + 'px'; cursor.style.top = (e.clientY - 12) + 'px'; }); setInterval(function() { document.documentElement.style.setProperty('--cursor-hue', (Date.now() / 50) % 360); }, 50); }
        function mostrarNotificacion(msg, type) { var div = document.createElement('div'); div.className = 'notificacion ' + type + ' show'; div.innerHTML = msg; document.body.appendChild(div); setTimeout(function() { div.classList.remove('show'); setTimeout(function() { div.remove(); }, 300); }, 3000); }
        function cargarCategorias(data) { var catsMap = {}; data.forEach(function(i) { if (i.id_categoria) catsMap[i.id_categoria] = i.nombre_categoria; }); var html = '<a href="#" onclick="filtrar(\'todas\')" class="categoria-btn active" data-cat="todas">Todas</a>'; for (var id in catsMap) { html += '<a href="#" onclick="filtrar(' + id + ')" class="categoria-btn" data-cat="' + id + '">' + catsMap[id] + '</a>'; } document.getElementById('categoriasContainer').innerHTML = html; }
        function filtrar(cat) { categoriaActual = cat; var btns = document.querySelectorAll('.categoria-btn'); for(var i=0; i<btns.length; i++) btns[i].classList.remove('active'); var activeBtn = document.querySelector('[data-cat="' + cat + '"]'); if(activeBtn) activeBtn.classList.add('active'); aplicarFiltros(); }
        function buscarProductos() { busquedaActual = document.getElementById('searchInput').value.toLowerCase(); aplicarFiltros(); }
        function aplicarFiltros() { productosFiltrados = productosOriginales.filter(function(p) { var matchCat = categoriaActual === 'todas' || p.id_categoria == categoriaActual; var matchSearch = !busquedaActual || p.nombre_producto.toLowerCase().indexOf(busquedaActual) !== -1; return matchCat && matchSearch; }); mostrarProductos(productosFiltrados); actualizarInfoResultados(); }
        function actualizarInfoResultados() { document.getElementById('resultadosInfo').innerHTML = '<i class="bi bi-info-circle"></i> ' + productosFiltrados.length + ' productos encontrados'; }
        function mostrarErrorCarga(error) { document.getElementById('productosContainer').innerHTML = '<div class="no-products text-danger"><h3>Error al cargar</h3><p>' + error.message + '</p></div>'; }
        function mostrarConfirmacionCerrarSesion() { document.getElementById('modalConfirmacion').style.display='flex'; }
        function confirmarCerrarSesion() { fetch('UsuarioServlet?accion=logout', {method:'POST'}).then(function() { window.location.href='login.jsp'; }); }
    </script>
</body>
</html>
