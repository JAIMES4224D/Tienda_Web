<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:p="http://primefaces.org/ui">

<h:head>
    <title>Registro | DonGlai - Iluminación LED</title>
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

        /* === REGISTRATION FORM === */
        .registration-section {
            padding: 80px 20px;
            background: linear-gradient(to bottom, #0d0d0d, #1a1a1a);
        }
        
        .registration-card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .registration-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .registration-card:hover::before {
            left: 100%;
        }
        
        .registration-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.2);
        }
        
        .registration-card h2 {
            color: var(--primary-color);
            font-size: 1.8rem;
            margin-bottom: 25px;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
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
            border-radius: 8px;
            color: #fff;
            padding: 12px 15px;
            width: 100%;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            background-color: #333;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 224, 255, 0.25);
            color: #fff;
            outline: none;
        }
        
        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -5px;
            margin-left: -5px;
        }
        
        .form-col {
            flex: 1 0 0%;
            padding-right: 5px;
            padding-left: 5px;
        }
        
        .password-strength {
            height: 5px;
            border-radius: 5px;
            margin-top: 5px;
            transition: all 0.3s;
        }
        
        .password-weak {
            background-color: #ff4d4d;
            width: 25%;
        }
        
        .password-medium {
            background-color: #ffa500;
            width: 50%;
        }
        
        .password-strong {
            background-color: #00cc66;
            width: 75%;
        }
        
        .password-very-strong {
            background-color: var(--primary-color);
            width: 100%;
        }
        
        .password-strength-text {
            font-size: 0.8rem;
            margin-top: 5px;
            color: #aaa;
        }
        
        .file-upload {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .file-upload-label {
            display: block;
            padding: 12px 15px;
            background-color: #2a2a2a;
            border: 1px dashed #444;
            border-radius: 8px;
            color: #aaa;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .file-upload-label:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
        
        .file-upload-input {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .file-name {
            margin-top: 8px;
            font-size: 0.9rem;
            color: #aaa;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: #000;
            font-weight: 700;
            border-radius: 30px;
            padding: 12px 40px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            display: block;
            margin: 30px auto 0;
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
            cursor: pointer;
            width: 100%;
            max-width: 300px;
        }
        
        .btn-submit:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);
            color: #000;
        }
        
        .btn-submit:disabled {
            background: #555;
            color: #888;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #aaa;
        }
        
        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .login-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .form-messages {
            margin-top: 15px;
            padding: 10px;
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
            margin-top: 50px;
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
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.2rem;
            }
            
            .registration-card {
                padding: 20px;
            }
            
            .form-col {
                flex: 0 0 100%;
                margin-bottom: 15px;
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
                    <li class="nav-item"><a class="nav-link active" href="registro.jsp">Registro</a></li>
                    <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                    <li class="nav-item"><a class="nav-link btn-login ms-2 px-3" href="login.jsp">
                        <i class="bi bi-person-circle"></i> Iniciar Sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!--  Hero Section -->
    <section class="hero">
        <h1>Crear Cuenta</h1>
        <p>Únete a DonGlai y descubre el mundo de la iluminación LED. Regístrate para acceder a ofertas exclusivas y seguimiento de pedidos.</p>
    </section>
    
    <!--  Registration Section -->
    <section class="registration-section">
        <div class="container">
            <div class="registration-card">
                <h2>Formulario de Registro</h2>
                
                <form id="registration-form" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <label class="form-label" for="nombre">Nombre *</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                        </div>
                        <div class="form-col">
                            <div class="form-group">
                                <label class="form-label" for="apellido">Apellido *</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="correo">Correo Electrónico *</label>
                        <input type="email" class="form-control" id="correo" name="correo" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="contrasena">Contraseña *</label>
                        <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                        <div class="password-strength" id="password-strength"></div>
                        <div class="password-strength-text" id="password-strength-text"></div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="confirmar-contrasena">Confirmar Contraseña *</label>
                        <input type="password" class="form-control" id="confirmar-contrasena" name="confirmar-contrasena" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="telefono">Teléfono</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="direccion">Dirección</label>
                        <input type="text" class="form-control" id="direccion" name="direccion">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Foto de Perfil</label>
                        <div class="file-upload">
                            <label class="file-upload-label" for="foto">
                                <i class="bi bi-cloud-arrow-up"></i> Seleccionar archivo
                            </label>
                            <input type="file" class="file-upload-input" id="foto" name="foto" accept="image/*">
                            <div class="file-name" id="file-name">No se ha seleccionado ningún archivo</div>
                        </div>
                    </div>
                    
                    <div id="form-messages" class="form-messages"></div>
                    
                    <button type="submit" class="btn-submit" id="submit-btn">Registrarse</button>
                    
                    <div class="login-link">
                        ¿Ya tienes una cuenta? <a href="login.html">Inicia sesión aquí</a>
                    </div>
                </form>
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
            
            // Funcionalidad del formulario de registro
            const registrationForm = document.getElementById('registration-form');
            const passwordInput = document.getElementById('contrasena');
            const confirmPasswordInput = document.getElementById('confirmar-contrasena');
            const passwordStrength = document.getElementById('password-strength');
            const passwordStrengthText = document.getElementById('password-strength-text');
            const fileInput = document.getElementById('foto');
            const fileName = document.getElementById('file-name');
            const submitBtn = document.getElementById('submit-btn');
            const formMessages = document.getElementById('form-messages');

           // Validación de fortaleza de contraseña
            passwordInput.addEventListener('input', function() {
                const password = passwordInput.value;
                let strength = 0;
                let strengthText = '';

                // Verificar longitud
                if (password.length >= 8) strength++;

                // Verificar letras minúsculas
                if (/[a-z]/.test(password)) strength++;

                // Verificar letras mayúsculas
                if (/[A-Z]/.test(password)) strength++;

                // Verificar números
                if (/[0-9]/.test(password)) strength++;

                // Verificar caracteres especiales
                if (/[^A-Za-z0-9]/.test(password)) strength++;

                // Actualizar indicador visual
                passwordStrength.className = 'password-strength';

                if (strength <= 1) {
                    passwordStrength.classList.add('password-weak');
                    strengthText = 'Contraseña débil';
                } else if (strength <= 3) {
                    passwordStrength.classList.add('password-medium');
                    strengthText = 'Contraseña media';
                } else if (strength <= 4) {
                    passwordStrength.classList.add('password-strong');
                    strengthText = 'Contraseña fuerte';
                } else {
                    passwordStrength.classList.add('password-very-strong');
                    strengthText = 'Contraseña muy fuerte';
                }

                passwordStrengthText.textContent = strengthText;
            });

            // Mostrar nombre de archivo seleccionado
            fileInput.addEventListener('change', function() {
                if (fileInput.files.length > 0) {
                    fileName.textContent = fileInput.files[0].name;
                } else {
                    fileName.textContent = 'No se ha seleccionado ningún archivo';
                }
            });
            
            
            // Validación del formulario
            registrationForm.addEventListener('submit', function(e) {
                e.preventDefault();

                // Limpiar mensajes anteriores
                formMessages.textContent = '';
                formMessages.className = 'form-messages';

                // Validaciones básicas
                const nombre = document.getElementById('nombre').value.trim();
                const apellido = document.getElementById('apellido').value.trim();
                const correo = document.getElementById('correo').value.trim();
                const contrasena = passwordInput.value;
                const confirmarContrasena = confirmPasswordInput.value;

                if (!nombre || !apellido || !correo || !contrasena || !confirmarContrasena) {
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

                // Validar que las contraseñas coincidan
                if (contrasena !== confirmarContrasena) {
                    formMessages.textContent = 'Las contraseñas no coinciden. Por favor, verifica.';
                    formMessages.classList.add('form-error');
                    return;
                }

                // Validar fortaleza de contraseña
                if (contrasena.length < 8) {
                    formMessages.textContent = 'La contraseña debe tener al menos 8 caracteres.';
                    formMessages.classList.add('form-error');
                    return;
                }

                // Deshabilitar botón de envío
                submitBtn.disabled = true;
                submitBtn.textContent = 'Registrando...';

                // Crear FormData para enviar el formulario
                const formData = new FormData(registrationForm);

                // Agregar el rol (siempre será 'cliente' para este formulario)
                formData.append('rol', 'cliente');

                // Mostrar indicador de carga
                formMessages.textContent = 'Procesando registro...';
                formMessages.classList.add('form-success');

                // Enviar datos al servlet
                fetch('RegistroUsuario', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        // Si el servidor responde con un error HTTP
                        throw new Error(`Error del servidor: ${response.status} ${response.statusText}`);
                    }
                    return response.text();
                })
                .then(data => {
                    // Manejar respuesta exitosa
                    console.log('Respuesta del servidor:', data);

                    // Verificar el contenido de la respuesta
                    if (data.includes('éxito') || data.includes('exitoso') || data.toLowerCase().includes('success')) {
                        formMessages.textContent = '¡Registro exitoso! Tu cuenta ha sido creada. Redirigiendo...';
                        formMessages.classList.add('form-success');

                        // Limpiar formulario
                        registrationForm.reset();
                        passwordStrength.className = 'password-strength';
                        passwordStrengthText.textContent = '';
                        fileName.textContent = 'No se ha seleccionado ningún archivo';

                        // Redirigir después de 3 segundos
                        setTimeout(() => {
                            window.location.href = 'login.jsp';
                        }, 3000);
                    } else {
                        // Si la respuesta no indica éxito
                        throw new Error(data || 'Error desconocido en el registro');
                    }
                })
                .catch(error => {
                    console.error('Error completo:', error);

                    // Mostrar mensaje de error específico
                    let errorMessage = 'Error al registrar: ';

                    if (error.message.includes('409') || error.message.includes('correo existente')) {
                        errorMessage += 'El correo electrónico ya está registrado.';
                    } else if (error.message.includes('500')) {
                        errorMessage += 'Error interno del servidor. Intenta más tarde.';
                    } else {
                        errorMessage += error.message;
                    }

                    formMessages.textContent = errorMessage;
                    formMessages.classList.add('form-error');

                    // Habilitar botón de envío nuevamente
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Registrarse';
                });
            });
        });
    </script>
</h:body>
</html>