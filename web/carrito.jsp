<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Carrito de Compras | DonGlai</title>
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
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark-bg);
            color: #fff;
            margin: 0;
            padding: 0;
        }
        
        .carrito-header {
            background: linear-gradient(90deg, #000000, #0a0a0a, #141414);
            padding: 1rem 2rem;
            border-bottom: 2px solid var(--primary-color);
        }
        
        .producto-carrito {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid var(--primary-color);
            transition: all 0.3s ease;
        }
        
        .producto-carrito:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.2);
        }
        
        .resumen-carrito {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            position: sticky;
            top: 20px;
            border: 1px solid #333;
        }
        
        .btn-cantidad {
            background: #2a2a2a;
            border: 1px solid #444;
            color: var(--primary-color);
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        
        .btn-cantidad:hover {
            background: var(--primary-color);
            color: #000;
            border-color: var(--primary-color);
        }
        
        .input-cantidad {
            background: #2a2a2a;
            border: 1px solid #444;
            color: #fff;
            text-align: center;
            width: 60px;
            border-radius: 10px;
        }
        
        .input-cantidad:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 224, 255, 0.25);
        }
        
        .btn-eliminar {
            transition: all 0.3s ease;
        }
        
        .btn-eliminar:hover {
            transform: scale(1.1);
        }
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-cart i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 224, 255, 0.4);
        }
        
        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
            transition: all 0.3s ease;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: #000;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="carrito-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="${pageContext.request.contextPath}/img/donglai.jpg" alt="DonGlai Logo" 
                         style="height: 50px; border-radius: 8px; margin-right: 15px;">
                    <h1 class="h3 mb-0" style="color: var(--primary-color);">
                        <i class="bi bi-cart3 me-2"></i>Carrito de Compras
                    </h1>
                </div>
                <div>
                    <a href="tienda_web.jsp" class="btn btn-outline-primary me-2">
                        <i class="bi bi-arrow-left me-2"></i>Seguir Comprando
                    </a>
                    <button class="btn btn-danger" onclick="limpiarCarrito()" id="btnLimpiar" style="display: none;">
                        <i class="bi bi-trash me-2"></i>Limpiar Carrito
                    </button>
                </div>
            </div>
        </div>
    </header>

    <!-- Contenido Principal -->
    <main class="container my-5">
        <div class="row">
            <!-- Lista de Productos -->
            <div class="col-lg-8">
                <div id="listaCarrito">
                    <div class="empty-cart">
                        <i class="bi bi-cart-x"></i>
                        <h3 class="mt-3">Tu carrito está vacío</h3>
                        <p class="text-muted">Agrega algunos productos increíbles de LED</p>
                        <a href="tienda_web.jsp" class="btn btn-primary">
                            <i class="bi bi-bag me-2"></i>Ir de Compras
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Resumen del Pedido -->
            <div class="col-lg-4">
                <div class="resumen-carrito">
                    <h4 class="mb-4" style="color: var(--primary-color);">
                        <i class="bi bi-receipt me-2"></i>Resumen del Pedido
                    </h4>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <span id="subtotal">S/ 0.00</span>
                    </div>
                    
                    <div class="d-flex justify-content-between mb-2">
                        <span>IGV (18%):</span>
                        <span id="igv">S/ 0.00</span>
                    </div>
                    
                    <hr style="border-color: #444;">
                    
                    <div class="d-flex justify-content-between mb-4">
                        <strong>Total:</strong>
                        <strong id="total" style="color: var(--primary-color); font-size: 1.2rem;">S/ 0.00</strong>
                    </div>
                    
                    <button class="btn btn-primary w-100 py-3 mb-3" onclick="procederPago()" id="btnPagar" style="display: none;">
                        <i class="bi bi-lock-fill me-2"></i>Proceder al Pago
                    </button>
                    
                    <button class="btn btn-outline-primary w-100" onclick="seguirComprando()">
                        <i class="bi bi-bag me-2"></i>Seguir Comprando
                    </button>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Función para obtener el HTML de la imagen
        function getImagenHTML(item) {
            if (item.imagen && item.imagen.length > 0) {
                return '<img src="data:image/jpeg;base64,' + item.imagen + '" alt="' + item.nombre + '" class="img-fluid rounded" style="height: 80px; width: 80px; object-fit: cover;">';
            } else {
                return '<div class="bg-secondary rounded d-flex align-items-center justify-content-center" style="height: 80px; width: 80px;"><i class="bi bi-lightbulb" style="font-size: 1.5rem; color: var(--primary-color);"></i></div>';
            }
        }

        // Cargar carrito al iniciar la página
        document.addEventListener('DOMContentLoaded', function() {
            cargarCarrito();
        });

        // Función para cargar el carrito
        function cargarCarrito() {
            fetch('CarritoServlet?accion=obtener')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error en la respuesta del servidor');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    if (data.items && data.items.length > 0) {
                        mostrarCarrito(data);
                    } else {
                        mostrarCarritoVacio();
                    }
                } else {
                    throw new Error(data.error || 'Error al cargar el carrito');
                }
            })
            .catch(error => {
                console.error('Error al cargar carrito:', error);
                mostrarError('Error al cargar el carrito: ' + error.message);
                mostrarCarritoVacio();
            });
        }

        // Función para mostrar el carrito con productos
        function mostrarCarrito(data) {
            const listaCarrito = document.getElementById('listaCarrito');
            let html = '<h4 class="mb-4" style="color: var(--primary-color);"><i class="bi bi-cart-check me-2"></i>Productos en el Carrito</h4>';
            
            data.items.forEach(item => {
                const totalProducto = item.precio * item.cantidad;
                
                html += 
                    '<div class="producto-carrito" id="producto-' + item.idProducto + '">' +
                        '<div class="row align-items-center">' +
                            '<div class="col-md-2">' +
                                getImagenHTML(item) +
                            '</div>' +
                            '<div class="col-md-4">' +
                                '<h6 class="mb-1" style="font-weight: 600;">' + item.nombre + '</h6>' +
                                '<small class="text-muted">Stock disponible: ' + item.stock + '</small>' +
                                '<div class="mt-1">' +
                                    '<small style="color: var(--primary-color);">S/ ' + item.precio.toFixed(2) + ' c/u</small>' +
                                '</div>' +
                            '</div>' +
                            '<div class="col-md-2">' +
                                '<div class="h6 mb-0" style="color: var(--primary-color); font-weight: 700;">' +
                                    'S/ ' + totalProducto.toFixed(2) +
                                '</div>' +
                            '</div>' +
                            '<div class="col-md-3">' +
                                '<div class="d-flex align-items-center justify-content-center">' +
                                    '<button class="btn-cantidad" onclick="cambiarCantidad(' + item.idProducto + ', ' + (item.cantidad - 1) + ')" ' +
                                            (item.cantidad <= 1 ? 'disabled' : '') + '>' +
                                        '<i class="bi bi-dash"></i>' +
                                    '</button>' +
                                    '<input type="number" class="form-control input-cantidad mx-2" ' +
                                           'value="' + item.cantidad + '" min="1" max="' + item.stock + '" ' +
                                           'onchange="cambiarCantidad(' + item.idProducto + ', parseInt(this.value))" ' +
                                           'onblur="validarCantidad(' + item.idProducto + ', this)">' +
                                    '<button class="btn-cantidad" onclick="cambiarCantidad(' + item.idProducto + ', ' + (item.cantidad + 1) + ')" ' +
                                            (item.cantidad >= item.stock ? 'disabled' : '') + '>' +
                                        '<i class="bi bi-plus"></i>' +
                                    '</button>' +
                                '</div>' +
                            '</div>' +
                            '<div class="col-md-1">' +
                                '<button class="btn btn-outline-danger btn-sm btn-eliminar" ' +
                                        'onclick="eliminarProducto(' + item.idProducto + ')" ' +
                                        'title="Eliminar producto">' +
                                    '<i class="bi bi-trash"></i>' +
                                '</button>' +
                            '</div>' +
                        '</div>' +
                    '</div>';
            });
            
            listaCarrito.innerHTML = html;
            
            // Actualizar resumen
            document.getElementById('subtotal').textContent = 'S/ ' + data.subtotal.toFixed(2);
            document.getElementById('igv').textContent = 'S/ ' + data.igv.toFixed(2);
            document.getElementById('total').textContent = 'S/ ' + data.total.toFixed(2);
            
            // Mostrar botones
            document.getElementById('btnPagar').style.display = 'block';
            document.getElementById('btnLimpiar').style.display = 'block';
        }

        // Función para validar cantidad ingresada manualmente
        function validarCantidad(idProducto, input) {
            let valor = parseInt(input.value);
            const max = parseInt(input.max);
            const min = parseInt(input.min);
            
            if (isNaN(valor) || valor < min) {
                input.value = min;
                cambiarCantidad(idProducto, min);
            } else if (valor > max) {
                input.value = max;
                cambiarCantidad(idProducto, max);
            }
        }

        // Función para mostrar carrito vacío
        function mostrarCarritoVacio() {
            const listaCarrito = document.getElementById('listaCarrito');
            listaCarrito.innerHTML = 
                '<div class="empty-cart">' +
                    '<i class="bi bi-cart-x"></i>' +
                    '<h3 class="mt-3">Tu carrito está vacío</h3>' +
                    '<p class="text-muted">Agrega algunos productos increíbles de LED</p>' +
                    '<a href="tienda_web.jsp" class="btn btn-primary">' +
                        '<i class="bi bi-bag me-2"></i>Ir de Compras' +
                    '</a>' +
                '</div>';
            
            // Limpiar resumen
            document.getElementById('subtotal').textContent = 'S/ 0.00';
            document.getElementById('igv').textContent = 'S/ 0.00';
            document.getElementById('total').textContent = 'S/ 0.00';
            
            // Ocultar botones
            document.getElementById('btnPagar').style.display = 'none';
            document.getElementById('btnLimpiar').style.display = 'none';
        }

        // Función para mostrar error
        function mostrarError(mensaje) {
            const listaCarrito = document.getElementById('listaCarrito');
            listaCarrito.innerHTML = 
                '<div class="alert alert-danger">' +
                    '<i class="bi bi-exclamation-triangle me-2"></i>' +
                    '<strong>Error:</strong> ' + mensaje +
                '</div>';
        }

        // Función para cambiar cantidad
        function cambiarCantidad(idProducto, nuevaCantidad) {
            if (nuevaCantidad < 1) {
                eliminarProducto(idProducto);
                return;
            }
            
            // Mostrar loading
            const productoElement = document.getElementById('producto-' + idProducto');
            const originalContent = productoElement.innerHTML;
            productoElement.innerHTML = 
                '<div class="text-center py-3">' +
                    '<div class="spinner-border text-primary" role="status">' +
                        '<span class="visually-hidden">Cargando...</span>' +
                    '</div>' +
                    '<p class="mt-2 mb-0">Actualizando...</p>' +
                '</div>';
            
            fetch('CarritoServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'accion=actualizar&idProducto=' + idProducto + '&cantidad=' + nuevaCantidad
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    cargarCarrito(); // Recargar todo el carrito
                } else {
                    alert('Error: ' + data.error);
                    cargarCarrito(); // Recargar para sincronizar
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al actualizar cantidad');
                productoElement.innerHTML = originalContent;
            });
        }

        // Función para eliminar producto
        function eliminarProducto(idProducto) {
            if (!confirm('¿Estás seguro de que quieres eliminar este producto del carrito?')) {
                return;
            }
            
            fetch('CarritoServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'accion=eliminar&idProducto=' + idProducto
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Eliminar visualmente el producto
                    const productoElement = document.getElementById('producto-' + idProducto);
                    productoElement.style.opacity = '0';
                    productoElement.style.transform = 'translateX(-100px)';
                    
                    setTimeout(() => {
                        cargarCarrito(); // Recargar para actualizar resumen
                    }, 300);
                } else {
                    alert('Error: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al eliminar producto');
            });
        }

        // Función para limpiar carrito
        function limpiarCarrito() {
            if (!confirm('¿Estás seguro de que quieres vaciar todo el carrito? Esta acción no se puede deshacer.')) {
                return;
            }
            
            fetch('CarritoServlet?accion=limpiar', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    mostrarNotificacion('✅ Carrito limpiado correctamente', 'success');
                    mostrarCarritoVacio();
                } else {
                    alert('Error: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al limpiar carrito');
            });
        }

        // Función para proceder al pago
        function procederPago() {
            // Verificar que el carrito no esté vacío
            fetch('CarritoServlet?accion=obtener')
            .then(response => response.json())
            .then(data => {
                if (data.success && data.items && data.items.length > 0) {
                    // Redirigir a página de pago
                    window.location.href = 'pago.jsp';
                } else {
                    alert('Tu carrito está vacío. Agrega algunos productos antes de pagar.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al verificar carrito');
            });
        }

        // Función para seguir comprando
        function seguirComprando() {
            window.location.href = 'tienda_web.jsp';
        }

        // Función para mostrar notificaciones
        function mostrarNotificacion(mensaje, tipo) {
            const notificacion = document.createElement('div');
            notificacion.className = 'alert alert-' + (tipo === 'success' ? 'success' : 'danger') + 
                                    ' position-fixed top-0 end-0 m-3';
            notificacion.style.zIndex = '1060';
            notificacion.style.minWidth = '300px';
            notificacion.innerHTML = mensaje;

            document.body.appendChild(notificacion);

            setTimeout(() => {
                notificacion.remove();
            }, 3000);
        }
    </script>
</body>
</html>