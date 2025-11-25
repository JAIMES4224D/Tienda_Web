<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:h="http://xmlns.jcp.org/jsf/html"
      xmlns:p="http://primefaces.org/ui">

<h:head>
    <title>Contacto | DonGlai - Iluminación LED</title>
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

    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

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

        /* === CONTENT CARDS === */
        .content-section {
            padding: 80px 20px;
            background: linear-gradient(to bottom, #0d0d0d, #1a1a1a);
        }
        
        .content-card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .content-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 224, 255, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .content-card:hover::before {
            left: 100%;
        }
        
        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.2);
        }
        
        .content-card h2 {
            color: var(--primary-color);
            font-size: 1.8rem;
            margin-bottom: 15px;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }
        
        .content-card h3 {
            color: var(--secondary-color);
            font-size: 1.4rem;
            margin-top: 20px;
            margin-bottom: 10px;
        }
        
        .content-card p {
            color: #ddd;
            line-height: 1.6;
        }
        
        /* Contact Info Cards */
        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .contact-card {
            background: linear-gradient(145deg, #1a1a1a, #222);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            border-top: 3px solid var(--primary-color);
            position: relative;
            overflow: hidden;
            text-align: center;
        }
        
        .contact-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 224, 255, 0.05) 0%, transparent 50%);
            z-index: 1;
        }
        
        .contact-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 224, 255, 0.3);
        }
        
        .contact-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 1.8rem;
            color: #000;
            font-weight: bold;
            box-shadow: 0 0 15px rgba(0, 224, 255, 0.5);
        }
        
        .contact-title {
            color: var(--primary-color);
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .contact-info {
            color: #ddd;
            margin-bottom: 10px;
            font-size: 1rem;
        }
        
        .contact-detail {
            color: #aaa;
            font-size: 0.9rem;
        }
        
        /* Form Styles */
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
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
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
            display: inline-block;
            margin-top: 10px;
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
            cursor: pointer;
        }
        
        .btn-submit:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 224, 255, 0.6);
            color: #000;
        }
        
        /* Map Styles */
        .map-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            height: 500px;
            position: relative;
        }
        
        #map {
            height: 100%;
            width: 100%;
            z-index: 1;
        }
        
        .route-controls {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1000;
            background: rgba(26, 26, 26, 0.9);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.3);
            width: 300px;
        }
        
        .route-input {
            background: #2a2a2a;
            border: 1px solid #444;
            border-radius: 5px;
            color: #fff;
            padding: 8px 12px;
            width: 100%;
            margin-bottom: 10px;
        }
        
        .route-btn {
            background: var(--primary-color);
            border: none;
            color: #000;
            font-weight: 600;
            border-radius: 5px;
            padding: 8px 15px;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .route-btn:hover {
            background: var(--secondary-color);
        }
        
        /* Hours Section */
        .hours-section {
            padding: 60px 20px;
            background: linear-gradient(to right, #0d0d0d, #1a1a1a);
        }
        
        .hours-card {
            text-align: center;
            padding: 30px 20px;
            border-radius: 10px;
            background: rgba(26, 26, 26, 0.7);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .hours-card:hover {
            transform: translateY(-5px);
        }
        
        .hours-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .hours-title {
            color: var(--primary-color);
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .hours-info {
            color: #ccc;
            font-size: 0.95rem;
            line-height: 1.8;
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
            
            .content-card {
                padding: 20px;
            }
            
            .contact-grid {
                grid-template-columns: 1fr;
            }
            
            .route-controls {
                position: relative;
                width: 100%;
                margin-bottom: 15px;
            }
            
            .map-container {
                height: 400px;
            }
        }
    </style>
</h:head>

<h:body>

    <!-- Contenedor para las cintas LED (sobre todo) -->
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
                    <li class="nav-item"><a class="nav-link active" href="contacto.html">Contacto</a></li>
                    <li class="nav-item"><a class="nav-link btn-login ms-2 px-3" href="login.jsp">
                        <i class="bi bi-person-circle"></i> Iniciar Sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!--  Hero Section -->
    <section class="hero">
        <h1>Contáctanos</h1>
        <p>Estamos aquí para ayudarte. Ponte en contacto con nosotros para cualquier consulta sobre productos, soporte técnico o colaboraciones.</p>
    </section>
    
    <!-- Content Section -->
    <section class="content-section">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="content-card">
                        <h2 align="center"><b>Información de Contacto</b></h2>
                        <div class="contact-grid">
                            <!-- Teléfono -->
                            <div class="contact-card">
                                <div class="contact-icon"><i class="bi bi-telephone-outbound-fill"></i></div>
                                <h3 class="contact-title">Llámanos</h3>
                                <div class="contact-info">+51 999 123 456</div>
                                <div class="contact-detail">Lunes a Viernes: 9:00 AM - 7:00 PM</div>
                            </div>
                            
                            <!-- Email -->
                            <div class="contact-card">
                                <div class="contact-icon"><i class="bi bi-chat-left-heart"></i></div>
                                <h3 class="contact-title">Escríbenos</h3>
                                <div class="contact-info">contacto@donglai.com</div>
                                <div class="contact-detail">Respondemos en menos de 24 horas</div>
                            </div>
                            
                            <!-- Dirección -->
                            <div class="contact-card">
                                <div class="contact-icon"><i class="bi bi-search"></i></div>
                                <h3 class="contact-title">Visítanos</h3>
                                <div class="contact-info">Av. La Luz 123, San Isidro</div>
                                <div class="contact-detail">Lima, Perú</div>
                            </div>
                            
                            <!-- WhatsApp -->
                            <div class="contact-card">
                                <div class="contact-icon"><i class="bi bi-whatsapp"></i></div>
                                <h3 class="contact-title">WhatsApp</h3>
                                <div class="contact-info">+51 999 123 456</div>
                                <div class="contact-detail">Atención rápida por chat</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Formulario y Mapa -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="content-card">
                        <h2 align="center"><b>Envíanos un Mensaje</b></h2>
                        <p class="text-center mb-4">¿Tienes alguna pregunta? Completa el formulario y nos pondremos en contacto contigo.</p>
                        
                        <form id="contact-form">
                            <div class="form-group">
                                <label class="form-label" for="name">Nombre Completo *</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="email">Correo Electrónico *</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="phone">Teléfono</label>
                                <input type="tel" class="form-control" id="phone" name="phone">
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="subject">Asunto *</label>
                                <select class="form-control" id="subject" name="subject" required>
                                    <option value="">Selecciona un asunto</option>
                                    <option value="consulta">Consulta General</option>
                                    <option value="producto">Información de Productos</option>
                                    <option value="soporte">Soporte Técnico</option>
                                    <option value="proveedor">Ser Proveedor</option>
                                    <option value="otro">Otro</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="message">Mensaje *</label>
                                <textarea class="form-control" id="message" name="message" required></textarea>
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn-submit">Enviar Mensaje</button>
                            </div>
                        </form>
                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                const form = document.getElementById('contact-form');
                                const formMessages = document.getElementById('form-messages');

                                form.addEventListener('submit', function(event) {
                                    event.preventDefault(); // Evita que el formulario se envíe de la forma tradicional

                                    // 1. Capturar los datos del formulario
                                    const formData = {
                                        name: document.getElementById('name').value,
                                        email: document.getElementById('email').value,
                                        phone: document.getElementById('phone').value,
                                        subject: document.getElementById('subject').value,
                                        message: document.getElementById('message').value
                                    };

                                    // 2. Convertir el objeto a una cadena JSON
                                    const jsonData = JSON.stringify(formData);

                                    // La URL de tu servlet
                                    const servletUrl = 'MensajesWeb'; 

                                    // 3. Enviar los datos al servidor usando fetch()
                                    fetch(servletUrl, {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/json'
                                        },
                                        body: jsonData
                                    })
                                    .then(response => {
                                        // Verificar si la respuesta fue exitosa
                                        if (!response.ok) {
                                            throw new Error('Error al enviar el formulario. Código de estado: ' + response.status);
                                        }
                                        return response.text(); // CAMBIO: Usar text() en lugar de json()
                                    })
                                    .then(html => {
                                        // 4. Manejar la respuesta HTML del servidor
                                        console.log('Respuesta del servidor recibida');

                                        // Crear una nueva ventana o pestaña con la respuesta
                                        const newWindow = window.open('', '_blank', 'width=600,height=700,scrollbars=yes');

                                        // Escribir el HTML en la nueva ventana
                                        newWindow.document.write(html);
                                        newWindow.document.close();

                                        // Limpiar el formulario
                                        form.reset();

                                        // Opcional: Mostrar mensaje temporal en el formulario
                                        if (formMessages) {
                                            formMessages.textContent = '¡Mensaje enviado con éxito! Se abrirá una ventana de confirmación.';
                                            formMessages.style.color = 'var(--primary-color)';
                                            formMessages.style.fontWeight = 'bold';

                                            // Limpiar el mensaje después de 5 segundos
                                            setTimeout(() => {
                                                formMessages.textContent = '';
                                            }, 5000);
                                        }
                                    })
                                    .catch(error => {
                                        // 5. Manejar cualquier error
                                        console.error('Error:', error);

                                        // Mostrar mensaje de error al usuario
                                        if (formMessages) {
                                            formMessages.textContent = 'Hubo un problema al enviar tu mensaje. Por favor, inténtalo de nuevo más tarde.';
                                            formMessages.style.color = 'red';

                                            // Limpiar el mensaje después de 5 segundos
                                            setTimeout(() => {
                                                formMessages.textContent = '';
                                            }, 5000);
                                        }
                                    });
                                });
                            });
                            </script>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="content-card">
                        <h2 align="center"><b>Nuestra Ubicación</b></h2>
                        <div class="map-container">
                            <div id="map"></div>
                            <div class="route-controls">
                                <h4 style="color: var(--primary-color); margin-bottom: 10px;">¿Cómo llegar?</h4>
                                <input type="text" class="route-input" id="start-address" placeholder="Ingresa tu dirección de origen">
                                <button class="route-btn" id="calculate-route">Calcular Ruta</button>
                                <button class="route-btn" id="clear-route" style="margin-top: 5px; background: #555;">Limpiar Ruta</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Horarios de Atención -->
            <div class="row hours-section">
                <div class="col-md-4 mb-4">
                    <div class="hours-card">
                        <div class="hours-icon"><i class="bi bi-house-heart"></i></div>
                        <div class="hours-title">Tienda Principal</div>
                        <div class="hours-info">
                            Lunes a Viernes: 9:00 AM - 7:00 PM<br>
                            Sábados: 9:00 AM - 2:00 PM<br>
                            Domingos: Cerrado
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="hours-card">
                        <div class="hours-icon"><i class="bi bi-person-raised-hand"></i></div>
                        <div class="hours-title">Soporte Técnico</div>
                        <div class="hours-info">
                            Lunes a Viernes: 8:00 AM - 6:00 PM<br>
                            Sábados: 9:00 AM - 1:00 PM<br>
                            Emergencias: 24/7
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="hours-card">
                        <div class="hours-icon"><i class="bi bi-telephone-fill"></i></div>
                        <div class="hours-title">Atención Telefónica</div>
                        <div class="hours-info">
                            Lunes a Viernes: 8:00 AM - 8:00 PM<br>
                            Sábados: 9:00 AM - 2:00 PM<br>
                            WhatsApp: 24/7
                        </div>
                    </div>
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
    
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
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
            
            // Mapa y funcionalidad de rutas
            let map, routeLayer;
            
            function initMap() {
                // Coordenadas de la tienda DonGlai (Av. La Luz 123, San Isidro, Lima)
                const storeLocation = [-12.099, -77.036];
                
                // Inicializar el mapa
                map = L.map('map').setView(storeLocation, 15);
                
                // Añadir capa de OpenStreetMap
                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                }).addTo(map);
                
                // Añadir marcador de la tienda
                const storeIcon = L.divIcon({
                    html: '<div style="background-color: #00e0ff; width: 30px; height: 30px; border-radius: 50%; border: 3px solid white; box-shadow: 0 0 10px rgba(0, 224, 255, 0.7);"></div>',
                    className: 'custom-div-icon',
                    iconSize: [30, 30],
                    iconAnchor: [15, 15]
                });
                
                L.marker(storeLocation, {icon: storeIcon}).addTo(map)
                    .bindPopup('<b>DonGlai - Tienda Principal</b><br>Av. La Luz 123, San Isidro, Lima')
                    .openPopup();
            }
            
            // Calcular ruta
            document.getElementById('calculate-route').addEventListener('click', function() {
                const startAddress = document.getElementById('start-address').value;
                
                if (!startAddress) {
                    alert('Por favor, ingresa una dirección de origen.');
                    return;
                }
                
                // Simulación de cálculo de ruta (en un caso real usarías una API como OSRM o Google Directions)
                alert('Funcionalidad de ruta: En una implementación real, aquí se calcularía la ruta desde "' + startAddress + '" hasta nuestra tienda usando una API de mapas.');
                
                // En una implementación real, aquí iría el código para calcular y mostrar la ruta
                // Por ejemplo, usando OSRM: http://project-osrm.org/
                
                // Simulación visual de una ruta (línea recta desde un punto aleatorio)
                if (routeLayer) {
                    map.removeLayer(routeLayer);
                }
                
                // Generar un punto de inicio aleatorio cerca de Lima para la demostración
                const startPoint = [
                    -12.099 + (Math.random() - 0.5) * 0.1,
                    -77.036 + (Math.random() - 0.5) * 0.1
                ];
                
                // Crear una línea para simular la ruta
                routeLayer = L.polyline([
                    startPoint,
                    [-12.099, -77.036] // Tienda DonGlai
                ], {
                    color: '#00e0ff',
                    weight: 5,
                    opacity: 0.7,
                    dashArray: '10, 10'
                }).addTo(map);
                
                // Añadir marcador de inicio
                const startIcon = L.divIcon({
                    html: '<div style="background-color: #ffaa00; width: 20px; height: 20px; border-radius: 50%; border: 2px solid white;"></div>',
                    className: 'custom-div-icon',
                    iconSize: [20, 20],
                    iconAnchor: [10, 10]
                });
                
                L.marker(startPoint, {icon: startIcon}).addTo(map)
                    .bindPopup('<b>Origen</b><br>' + startAddress);
                
                // Ajustar el mapa para mostrar toda la ruta
                map.fitBounds([
                    startPoint,
                    [-12.099, -77.036]
                ]);
            });
            
            // Limpiar ruta
            document.getElementById('clear-route').addEventListener('click', function() {
                if (routeLayer) {
                    map.removeLayer(routeLayer);
                    routeLayer = null;
                }
                document.getElementById('start-address').value = '';
                map.setView([-12.099, -77.036], 15);
            });
            
            // Manejo del formulario
            document.getElementById('contact-form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Aquí iría el código para enviar el formulario al servidor
                // Por ahora, solo mostraremos un mensaje de éxito
                alert('¡Mensaje enviado con éxito! Nos pondremos en contacto contigo pronto.');
                document.getElementById('contact-form').reset();
            });
            
            // Inicializar el mapa cuando la página esté cargada
            initMap();
        });
    </script>
</h:body>
</html>