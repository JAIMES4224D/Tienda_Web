<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:p="http://primefaces.org/ui">

<h:head>
    <title>Iniciar Sesión | DonGlai - Iluminación LED</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/donglai.ico" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- PrimeFlex -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/primeflex/3.3.0/primeflex.min.css" rel="stylesheet"/>

    <!-- PrimeFaces Theme -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/primefaces/13.0.0/themes/bootstrap4-dark-blue/theme.min.css" rel="stylesheet"/>

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

    <style>
        :root {
            --primary-color: #00e0ff;
            --secondary-color: #00a2ff;
            --dark-bg: #0d0d0d;
            --card-bg: #1a1a1a;
            --accent-color: #ff00aa;
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

        /* === NAVBAR === */
        .navbar {
            background: linear-gradient(90deg, #000000, #0a0a0a, #141414);
            padding: 1rem 2rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.5);
            position: relative;
            z-index: 1000;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
        }

        .navbar-brand img {
            height: 50px;
            margin-right: 10px;
            border-radius: 8px;
        }

        .navbar-nav .nav-link {
            color: #fff !important;
            font-weight: 500;
            margin: 0 0.8rem;
            transition: 0.3s;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }

        .btn-login {
            border: 1px solid var(--primary-color);
            border-radius: 30px;
            color: var(--primary-color) !important;
            transition: 0.3s;
        }

        .btn-login:hover {
            background-color: var(--primary-color);
            color: #000 !important;
        }

        /* === HERO === */
        .hero {
            background: radial-gradient(circle at center, #1b1b1b 0%, #000000 100%);
            text-align: center;
            padding: 80px 20px;
            animation: fadeIn 2s ease;
            position: relative;
            z-index: 10;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(0, 224, 255, 0.1) 0%, transparent 70%);
            z-index: -1;
        }

        .hero h1 {
            color: var(--primary-color);
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 0 10px rgba(0, 224, 255, 0.5);
        }

        .hero p {
            color: #ccc;
            font-size: 1.2rem;
            max-width: 700px;
            margin: 1rem auto;
        }

        /* === LOGIN SECTION === */
        .login-section {
            padding: 80px 20px;
            background: linear-gradient(to bottom, #0d0d0d, #1a1a1a);
            min-height: 70vh;
            display: flex;
            align-items: center;
        }
        
        .login-container {
            display: flex;
            max-width: 1100px;
            margin: 0 auto;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            background: var(--card-bg);
        }
        
        .login-left {
            flex: 1;
            background: linear-gradient(135deg, rgba(0, 224, 255, 0.1), rgba(0, 162, 255, 0.1));
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .login-left::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(0,224,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            z-index: 0;
        }
        
        .login-left-content {
            position: relative;
            z-index: 1;
        }
        
        .login-left h2 {
            color: var(--primary-color);
            font-size: 2.2rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .login-left p {
            color: #ccc;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .features-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .features-list li {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            color: #ddd;
        }
        
        .features-list i {
            color: var(--primary-color);
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .login-right {
            flex: 1;
            padding: 60px 40px;
            background: var(--card-bg);
            position: relative;
        }
        
        .login-right::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.05), transparent);
            z-index: 0;
        }
        
        .login-form-container {
            position: relative;
            z-index: 1;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .login-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: #000;
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.5);
        }
        
        .login-header h2 {
            color: var(--primary-color);
            font-size: 1.8rem;
            margin-bottom: 10px;
        }
        
        .login-header p {
            color: #aaa;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-label {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            background-color: #2a2a2a;
            border: 1px solid #444;
            border-radius: 10px;
            color: #fff;
            padding: 15px 20px;
            width: 100%;
            transition: all 0.3s;
            font-size: 1rem;
        }
        
        .form-control:focus {
            background-color: #333;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 224, 255, 0.25);
            color: #fff;
            outline: none;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #aaa;
            cursor: pointer;
            font-size: 1.2rem;
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .role-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
        }
        
        .role-option {
            flex: 1;
            text-align: center;
            padding: 15px;
            background: #2a2a2a;
            border: 2px solid #444;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .role-option:hover {
            border-color: var(--primary-color);
        }
        
        .role-option.selected {
            background: rgba(0, 224, 255, 0.1);
            border-color: var(--primary-color);
            box-shadow: 0 0 15px rgba(0, 224, 255, 0.3);
        }
        
        .role-icon {
            font-size: 1.5rem;
            margin-bottom: 8px;
            color: var(--primary-color);
        }
        
        .role-name {
            font-weight: 600;
            color: #fff;
        }
        
        .role-desc {
            font-size: 0.8rem;
            color: #aaa;
            margin-top: 5px;
        }
        
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input {
            margin-right: 8px;
        }
        
        .remember-me label {
            color: #ccc;
            font-size: 0.9rem;
        }
        
        .forgot-password {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }
        
        .forgot-password:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .btn-login-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: #000;
            font-weight: 700;
            border-radius: 30px;
            padding: 15px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
            cursor: pointer;
            margin-bottom: 25px;
        }
        
        .btn-login-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);
            color: #000;
        }
        
        .btn-login-submit:disabled {
            background: #555;
            color: #888;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #aaa;
        }
        
        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s;
            font-weight: 600;
        }
        
        .register-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .form-messages {
            margin-top: 15px;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
        }
        
        .form-success {
            background-color: rgba(0, 204, 102, 0.2);
            color: #00cc66;
            border: 1px solid #00cc66;
        }
        
        .form-error {
            background-color: rgba(255, 77, 77, 0.2);
            color: #ff4d4d;
            border: 1px solid #ff4d4d;
        }

        /* === FOOTER === */
        footer {
            background-color: #000;
            color: #aaa;
            text-align: center;
            padding: 25px 0;
            font-size: 0.95rem;
            position: relative;
            z-index: 10;
        }
        
        .footer-icons {
            margin: 15px 0;
        }
        
        .footer-icons i {
            margin: 0 10px;
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 10px var(--primary-color); }
            50% { box-shadow: 0 0 25px var(--primary-color); }
        }

        /* === EFECTO CINTAS LED === */
        #led-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 100;
        }
        
        .led-trail {
            position: absolute;
            width: 24px;
            height: 10px;
            border-radius: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color), #0066ff);
            box-shadow: 0 0 15px var(--primary-color), 0 0 30px var(--secondary-color);
            pointer-events: none;
            z-index: 101;
            opacity: 0;
            transition: opacity 0.3s;
            filter: blur(0.5px);
        }
        
        .led-trail.active {
            opacity: 0.9;
        }
        
        /* Efecto de partículas LED */
        .led-particle {
            position: absolute;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: var(--primary-color);
            box-shadow: 0 0 10px var(--primary-color), 0 0 15px var(--secondary-color);
            pointer-events: none;
            z-index: 101;
            opacity: 0;
        }
        
        /* Cursor personalizado */
        .led-cursor {
            position: fixed;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: radial-gradient(circle, var(--primary-color), transparent);
            box-shadow: 0 0 15px var(--primary-color);
            pointer-events: none;
            z-index: 9999;
            opacity: 0.7;
            transform: translate(-50%, -50%);
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-left, .login-right {
                padding: 40px 30px;
            }
        }
        
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.2rem;
            }
            
            .login-left, .login-right {
                padding: 30px 20px;
            }
            
            .form-options {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .role-selector {
                flex-direction: column;
            }
        }
    </style>
</h:head>

<h:body>

    <!--  Contenedor para las cintas LED (sobre todo) -->
    <div id="led-container"></div>
    
    <!--  Cursor personalizado LED -->
    <div class="led-cursor" id="led-cursor"></div>

    <!--  Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.html">
                <img src="img/donglai.jpg" alt="logo" />
                DonGlai
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-center">
                    <li class="nav-item"><a class="nav-link" href="index.html">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="nosotros.html">Nosotros</a></li>
                    <li class="nav-item"><a class="nav-link" href="proveedores.html">Proveedores</a></li>
                    <li class="nav-item"><a class="nav-link" href="tienda.html">Tienda</a></li>
                    <li class="nav-item"><a class="nav-link" href="registro.jsp">Registro</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                    <li class="nav-item"><a class="nav-link btn-login ms-2 px-3 active" href="login.jsp">
                        <i class="bi bi-person-circle"></i> Iniciar Sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!--  Hero Section -->
    <section class="hero">
        <h1>Iniciar Sesión</h1>
        <p>Accede a tu cuenta de DonGlai para gestionar tus pedidos, ver ofertas exclusivas y más.</p>
    </section>
    
    <!--  Login Section -->
    <section class="login-section">
        <div class="login-container">
            <!-- Left Panel - Information -->
            <div class="login-left">
                <div class="login-left-content">
                    <h2>Bienvenido de nuevo</h2>
                    <p>Inicia sesión para acceder a todas las funcionalidades de DonGlai. Como cliente podrás gestionar tus pedidos y ver ofertas exclusivas. Como administrador tendrás acceso al panel de control.</p>
                    
                    <ul class="features-list">
                        <li><i class="bi bi-lightning-charge-fill"></i> Acceso rápido y seguro</li>
                        <li><i class="bi bi-shield-check"></i> Protección de datos garantizada</li>
                        <li><i class="bi bi-truck"></i> Seguimiento de pedidos</li>
                        <li><i class="bi bi-gift"></i> Ofertas exclusivas para clientes</li>
                        <li><i class="bi bi-headset"></i> Soporte prioritario</li>
                    </ul>
                </div>
            </div>
            
            <!-- Right Panel - Login Form -->
            <div class="login-right">
                <div class="login-form-container">
                    <div class="login-header">
                        <div class="login-icon">
                            <i class="bi bi-person-check-fill"></i>
                        </div>
                        <h2>Acceso a la Cuenta</h2>
                        <p>Ingresa tus credenciales para continuar</p>
                    </div>
                    
                    <form id="login-form">
                        <!-- Role Selector -->
                        <div class="role-selector">
                            <div class="role-option selected" data-role="cliente">
                                <div class="role-icon"><i class="bi bi-person"></i></div>
                                <div class="role-name">Cliente</div>
                                <div class="role-desc">Acceso a compras</div>
                            </div>
                            <div class="role-option" data-role="admin">
                                <div class="role-icon"><i class="bi bi-shield-lock"></i></div>
                                <div class="role-name">Administrador</div>
                                <div class="role-desc">Panel de control</div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="correo">Correo Electrónico</label>
                            <input type="email" class="form-control" id="correo" name="correo" required>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="contrasena">Contraseña</label>
                            <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                            <button type="button" class="password-toggle" id="password-toggle">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                        
                        <div class="form-options">
                            <div class="remember-me">
                                <input type="checkbox" id="remember" name="remember">
                                <label for="remember">Recordar sesión</label>
                            </div>
                            <a href="#" class="forgot-password">¿Olvidaste tu contraseña?</a>
                        </div>
                        
                        <input type="hidden" id="rol" name="rol" value="cliente">
                        
                        <button type="submit" class="btn-login-submit" id="submit-btn">Iniciar Sesión</button>
                        
                        <div id="form-messages" class="form-messages"></div>
                        
                        <div class="register-link">
                            ¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!--  Footer -->
    <footer>
        <div class="container">
            <p>© 2025 DonGlai - Innovando en Iluminación LED</p>
            <div class="footer-icons">
                <i class="bi bi-envelope"></i>
                <i class="bi bi-telephone"></i>
                <i class="bi bi-geo-alt"></i>
                <i class="bi bi-instagram"></i>
            </div>
            <p>contacto@donglai.com | +51 999 123 456</p>
            <p>Av. La Luz 123, Lima, Perú</p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script para el efecto de cintas LED -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ledContainer = document.getElementById('led-container');
            const ledCursor = document.getElementById('led-cursor');
            const ledTrails = [];
            const particles = [];
            let mouseX = 0, mouseY = 0;
            let prevX = 0, prevY = 0;
            let mouseInWindow = true;
            
            // Crear cintas LED iniciales
            for (let i = 0; i < 20; i++) {
                const trail = document.createElement('div');
                trail.className = 'led-trail';
                ledContainer.appendChild(trail);
                ledTrails.push({
                    element: trail,
                    x: 0,
                    y: 0,
                    scale: 1,
                    opacity: 0,
                    delay: i * 0.04 // Retraso progresivo para crear efecto de cola
                });
            }
            
            // Crear partículas LED
            for (let i = 0; i < 40; i++) {
                const particle = document.createElement('div');
                particle.className = 'led-particle';
                ledContainer.appendChild(particle);
                particles.push({
                    element: particle,
                    x: 0,
                    y: 0,
                    vx: 0,
                    vy: 0,
                    life: 0,
                    maxLife: 0
                });
            }
            
            // Seguimiento del mouse
            document.addEventListener('mousemove', function(e) {
                mouseX = e.clientX;
                mouseY = e.clientY;
                
                // Actualizar cursor personalizado
                ledCursor.style.left = mouseX + 'px';
                ledCursor.style.top = mouseY + 'px';
                
                // Activar cintas LED
                if (mouseInWindow) {
                    ledTrails.forEach(trail => {
                        trail.element.classList.add('active');
                    });
                }
            });
            
            // Animación de las cintas LED
            function animateLEDs() {
                // Actualizar posición de las cintas
                ledTrails.forEach((trail, index) => {
                    const delayFactor = trail.delay;
                    
                    // Calcular posición con retraso
                    const targetX = mouseX - 12; // Ajuste para centrar
                    const targetY = mouseY - 5;  // Ajuste para centrar
                    
                    if (index === 0) {
                        trail.x = targetX;
                        trail.y = targetY;
                    } else {
                        const prevTrail = ledTrails[index - 1];
                        trail.x += (prevTrail.x - trail.x) * 0.3;
                        trail.y += (prevTrail.y - trail.y) * 0.3;
                    }
                    
                    // Aplicar transformación
                    trail.element.style.left = trail.x + 'px';
                    trail.element.style.top = trail.y + 'px';
                    trail.element.style.transform = `scale(${trail.scale})`;
                    trail.element.style.opacity = trail.opacity;
                });
                
                // Crear partículas ocasionales
                if (Math.random() < 0.4 && mouseX !== prevX && mouseY !== prevY && mouseInWindow) {
                    const availableParticle = particles.find(p => p.life <= 0);
                    if (availableParticle) {
                        availableParticle.x = mouseX;
                        availableParticle.y = mouseY;
                        availableParticle.vx = (Math.random() - 0.5) * 5;
                        availableParticle.vy = (Math.random() - 0.5) * 5;
                        availableParticle.life = availableParticle.maxLife = Math.random() * 25 + 15;
                        availableParticle.element.style.opacity = '0.8';
                    }
                }
                
                // Actualizar partículas
                particles.forEach(particle => {
                    if (particle.life > 0) {
                        particle.x += particle.vx;
                        particle.y += particle.vy;
                        particle.life--;
                        
                        particle.element.style.left = particle.x + 'px';
                        particle.element.style.top = particle.y + 'px';
                        particle.element.style.opacity = (particle.life / particle.maxLife) * 0.8;
                        
                        if (particle.life <= 0) {
                            particle.element.style.opacity = '0';
                        }
                    }
                });
                
                prevX = mouseX;
                prevY = mouseY;
                
                requestAnimationFrame(animateLEDs);
            }
            
            // Iniciar animación
            animateLEDs();
            
            // Ocultar cintas cuando el mouse sale de la ventana
            document.addEventListener('mouseleave', function() {
                mouseInWindow = false;
                ledTrails.forEach(trail => {
                    trail.element.classList.remove('active');
                });
                ledCursor.style.opacity = '0';
            });
            
            // Mostrar cintas cuando el mouse entra en la ventana
            document.addEventListener('mouseenter', function() {
                mouseInWindow = true;
                ledTrails.forEach(trail => {
                    trail.element.classList.add('active');
                });
                ledCursor.style.opacity = '0.7';
            });
            
            // Efecto al hacer clic
            document.addEventListener('click', function() {
                // Crear explosión de partículas al hacer clic
                for (let i = 0; i < 10; i++) {
                    const availableParticle = particles.find(p => p.life <= 0);
                    if (availableParticle) {
                        availableParticle.x = mouseX;
                        availableParticle.y = mouseY;
                        availableParticle.vx = (Math.random() - 0.5) * 12;
                        availableParticle.vy = (Math.random() - 0.5) * 12;
                        availableParticle.life = availableParticle.maxLife = Math.random() * 20 + 10;
                        availableParticle.element.style.opacity = '1';
                    }
                }
            });
            
            // Funcionalidad del formulario de login
            const loginForm = document.getElementById('login-form');
            const passwordInput = document.getElementById('contrasena');
            const passwordToggle = document.getElementById('password-toggle');
            const roleOptions = document.querySelectorAll('.role-option');
            const roleInput = document.getElementById('rol');
            const submitBtn = document.getElementById('submit-btn');
            const formMessages = document.getElementById('form-messages');

            // Toggle para mostrar/ocultar contraseña
            passwordToggle.addEventListener('click', function() {
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    passwordToggle.innerHTML = '<i class="bi bi-eye-slash"></i>';
                } else {
                    passwordInput.type = 'password';
                    passwordToggle.innerHTML = '<i class="bi bi-eye"></i>';
                }
            });

            // Selección de rol
            roleOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Remover clase selected de todos
                    roleOptions.forEach(opt => opt.classList.remove('selected'));

                    // Agregar clase selected al clickeado
                    this.classList.add('selected');

                    // Actualizar valor del campo oculto
                    roleInput.value = this.getAttribute('data-role');
                });
            });

            // Validación del formulario
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();

                // Limpiar mensajes anteriores
                formMessages.textContent = '';
                formMessages.className = 'form-messages';

                // Validar campos
                const correo = document.getElementById('correo').value.trim();
                const contrasena = document.getElementById('contrasena').value;
                const rol = roleInput.value;

                if (!correo || !contrasena) {
                    formMessages.textContent = 'Por favor, completa todos los campos obligatorios.';
                    formMessages.classList.add('form-error');
                    return;
                }

                // Validar formato de email
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(correo)) {
                    formMessages.textContent = 'Por favor, ingresa un correo electrónico válido.';
                    formMessages.classList.add('form-error');
                    return;
                }

                // Deshabilitar botón de envío
                submitBtn.disabled = true;
                submitBtn.textContent = 'Iniciando sesión...';

                // Crear objeto JSON con los datos
                const datosLogin = {
                    correo: correo,
                    contrasena: contrasena,
                    rol: rol
                };

                // Mostrar indicador de carga
                formMessages.textContent = 'Verificando credenciales...';
                formMessages.classList.add('form-success');

                // Enviar datos como JSON al servlet
                fetch('LoginUsuario', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json; charset=UTF-8'
                    },
                    body: JSON.stringify(datosLogin)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Error del servidor: ${response.status} ${response.statusText}`);
                    }
                    return response.json();
                })
                .then(data => {
                    // Manejar respuesta JSON del servidor
                    if (data.success) {
                        formMessages.textContent = '¡Inicio de sesión exitoso! Redirigiendo...';
                        formMessages.classList.add('form-success');

                        // Redirigir según el rol
                        setTimeout(() => {
                            if (data.rol === 'admin') {
                                window.location.href = 'admin_principal.jsp';
                            } else {
                                window.location.href = 'tienda_web.jsp';
                            }
                        }, 1500);
                    } else {
                        throw new Error(data.message || 'Error desconocido en el inicio de sesión');
                    }
                })
                .catch(error => {
                    console.error('Error completo:', error);

                    // Mostrar mensaje de error específico
                    let errorMessage = 'Error al iniciar sesión: ';

                    if (error.message.includes('401') || error.message.includes('credenciales')) {
                        errorMessage += 'Correo electrónico o contraseña incorrectos.';
                    } else if (error.message.includes('404')) {
                        errorMessage += 'Usuario no encontrado.';
                    } else if (error.message.includes('403')) {
                        errorMessage += 'No tienes permisos para acceder con este rol.';
                    } else {
                        errorMessage += error.message;
                    }

                    formMessages.textContent = errorMessage;
                    formMessages.classList.add('form-error');

                    // Habilitar botón de envío nuevamente
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Iniciar Sesión';
                });
            });
        });
    </script>
</h:body>
</html>