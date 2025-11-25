-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-11-2025 a las 02:14:55
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda_led`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_productos_por_nombre` (IN `p_nombre` VARCHAR(100))   BEGIN
    SELECT 
        p.id_producto,
        p.nombre_producto,
        p.descripcion,
        p.precio,
        p.stock,
        p.id_categoria,
        p.imagen,
        p.fecha_registro,
        c.nombre_categoria
    FROM productos p
    LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE p.nombre_producto LIKE p_nombre 
       OR p.descripcion LIKE p_nombre
       OR c.nombre_categoria LIKE p_nombre
    ORDER BY p.fecha_registro DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_usuario_por_correo` (IN `p_correo` VARCHAR(100))   BEGIN
    SELECT 
        id_usuario,
        nombre,
        apellido,
        correo,
        contrasena,
        telefono,
        direccion,
        foto,
        rol,
        fecha_registro
    FROM usuarios 
    WHERE correo = p_correo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_mensajes_web` (IN `p_nombre_completo` VARCHAR(70), IN `p_correo` VARCHAR(100), IN `p_telefono` VARCHAR(15), IN `p_asunto` VARCHAR(50), IN `p_mensaje` TEXT)   BEGIN
    INSERT INTO mensajes_web (
        nombre_completo,
        correo_electronico,
        telefono,
        asunto,
        mensaje,
        estado
    )
    VALUES (
        p_nombre_completo,
        p_correo,
        p_telefono,
        p_asunto,
        p_mensaje,
        'Pendiente'
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_usuario` (IN `p_nombre` VARCHAR(100), IN `p_apellido` VARCHAR(100), IN `p_correo` VARCHAR(100), IN `p_contrasena` VARCHAR(255), IN `p_telefono` VARCHAR(15), IN `p_direccion` VARCHAR(200), IN `p_foto` LONGBLOB, IN `p_rol` ENUM('cliente','admin'))   BEGIN
    -- Si no se envía rol, por defecto será 'cliente'
    IF p_rol IS NULL OR p_rol = '' THEN
        SET p_rol = 'cliente';
    END IF;

    INSERT INTO usuarios (
        nombre,
        apellido,
        correo,
        contrasena,
        telefono,
        direccion,
        foto,
        rol,
        fecha_registro
    )
    VALUES (
        p_nombre,
        p_apellido,
        p_correo,
        p_contrasena,
        p_telefono,
        p_direccion,
        p_foto,
        p_rol,
        NOW()
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_categorias` ()   BEGIN
    SELECT 
        id_categoria,
        nombre_categoria,
        descripcion
    FROM categorias
    ORDER BY nombre_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_categoria_por_id` (IN `p_id_categoria` INT)   BEGIN
    SELECT 
        id_categoria,
        nombre_categoria,
        descripcion
    FROM categorias
    WHERE id_categoria = p_id_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_productos_con_categorias` ()   BEGIN
    SELECT 
        p.id_producto,
        p.nombre_producto,
        p.descripcion,
        p.precio,
        p.stock,
        p.id_categoria,
        p.imagen,
        p.fecha_registro,
        c.nombre_categoria,
        c.descripcion as descripcion_categoria
    FROM productos p
    LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
    ORDER BY p.fecha_registro DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_productos_por_categoria` (IN `p_id_categoria` INT)   BEGIN
    SELECT 
        p.id_producto,
        p.nombre_producto,
        p.descripcion,
        p.precio,
        p.stock,
        p.id_categoria,
        p.imagen,
        p.fecha_registro,
        c.nombre_categoria,
        c.descripcion as descripcion_categoria
    FROM productos p
    LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE p.id_categoria = p_id_categoria OR p_id_categoria IS NULL
    ORDER BY p.fecha_registro DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_producto_por_id` (IN `p_id_producto` INT)   BEGIN
    SELECT 
        p.id_producto,
        p.nombre_producto,
        p.descripcion,
        p.precio,
        p.stock,
        p.id_categoria,
        p.imagen,
        p.fecha_registro,
        c.nombre_categoria
    FROM productos p
    LEFT JOIN categorias c ON p.id_categoria = c.id_categoria
    WHERE p.id_producto = p_id_producto;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritos`
--

CREATE TABLE `carritos` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `estado` enum('activo','finalizado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nombre_categoria`, `descripcion`) VALUES
(1, 'Focos LED', 'Focos de bajo consumo para iluminación general del hogar y oficina.'),
(2, 'Tiras LED', 'Iluminación decorativa y funcional en formato de cinta flexible.'),
(3, 'Paneles LED', 'Soluciones de iluminación delgada para techos y oficinas.'),
(4, 'Reflectores LED', 'Iluminación potente para exteriores, jardines y fachadas.'),
(5, 'Luces de Emergencia', 'Sistemas de iluminación autónomos que se activan al fallar la corriente.'),
(6, 'Iluminación Inteligente', 'Focos y sistemas de luz controlados por WiFi, Bluetooth o asistentes de voz.'),
(7, 'Focos Vintage', 'Bombillas con filamento expuesto, estilo retro (Edison), con tecnología LED.'),
(8, 'Luces para Auto', 'Faros, luces internas, neblineros y luces decorativas LED para vehículos.'),
(9, 'Dicroicos LED', 'Luces focalizadas, ideales para resaltar objetos, vitrinas o para baños y cocinas.'),
(10, 'Iluminación Industrial', 'Campanas y luminarias de alta potencia para almacenes, fábricas y grandes superficies.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `fecha_compra` datetime DEFAULT current_timestamp(),
  `total_compra` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_carrito`
--

CREATE TABLE `detalle_carrito` (
  `id_detalle` int(11) NOT NULL,
  `id_carrito` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id_detalle_compra` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `costo_unitario`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precio_unitario`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_web`
--

CREATE TABLE `mensajes_web` (
  `id_mensaje` int(11) NOT NULL,
  `nombre_completo` varchar(70) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `asunto` varchar(50) NOT NULL,
  `mensaje` text NOT NULL,
  `estado` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes_web`
--

INSERT INTO `mensajes_web` (`id_mensaje`, `nombre_completo`, `correo_electronico`, `telefono`, `asunto`, `mensaje`, `estado`) VALUES
(1, 'Jeferson Jaimes', 'jaimespassunijeferson@gmail.com', '931976361', 'otro', 'tienda el lugar', 'Pendiente'),
(2, 'Jeferson Jociney Jaimes Passuni', 'duduphudu@gmail.com', '931976361', 'consulta', 'hola ', 'Pendiente'),
(3, 'Jadyra Marisol Paucar Livias', 'jadyra18@gmail.com', '927676744', 'soporte', 'Me mandaron unas luces y nose como conectarlas me puede ayudar', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id_pago` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `metodo_pago` enum('tarjeta','transferencia','efectivo') DEFAULT 'tarjeta',
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_pedido` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','pagado','enviado','entregado','cancelado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `id_categoria` int(11) DEFAULT NULL,
  `imagen` longblob DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `descripcion`, `precio`, `stock`, `id_categoria`, `imagen`, `fecha_registro`) VALUES
(1, 'Foco LED A60 9W Luz Cálida', 'Foco estándar E27, 810 lúmenes, ideal para salas y dormitorios.', 7.90, 150, 1, NULL, '2025-11-06 19:49:24'),
(2, 'Foco LED A60 9W Luz Fría', 'Foco estándar E27, 850 lúmenes, ideal para cocinas y oficinas.', 7.90, 180, 1, NULL, '2025-11-06 19:49:24'),
(3, 'Foco LED 12W Luz de Día', 'Potencia media, 1050 lúmenes, iluminación general brillante.', 11.50, 120, 1, NULL, '2025-11-06 19:49:24'),
(4, 'Foco LED Bulbo 50W', 'Alta potencia E27, para patios o espacios amplios, luz fría.', 45.00, 40, 1, NULL, '2025-11-06 19:49:24'),
(5, 'Foco LED Vela E14 5W', 'Foco tipo vela para lámparas y candelabros, luz cálida.', 9.00, 70, 1, NULL, '2025-11-06 19:49:24'),
(6, 'Foco LED 3 Pasos 10W', 'Cambia de intensidad (100%, 50%, 15%) con el interruptor.', 15.00, 60, 1, NULL, '2025-11-06 19:49:24'),
(7, 'Foco LED PAR20 7W', 'Luz focalizada E27, ideal para rieles o spots.', 22.00, 50, 1, NULL, '2025-11-06 19:49:24'),
(8, 'Foco LED G9 3W', 'Cápsula de pines para lámparas especiales, luz cálida.', 14.00, 45, 1, NULL, '2025-11-06 19:49:24'),
(9, 'Foco LED A60 15W Luz Fría', 'Alta luminosidad 1350 lúmenes, rosca E27.', 14.90, 90, 1, NULL, '2025-11-06 19:49:24'),
(10, 'Foco LED Ahorrador 20W', 'Equivalente a 150W incandescente, luz de día.', 25.00, 55, 1, NULL, '2025-11-06 19:49:24'),
(11, 'Tira LED 5050 RGB (5m)', 'Multicolor con control remoto, 12V, adhesiva.', 49.90, 80, 2, NULL, '2025-11-06 19:49:24'),
(12, 'Tira LED 2835 Luz Cálida (5m)', 'Luz decorativa sutil, 12V, ideal para zócalos.', 29.90, 100, 2, NULL, '2025-11-06 19:49:24'),
(13, 'Tira LED 2835 Luz Fría (5m)', 'Luz blanca brillante para iluminación de trabajo.', 29.90, 110, 2, NULL, '2025-11-06 19:49:24'),
(14, 'Tira LED 5050 Monocromática Azul (5m)', 'Color azul intenso, 12V.', 35.00, 50, 2, NULL, '2025-11-06 19:49:24'),
(15, 'Tira LED Neón Flex 12V (metro)', 'Tira flexible que simula neón, luz cálida, precio por metro.', 25.00, 200, 2, NULL, '2025-11-06 19:49:24'),
(16, 'Tira LED Neón Flex 12V (metro) - Rosa', 'Tira flexible que simula neón, color rosa, precio por metro.', 28.00, 150, 2, NULL, '2025-11-06 19:49:24'),
(17, 'Tira LED 5630 Luz Fría (5m)', 'Mayor potencia lumínica que 5050, 12V.', 55.00, 60, 2, NULL, '2025-11-06 19:49:24'),
(18, 'Controlador WiFi para Tira RGB', 'Controla tus tiras LED RGB con el celular (App).', 39.00, 70, 2, NULL, '2025-11-06 19:49:24'),
(19, 'Fuente 12V 5A para Tiras LED', 'Transformador para 5 a 10 metros de tira LED.', 30.00, 90, 2, NULL, '2025-11-06 19:49:24'),
(20, 'Tira LED 220V Luz Cálida (metro)', 'Se conecta directo a 220V, recubierta en silicona, precio por metro.', 15.00, 300, 2, NULL, '2025-11-06 19:49:24'),
(21, 'Panel LED 60x60cm 48W Luz Fría', 'Panel para techo suspendido (baldosa), 4500 lúmenes.', 75.00, 50, 3, NULL, '2025-11-06 19:49:24'),
(22, 'Panel LED Adosable Redondo 18W', 'Para instalar sobrepuesto en techo, luz de día.', 28.00, 90, 3, NULL, '2025-11-06 19:49:24'),
(23, 'Panel LED Adosable Cuadrado 24W', 'Sobrepuesto en techo, luz fría, 30x30cm.', 42.00, 70, 3, NULL, '2025-11-06 19:49:24'),
(24, 'Panel LED Incrustar Redondo 12W', 'Para empotrar en cielo raso, luz cálida.', 22.00, 110, 3, NULL, '2025-11-06 19:49:24'),
(25, 'Panel LED Incrustar Cuadrado 18W', 'Para empotrar en cielo raso, luz fría.', 30.00, 100, 3, NULL, '2025-11-06 19:49:24'),
(26, 'Panel LED 120x30cm 40W Luz Fría', 'Panel rectangular para oficinas.', 89.00, 40, 3, NULL, '2025-11-06 19:49:24'),
(27, 'Panel LED 60x60cm 48W Luz Cálida', 'Panel para techo suspendido, luz confortable.', 75.00, 30, 3, NULL, '2025-11-06 19:49:24'),
(28, 'Panel LED Adosable Redondo 6W', 'Pequeño panel de 12cm diámetro, luz de día.', 16.00, 80, 3, NULL, '2025-11-06 19:49:24'),
(29, 'Kit de Suspensión para Panel', 'Cables de acero para colgar paneles LED.', 19.90, 60, 3, NULL, '2025-11-06 19:49:24'),
(30, 'Panel LED Incrustar Cuadrado 6W', 'Pequeño panel 12x12cm, luz fría.', 15.00, 75, 3, NULL, '2025-11-06 19:49:24'),
(31, 'Reflector LED 10W Luz Fría', 'Uso exterior IP65, 800 lúmenes.', 19.90, 90, 4, NULL, '2025-11-06 19:49:24'),
(32, 'Reflector LED 30W Luz Cálida', 'Uso exterior IP65, ideal para jardines.', 45.00, 60, 4, NULL, '2025-11-06 19:49:24'),
(33, 'Reflector LED 50W Luz Fría', 'Alta potencia, 4500 lúmenes, IP65.', 65.00, 70, 4, NULL, '2025-11-06 19:49:24'),
(34, 'Reflector LED 100W Luz Fría', 'Muy alta potencia, 9000 lúmenes, IP66.', 110.00, 30, 4, NULL, '2025-11-06 19:49:24'),
(35, 'Reflector LED 20W con Sensor', 'Se enciende con el movimiento, luz fría.', 59.00, 40, 4, NULL, '2025-11-06 19:49:24'),
(36, 'Reflector LED RGB 30W', 'Multicolor con control remoto, para eventos.', 75.00, 25, 4, NULL, '2025-11-06 19:49:24'),
(37, 'Reflector LED 10W Luz Verde', 'Luz decorativa verde para árboles.', 35.00, 35, 4, NULL, '2025-11-06 19:49:24'),
(38, 'Reflector LED Solar 50W', 'Con panel solar y batería, luz fría.', 120.00, 20, 4, NULL, '2025-11-06 19:49:24'),
(39, 'Reflector LED 200W Luz Fría', 'Potencia extrema para canchas o estacionamientos.', 230.00, 15, 4, NULL, '2025-11-06 19:49:24'),
(40, 'Reflector LED 20W Luz Fría', 'Modelo slim (delgado), IP65.', 32.00, 80, 4, NULL, '2025-11-06 19:49:24'),
(41, 'Luz de Emergencia 2 Faros LED', 'Autonomía de 3 horas, 100 lúmenes.', 48.00, 60, 5, NULL, '2025-11-06 19:49:24'),
(42, 'Luz de Emergencia 60 LEDs', 'Formato barra, alta luminosidad, 2 intensidades.', 39.00, 80, 5, NULL, '2025-11-06 19:49:24'),
(43, 'Letrero LED \"SALIDA\"', 'Señalética de emergencia iluminada, autónoma.', 65.00, 40, 5, NULL, '2025-11-06 19:49:24'),
(44, 'Luz de Emergencia 3W Incrustar', 'Panel redondo empotrable, batería 2 horas.', 55.00, 30, 5, NULL, '2025-11-06 19:49:24'),
(45, 'Luz de Emergencia 2 Faros Halógenos', 'Modelo tradicional (no LED), mayor alcance.', 40.00, 20, 5, NULL, '2025-11-06 19:49:24'),
(46, 'Batería de Repuesto 6V 4.5A', 'Batería seca para luces de emergencia.', 25.00, 50, 5, NULL, '2025-11-06 19:49:24'),
(47, 'Foco LED Recargable 9W', 'Funciona como foco normal y se enciende al cortar la luz.', 29.90, 70, 5, NULL, '2025-11-06 19:49:24'),
(48, 'Luz de Emergencia 100 LEDs', 'Barra de alta potencia, autonomía 5 horas.', 58.00, 45, 5, NULL, '2025-11-06 19:49:24'),
(49, 'Letrero LED \"ZONA SEGURA\"', 'Señalética de evacuación iluminada.', 65.00, 30, 5, NULL, '2025-11-06 19:49:24'),
(50, 'Luz de Emergencia Portátil Recargable', 'Linterna y luz de emergencia 2 en 1.', 33.00, 60, 5, NULL, '2025-11-06 19:49:24'),
(51, 'Foco Inteligente WiFi RGB 9W', 'Compatible con Alexa y Google Home, E27.', 59.90, 60, 6, NULL, '2025-11-06 19:49:24'),
(52, 'Foco Inteligente WiFi Luz Blanca 10W', 'Controla intensidad y calidez (fría/cálida) desde app.', 45.00, 70, 6, NULL, '2025-11-06 19:49:24'),
(53, 'Tira LED Inteligente WiFi RGB 5m', 'Control por voz y app, adhesiva.', 89.00, 40, 6, NULL, '2025-11-06 19:49:24'),
(54, 'Interruptor Inteligente WiFi 1 Vía', 'Controla cualquier luz desde el celular.', 55.00, 50, 6, NULL, '2025-11-06 19:49:24'),
(55, 'Interruptor Inteligente WiFi 2 Vías', 'Controla dos circuitos de luz desde el celular.', 69.00, 40, 6, NULL, '2025-11-06 19:49:24'),
(56, 'Panel LED 60x60 WiFi RGB+CCT', 'Panel inteligente, todos los colores y temperaturas.', 199.00, 15, 6, NULL, '2025-11-06 19:49:24'),
(57, 'Enchufe Inteligente WiFi', 'Convierte cualquier lámpara en inteligente.', 38.00, 80, 6, NULL, '2025-11-06 19:49:24'),
(58, 'Foco Inteligente Bluetooth 7W', 'Control desde app por Bluetooth, RGB.', 35.00, 55, 6, NULL, '2025-11-06 19:49:24'),
(59, 'Lámpara de Mesa Inteligente WiFi', 'Lámpara velador RGB controlada por voz.', 120.00, 25, 6, NULL, '2025-11-06 19:49:24'),
(60, 'Controlador IR Inteligente WiFi', 'Controla dispositivos (como tiras LED antiguas) con el celular.', 49.00, 35, 6, NULL, '2025-11-06 19:49:24'),
(61, 'Foco Vintage LED G80 4W', 'Globo grande, filamento LED, luz extra cálida (2200K).', 24.00, 70, 7, NULL, '2025-11-06 19:49:24'),
(62, 'Foco Vintage LED ST64 4W', 'Forma de pera, filamento LED, E27, luz ámbar.', 22.00, 80, 7, NULL, '2025-11-06 19:49:24'),
(63, 'Foco Vintage LED A60 4W', 'Forma estándar, filamento cruzado, E27, luz cálida.', 19.00, 90, 7, NULL, '2025-11-06 19:49:24'),
(64, 'Foco Vintage LED G125 6W', 'Globo gigante (12.5cm), filamento, E27.', 39.00, 40, 7, NULL, '2025-11-06 19:49:24'),
(65, 'Foco Vintage LED T30 4W', 'Forma tubular, ideal para lámparas lineales.', 26.00, 50, 7, NULL, '2025-11-06 19:49:24'),
(66, 'Foco Vintage LED Dimerizable ST64 6W', 'Regula la intensidad, E27, luz cálida.', 35.00, 45, 7, NULL, '2025-11-06 19:49:24'),
(67, 'Foco Vintage LED Vela C35 4W', 'Filamento para candelabros, E14, luz cálida.', 18.00, 60, 7, NULL, '2025-11-06 19:49:24'),
(68, 'Foco Vintage LED G95 4W', 'Globo mediano (9.5cm), vidrio ámbar.', 29.00, 55, 7, NULL, '2025-11-06 19:49:24'),
(69, 'Socket Colgante Vintage Cobre', 'Portalámparas E27 color cobre con cable textil.', 30.00, 70, 7, NULL, '2025-11-06 19:49:24'),
(70, 'Foco Vintage LED ST64 4W (Plateado)', 'Vidrio con acabado espejo plateado (media luna).', 28.00, 30, 7, NULL, '2025-11-06 19:49:24'),
(71, 'Kit Focos LED H4 8000 Lúmenes', 'Luz alta y baja, 6500K (luz fría).', 99.00, 50, 8, NULL, '2025-11-06 19:49:24'),
(72, 'Kit Focos LED H7 6000 Lúmenes', 'Luz baja o alta, 6500K.', 85.00, 60, 8, NULL, '2025-11-06 19:49:24'),
(73, 'Foco LED T10 (Ping Pongo) Blanco', 'Luz de posición, interior o placa. Par.', 10.00, 150, 8, NULL, '2025-11-06 19:49:24'),
(74, 'Tira LED 12V Interior Auto RGB', 'Kit de 4 tiras con control y conector cigarrera.', 55.00, 70, 8, NULL, '2025-11-06 19:49:24'),
(75, 'Foco LED C5W (Fusible) 36mm Blanco', 'Luz de salón o placa. Par.', 12.00, 100, 8, NULL, '2025-11-06 19:49:24'),
(76, 'Kit Neblineros LED H11 4000 Lúmenes', 'Luz amarilla (3000K) o blanca (6000K).', 90.00, 40, 8, NULL, '2025-11-06 19:49:24'),
(77, 'Foco LED 1156 (1 contacto) Blanco', 'Luz de retroceso. Par.', 15.00, 80, 8, NULL, '2025-11-06 19:49:24'),
(78, 'Foco LED 1157 (2 contactos) Rojo', 'Luz de freno/posición. Par.', 18.00, 70, 8, NULL, '2025-11-06 19:49:24'),
(79, 'Cinta LED Bicolor (Blanca/Ámbar)', 'Luz de día y direccional (Switchback). 60cm.', 65.00, 30, 8, NULL, '2025-11-06 19:49:24'),
(80, 'Faro Barra LED 18cm (Spot)', 'Luz auxiliar off-road, 12V/24V, 36W.', 79.00, 25, 8, NULL, '2025-11-06 19:49:24'),
(81, 'Dicroico LED GU10 7W Luz Cálida', 'Spot para base GU10 (conexión directa 220V).', 14.00, 120, 9, NULL, '2025-11-06 19:49:24'),
(82, 'Dicroico LED GU10 7W Luz Fría', 'Spot para base GU10 (conexión directa 220V).', 14.00, 130, 9, NULL, '2025-11-06 19:49:24'),
(83, 'Dicroico LED MR16 5W Luz Cálida', 'Spot para base MR16 (requiere transformador 12V).', 12.00, 100, 9, NULL, '2025-11-06 19:49:24'),
(84, 'Dicroico LED GU10 7W Dimerizable', 'Regula la intensidad, luz cálida.', 25.00, 50, 9, NULL, '2025-11-06 19:49:24'),
(85, 'Dicroico LED GU10 5W Luz Verde', 'Luz decorativa color verde.', 19.00, 40, 9, NULL, '2025-11-06 19:49:24'),
(86, 'Zócalo GU10 Cerámico', 'Base para conectar dicroicos GU10.', 3.00, 300, 9, NULL, '2025-11-06 19:49:24'),
(87, 'Zócalo MR16 Cerámico', 'Base para conectar dicroicos MR16.', 2.50, 250, 9, NULL, '2025-11-06 19:49:24'),
(88, 'Spot Fijo Blanco para Dicroico', 'Carcasa empotrable redonda, color blanco.', 9.00, 150, 9, NULL, '2025-11-06 19:49:24'),
(89, 'Spot Dirigible Níquel para Dicroico', 'Carcasa empotrable dirigible, color níquel.', 15.00, 100, 9, NULL, '2025-11-06 19:49:24'),
(90, 'Dicroico LED GU10 RGB 5W', 'Multicolor con control remoto.', 35.00, 45, 9, NULL, '2025-11-06 19:49:24'),
(91, 'Campana LED UFO 100W', 'Luminaria industrial tipo UFO, 10000 lúmenes, IP65.', 180.00, 30, 10, NULL, '2025-11-06 19:49:24'),
(92, 'Campana LED UFO 150W', 'Luminaria industrial, 15000 lúmenes, luz fría.', 260.00, 25, 10, NULL, '2025-11-06 19:49:24'),
(93, 'Campana LED UFO 200W', 'Luminaria industrial, 20000 lúmenes, luz fría.', 350.00, 20, 10, NULL, '2025-11-06 19:49:24'),
(94, 'Luminaria Hermética LED 2x18W', 'Tubo doble LED, 120cm, contra polvo y humedad (IP65).', 85.00, 50, 10, NULL, '2025-11-06 19:49:24'),
(95, 'Tubo LED 18W 120cm (Vidrio)', 'Reemplazo de fluorescente, luz fría.', 12.00, 200, 10, NULL, '2025-11-06 19:49:24'),
(96, 'Tubo LED 18W 120cm (Plástico)', 'Reemplazo de fluorescente, más resistente, luz fría.', 15.00, 180, 10, NULL, '2025-11-06 19:49:24'),
(97, 'Canaleta Doble para Tubo LED', 'Armazón metálico 120cm para 2 tubos LED.', 28.00, 100, 10, NULL, '2025-11-06 19:49:24'),
(98, 'Reflector Industrial 400W', 'Reflector modular para estadios, 40000 lúmenes.', 750.00, 10, 10, NULL, '2025-11-06 19:49:24'),
(99, 'Campana LED Lineal 120W', 'Luminaria lineal para pasillos de almacén.', 210.00, 20, 10, NULL, '2025-11-06 19:49:24'),
(100, 'Luminaria Hermética LED 1x18W', 'Tubo simple LED, 120cm, IP65.', 65.00, 60, 10, NULL, '2025-11-06 19:49:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_empresa` varchar(100) NOT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `foto` longblob DEFAULT NULL,
  `rol` enum('cliente','admin') DEFAULT 'cliente',
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `correo`, `contrasena`, `telefono`, `direccion`, `foto`, `rol`, `fecha_registro`) VALUES
(1, 'Jeferson Jociney ', 'Jaimes Passuni', 'jaimespassunijeferson@gmail.com', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '931976361', 'Avenida los pinos 711', 0xffd8ffe000104a46494600010101012c012c0000ffe100ff45786966000049492a000800000003000e010200b5000000320000001a01050001000000e70000001b01050001000000ef00000000000000557365722070726f66696c652069636f6e2e20417661746172206f7220706572736f6e2069636f6e2e2050726f66696c6520706963747572652c20706f7274726169742073796d626f6c2e2044656661756c7420706f72747261697420696d6167652e20456173696c79206564697461626c65206c696e652069636f6e206f6e2061207472616e73706172656e74206261636b67726f756e642e20566563746f722073746f636b20696c6c757374726174696f6e2e2c010000010000002c01000001000000ffe10626687474703a2f2f6e732e61646f62652e636f6d2f7861702f312e302f003c3f787061636b657420626567696e3d22efbbbf222069643d2257354d304d7043656869487a7265537a4e54637a6b633964223f3e0a3c783a786d706d65746120786d6c6e733a783d2261646f62653a6e733a6d6574612f223e0a093c7264663a52444620786d6c6e733a7264663d22687474703a2f2f7777772e77332e6f72672f313939392f30322f32322d7264662d73796e7461782d6e7323223e0a09093c7264663a4465736372697074696f6e207264663a61626f75743d222220786d6c6e733a70686f746f73686f703d22687474703a2f2f6e732e61646f62652e636f6d2f70686f746f73686f702f312e302f2220786d6c6e733a4970746334786d70436f72653d22687474703a2f2f697074632e6f72672f7374642f4970746334786d70436f72652f312e302f786d6c6e732f22202020786d6c6e733a4765747479496d61676573474946543d22687474703a2f2f786d702e6765747479696d616765732e636f6d2f676966742f312e302f2220786d6c6e733a64633d22687474703a2f2f7075726c2e6f72672f64632f656c656d656e74732f312e312f2220786d6c6e733a706c75733d22687474703a2f2f6e732e757365706c75732e6f72672f6c64662f786d702f312e302f222020786d6c6e733a697074634578743d22687474703a2f2f697074632e6f72672f7374642f4970746334786d704578742f323030382d30322d32392f2220786d6c6e733a786d705269676874733d22687474703a2f2f6e732e61646f62652e636f6d2f7861702f312e302f7269676874732f222070686f746f73686f703a4372656469743d22476574747920496d6167657322204765747479496d61676573474946543a417373657449443d22313439353038383034332220786d705269676874733a57656253746174656d656e743d2268747470733a2f2f7777772e6973746f636b70686f746f2e636f6d2f6c6567616c2f6c6963656e73652d61677265656d656e743f75746d5f6d656469756d3d6f7267616e696326616d703b75746d5f736f757263653d676f6f676c6526616d703b75746d5f63616d706169676e3d6970746375726c2220706c75733a446174614d696e696e673d22687474703a2f2f6e732e757365706c75732e6f72672f6c64662f766f6361622f444d492d50524f484942495445442d455843455054534541524348454e47494e45494e444558494e4722203e0a3c64633a63726561746f723e3c7264663a5365713e3c7264663a6c693e53414e414c52454e4b3c2f7264663a6c693e3c2f7264663a5365713e3c2f64633a63726561746f723e3c64633a6465736372697074696f6e3e3c7264663a416c743e3c7264663a6c6920786d6c3a6c616e673d22782d64656661756c74223e557365722070726f66696c652069636f6e2e20417661746172206f7220706572736f6e2069636f6e2e2050726f66696c6520706963747572652c20706f7274726169742073796d626f6c2e2044656661756c7420706f72747261697420696d6167652e20456173696c79206564697461626c65206c696e652069636f6e206f6e2061207472616e73706172656e74206261636b67726f756e642e20566563746f722073746f636b20696c6c757374726174696f6e2e3c2f7264663a6c693e3c2f7264663a416c743e3c2f64633a6465736372697074696f6e3e0a3c706c75733a4c6963656e736f723e3c7264663a5365713e3c7264663a6c69207264663a7061727365547970653d275265736f75726365273e3c706c75733a4c6963656e736f7255524c3e68747470733a2f2f7777772e6973746f636b70686f746f2e636f6d2f70686f746f2f6c6963656e73652d676d313439353038383034332d3f75746d5f6d656469756d3d6f7267616e696326616d703b75746d5f736f757263653d676f6f676c6526616d703b75746d5f63616d706169676e3d6970746375726c3c2f706c75733a4c6963656e736f7255524c3e3c2f7264663a6c693e3c2f7264663a5365713e3c2f706c75733a4c6963656e736f723e0a09093c2f7264663a4465736372697074696f6e3e0a093c2f7264663a5244463e0a3c2f783a786d706d6574613e0a3c3f787061636b657420656e643d2277223f3e0affed00f650686f746f73686f7020332e30003842494d04040000000000d91c0250000953414e414c52454e4b1c027800b5557365722070726f66696c652069636f6e2e20417661746172206f7220706572736f6e2069636f6e2e2050726f66696c6520706963747572652c20706f7274726169742073796d626f6c2e2044656661756c7420706f72747261697420696d6167652e20456173696c79206564697461626c65206c696e652069636f6e206f6e2061207472616e73706172656e74206261636b67726f756e642e20566563746f722073746f636b20696c6c757374726174696f6e2e1c026e000c476574747920496d6167657300ffdb0043000a07070807060a0808080b0a0a0b0e18100e0d0d0e1d15161118231f2524221f2221262b372f26293429212230413134393b3e3e3e252e4449433c48373d3e3bffc2000b080264026401011100ffc4001a000101010101010100000000000000000000020103040506ffda0008010100000001fd99cf174986f46733a6a2556986f4391748955b399d4e78ba4c37a3399d35127539e2e930de8ce674d44aad30de8722e912ab6733a9cf174986f46733a6a24ea73c5d261bd19cce9a8955a61bd0e45d22556ce67539e2e930de8ce674d449a56a71b4c92c82b538da64964e2b59259056a71b4c92c82b4e674d44aad307539e2e912ab6733a6b9e2e930de8723a6a2556983a9cf174723a6a2556983a9cf1748955b399d35cf174986f4391d3512ab4c1d4e78ba24c1ac1a61a60d30d30d3069869835834c34c1673c5d261bd19cce9a8955a61bd0e45d22556ce67539e2e930de8ce674d449d4e78ba4c37a3399d3512ab4c37a1c8ba44aad9ccea73c5d261bd19cce9a892cc1ac1a61a60d60dc9e7395bbbb6d30d306b069869824e9a8955a60ea73c5d2255bc78f29006f4be9d7a1c8e9a8955a60ea73c5d1c8e9a8955a60ea73c5d2278f2e40000aefe8e9c8e9a8955a60ea73c5d1cca331ba4946628f379e400000eddfa28cc6e925198a1473c5d261bd19cce9ae7c3cf200000077f5e62e930de8ce674d449d4e78ba4c37a3399d363c5c80000001be9ecba4c37a3399d3512742317ac86d9cce9c7c7200000001d7d5d3590db399d099074d44aad30753c7e6000000001d3d7aab4c1d4e78ba391d3512ab4c1d73c9e600000000057b2aad307539e2e8e474d44aad3075f1f9800000000057b3a5a60ea73c5d18415ac96d1e4f300000000002fdc6d1059387439e2e930de8e1e100000000001d3d8de8ce674d449d4e78ba4c37a47cf900000000000efe9de8ce674d4494698349f1f2000000000003ddd70d30d1074d44aad3e6f2800001994000005fd083a9cf174723a6a25569f9d20000670e1cf0bebe8e800003d7d4ea73c5d10003cfe500003cde5c00ebecb000057bf40059cf17498786400033c5c4006fb7b00003d9e9ce674d449d4e78ba4c71f280003c1c8000f7760000bfa2e674d449661a63c5c80003c9e60001bf4680003dfd30d3049d3512adf980001cfe780003b7b80003bfa7a9cf174723a6a255cbc40001e1e200007d1b00015eeea73c5d1ccad4e37c9c000067cc00001e9f580007bfa90569a73c5d27e748000e3e100001d3e800007b6ce9a893a9cf1748f9a0001e6f200000dfa60001e9ee74d449d4e78ba72f9e0001e5f2800007d40000edea3a6a241d09973f18000797ca00001f500003a7d02317a733a6a25c7ca0001c3c400002fe8800057d339e2e8e474d44b879800027e680000efed0000afa673c5d126628f3f900001f3f980001eeec0001bf40a330e873c5d3cde3000070f100002fe880002bdc74d449d4e78ba79fc400007cfe60001eeec0000bf69d351251a61cfc2000047cfc0003d3eb00003afb8c1a41d35127cf00001cfc18001e8f600000edef39e2e8e474d44abe76000009f172006fafd000001e9f61cf17441a60f1720000071f3720577f4d000003dbd8c3451cf1749f279c0000067296df4000001bf4a0e9a893a9cf1749e1e3000000000000076f7733a6a24e84e2b593e09000019ca2231bb77d6c00003d7e982b53861d3512abf1f9800033870e4002bbf7e80001beedea73c5d1c8e9a8955f3f9c000679bcd80001d7d7d0000edea7539e2e8e474d44aade0e2001c7c7200001e8f5e8007b6dd4e78ba073c5d2611e2001e4f3000000bf75801dbdece674d449d4e78ba4c37cbc001e2e0000000df7f4007bfb3399d35127539e2e930ddf9d803c7e70000001bf42c077f5746733a6a24d2b538da64f0f281c3c40000000bfa205fd0496415a733a6a2556987939067cdc00000003d5ea0df7f5983a9cf174723a6a255698679398f279800000006fd2d1ecf4a60ea73c5d1260d60d39f8a4f99800000001ebf49eaf40d30d3059cf174986f46739f1cf2f0000000003a7d07a7d790de8ce674d449d4e78ba4c37a339a7c9e2f2800000001f53d5ead986f46733a6a24b306b069867c7f10000000037eefa35834c34c1274d44aad307539cfccf9e00000003b7daf4c4aad307539e2e8e474d44aad307539e387c8e20000001f43eb5a2556983a9cf1747328cc6e925198a7cef990000001ecfa7da8cc6e925198a1473c5d261bd19cce9a896f87e77100001becfa1ec39e2e930de8ce674d449d4e78ba4c37a3399d3512abcf2f83c9cc001beaf67aadd4e78ba4c37a3399d3512742317ac86d9cce84caa990e7c3871e5199b77d7b7a3d7ae6742317ac86d9cce84c83a6a2556983a9cf1748955b399d35cf174986f4391d3512ab4c1d4e78ba391d3512ab4c1d4e78ba44aad9cce9ae78ba4c37a1c8e9a8955a60ea73c5d1c8e9a8955a60ea73c5d22556ce674d73c5d261bd0e474d44aad307539e2e8c20ad64b6882c9c6d324b20ad4e3699259056b25b44164e1d0e78ba4c37a3399d3512ab4c37a1c8ba44aad9ccea73c5d261bd19cce9a893a9cf174986f46733a6a2556986f4391748955b399d4e78ba4c37a3399d351251a60d30d30d3069869868c34c34c1a61a61a20e9a8955a60ea73c5d22556ce674d73c5d261bd0e474d44aad307539e2e8e474d44aad307539e2e912ab6733a6b9e2e930de8723a6a2556983a9cf174723a6a2556983a9cf1748955b399d35cf174986f4391d3512ab4c1d4e78ba3fffc40026100001040202020203010101000000000001000210110330314012201350042132224114ffda0008010100010502f612646a3224ea12646d12646a3a84991a8c893a84991b44991a8ea12646a3224ea12646d12646a3b4740fd18eb9912750932351912769912750d46449d424c8d46449da6449d43d2952a8b56b954a970ad5c52a54ad5ab54a952e15ab5caa54b856ad5aa54a95ab5714a970ad5ae552a8b56ad52a5516ad72a952e15ab8a54a95ab56a952a5c2b56afdc4991a8c893a84991b44991a8ea12646a3224ea12646d12646a3e96ad5c52a5c2b56b954aa2d5ab54a952b56ad72a952e15ab5caa54a95af20be46af91abe40be50be60be60be66af91a55854b856ae2952a56ad5c52a5c2b56b954aa2d5ab54a952b56ad72a952af73224ea12642240472847295e475daf91cbe541e0a1a8c893a86a3224ea1260e408bc9e982421990707683224ea1e94a9545ab8a5516ae29545ab5714aa2d584eca8927b0dc8426b83952a8b5714aa2d5c52a8b56ae29545ab57ee24c8d453b252249ee372908383bd04991a8ea1264692e0d4e79777c1a4dc97224c8d475093adf93c5137f44d7d2e5093b4ea3224fbbdff4ad716af20e912750d46449f6c993e9c1a4d7794093a86a3224fae4c9f520d169f2024ea1a849f77bfeada7c4dd8d87509322723fc47d635de2606a3a849910e3e209b3f5b8dd0351f4b56ae2952e15ab5caa55169eef23f5ec3e415ab56a952a8b5714a957b9912564750ebd8563b0d7789ff9a46a3224f04d9e99348e608e471567d039c10cc507b4f571bbf5a47a52a54ad5ab5caa54b856ad657751d95124ea6e42d4d70774c1a3caa54ad5ab54a952e15ab57ee24c9367a3c27e4f2da0d263fcba788feb41d424c643fae93dfe477b1fe5d269f17683e96ad5c52a5c2b56b9549e6ddd1cafe88345a7c87458eb6daa54aa2d5c52a55ee642268745eef16f4b1ba9dd1c67f7ee35190b29ff003d1ca6ddd361f26f401a3ee35190b29ff5d03fa1d4c27a4dfd8e80929dfd7432ff001d4c7fa7f4717f1ec7509771d1cdc75073d1c3ee7509c9fc74737d3e2fefd8ea3393f8e8e6fa767f7ec3519c9fcf472ff3d467eddd16ff005ec3519cbc745c2dbd4c43fd74473ec3d2952a8b5714a966e3a4f14ee9e214de88e6d5ab8a5516ad5fb89cdc74b2b6c749a3c9dd21cfb1d42737f3d37b7c4f471b7c4749bfd7b1f4b56ae2952e15ab593f6ce9b9be408a3bf1b3a98ffba54a95ab56b954a957b993fcf51ccf2041076b31df5717f5ec351908f3d4734393985baead331575b17b8f4a54aa2d5ae552a5c2c9fdf59d881471b87b804a1850681d7c63fcdab56a952a5c2b56afdc49597b2402be26af842f842f89abc1a3b5ff003d8ea1253c5b7edb18b7fb9dd488a3d4ba472b57ccbe62be572f91cbe472f91cbe572f997cc107b4f5b171d1322330fdf478472847238ed0e210cc507b5dd30287b8d46443879377f09d95124f49b9084d78774318fde81a8c89c8da76d7640d45c5dd66e5a40dee68a6e81a8499737c86c7e4ecb5c5a9ae0ed98db6ed27509321656d1d4fc97db068b1fe4353056a3a849909c3c811474647df741a2d7790d18da86a3d2c8dbd191f43bcd7789f76b7c8d0ea991265edaf62681367bf89deec6f884750d464499e539be27d333be847e88363d3136a4ea1e94a9545ab5caa54b856ae2952a4eff408a324d9fa1c27f538f1ae15ab8a54a95ab56a952a5c2b56afdc4991eae6f9022a321a67d16334f8c78ee0c8d47509323d8b7c91696acdf4b8f1c991a8fa5ab5714a970ad5ae552a8b56ad52a548d11f90c20fd101671e2a6f0ad5ae552a8b56ad52a54ad5ab5caa54abdcc893a39597f1be871e276438b0b71046449d43519127564c0dc83262763ef63fc6b4d00083224ea1e94a9545ab8a5516ae29545ab5714aa3f4564fc505398e61ece3fc67bd330b71aa8b5714aa2d5c52a8b56ae29545ab57ee24c8d4668383ff001014fc4f6756ad33f19ce4cc2c67b8932351d424c8d4644bff001f1b93bf15c9d8dedde0129bf8d91c9bf88d09ad6b748932351d424ed3224c9c4c723f898ca3f8651fc5c8be1c817c6f5e2e5e2e5e0e5f1645ff009f2a1f88f43f1026fe3e3080036093b4ea3224ea12646a3224ed3224ea1a8c893a84991a8c893b4c893a86a3224ea12646a3224ed3224ea1a849e80e8191b449da750932351912750932368932351d424c8d46449d424c8da24c8d47d2d5ab8a54b856ad72a9545ab56a952a56ad5c52a5c2b5714aa2d5ab54a9545ab5caa54b856ae2952a56ad5c52a5c2b56b954aa2d5ab54a952b56ae2952af73224ea12646a3224ed3224ea1a8c893a84991a8c893b4c893a86a3224ea12646a3224ed3224ea1e9ffc40029100000050204050501000000000000000000011121503140023060611022325171122041819190ffda0008010100063f02fe6bd78d0505385454b403986e15cca872d1ec1c34ab5cf7926bd770d1af00c1e2f70fa2d0a19a190b462168c428c5280df462858e4d54971515d10e1bdd50f6c974968c1f2db406d9dbd9a45ed61bd92c57a6c542c42c2f9b24b64b2f1a84cac8ad4e18a60a1ce18b4694394d9591431daac3143f9862b35ed66966535bd995a1da204b0f51da15a1db3e729cfbe6a9e82ed90c41c3462dcb970a98af0a6bd4b7a71a8a8af0a70adb2dbad9b3e731878b4b1e50f65de2bce76e1ed9c34a261b96885ef96854bb68740992857ab94b7ab9090e90aa1603d318904bed53814f6ac127b14f4629c3942a9c3a185f8834205eaac52e0fc8161bf78cec7dc397ddf2e3fc0851ce1701a6c398ae9d88317dc921928e4340e56ac3998313cbd13c0e5350f84f3d8513c8e6350c4938f848319906c643e0fec7418e83fc1d262863a4ff0007418e90e81f10e95f21893fa45fffc40029100002020201050003010100020300000001110031102021404151617130508191a1b1f1d1e1f0ffda0008010100013f21c9bcd365b7159b6da645ef4d96c9adcde69b2db8acdb7379a6cb6e2b36db4c8bde9b2d935b9bcd365b7159b6e6f34d96dc566db69917bd365b26b7379a6cb6e2b36d198cc6601c442210f15198cce57108843c08cc6633108844233198cc1c8e621109c2a33198393cc4221108cc66331088442128c66330737108843c546633016621108846633198031108843c546633395c4221084233198cc4221108cc6633072398844221a0acdb6537379a6db64d6f6d94c8bdc566db29b9bcd37159b6ca6e6f34db6c9adedb29917b8acdb6537379a68912246b88d1b048983468df112260d1a34e51224748d1a7b448915a3469ca24489834689f312260d1b048912e63468d122448d711a360913068d1be2244c1a3469ca2448e91a346d0de69b2db8acdb6d322f7a6cb64d6e6f34d96dc566db9bcd365b7159b6da645ef4d96c9adcde69b2db8acdb709f3f84012e770386456d80e9938604170820f90ff93d667b10005a7b13d067a480b52fad037c6e027cfe1004b9dc0e1915b702b36d94dcde69b6d294103a130ba4212d97e3042891003cbec1ff00d09dc97d96dc566db29b9bcd37159b6ca6e6f34d24ab805733bb2f9d1da94376bf92f9fcd4566db29b9bcd3468d1a302244879a8d1a0e2e24484b08468d118912244634680ab890883260a87fb2d4f516fc3dca4bf11a340544890f351a341c5c489096108d1a231224488c68d071712244d0de69b2db8acda0387230af27ace278208650de69b2db8acdb7379a6cb6e2b0219439e075e42648c070e2734d96dc566db9bcd360bdc540701cc10d93fd11f89e4404031cca6c17b8acdb7159b6ca6fca7fd7f4a778af1000f629b9bcd37159b6ca6ccf1f73fa739b1000c6aa6e6f34dc566db29ab3c7dcfea48e102c1a29b9bcd3442211086e33199c844221384663305c42211435df7f5656080470663305c422114663319807110884e0633198ce86f34d96cf002dfadf912f16dc566db9bcd365b01294218bbfeb91cff0098b6e2b36d1a34689f312243e11a341e5122421731a7cc1fb01fbc5c21731a34689122464468d007c989122682b36d949c02cf508ecff67adfec60f7e9d49ff612d86e6f34dc566db0d1931d1e9000c9412ae7765f21259274a43805019df51f07a5719f6adcde69a7dcfb9f738713e67ccf29f73ef0f99f33857fbd20871ccf984593fc5c15881197f3a34060000106e7de1f33e67cce5ccfb9f71d27ccf99f3a1bcd3512838e8f4448064f109c071f944260a307c0f1d19e47db6159b6e6f34d485f3d1128330dea7e705162288d3a259b0566da2448913e634683ca24487c23473eb8e8985285f42400588108744a5d8e22468d1a302244843e4468d1b4159b6877e1d1303dfb747c51ae89ccf2d4de69b8acdb4283c8f45c276e9094ff00bd0a93a9bcd3446231182a31189c8c462338472f81d0930f884b2fa4e4fe9d11b5188c46211cc4623070231188c686f34d04c9efa1245efa52e881b21e0e82b36dcde69924dd11707be94901f7d11721eb4159b6e6f34c922fdce4be8682b36dc566d92e5d157a50be8b87d34379a6e2b36cd5f7a216fe0f4a097be8bfe8d0de69b8acdb347de8953d74aef40e8abfba1bcd3448912124468d0737122405f4e8df8e9395e8947d8d1a3442244878a8d1a3686f34cffd5d1f02be8cb3fd747ff7682b36dcde699a7ef49f3cd745ca9b747cfeda0acdb709f3b03f81d201a8773a07f83b750070c8adb8159b64187d74a2f77631683f37a8f8f3d285bd686f34dc566da0110f1d280413de0f3f8c11201980ee4f8e982ce86f34d1a3468d7112260d1b0045efa7e4c729da58f5bda861bbd7a104a05d3a44ff0062448939468d1d224489a1bcd3405752a40c25ecb09ec41ee30541ea40654012781a0acdb7379a6863ebf6ea3d73a8acdb462311884331188c1c5c62310f351bc477e1d290b10203ddfc847b49ec8027b7fe68de1eb3fc80bb8c05b044a01e984032ef1888c4623188c4621e4f11188c474159b6ae179f4448064a83d23ba2f90977f92cc104abf92a0f3e0f44392a201e35379a6e2b36d4f3a0120192a7643fa61564fa2f4ef729b83e3a06bf8d8de69b8acdb6735dbf33881cc1865d31b8731000c98fccb877d8de69b9bcd36713dfb7e5ff00e53a928ffc41bc5f8fc9cd9a1b8acdb7379a6cb4e1d5f8dffea1f564717301eeee3f1a606e2b36dcde69b2d0252842158fc2f76bbf5a452e09e3fbf8585ff92db8acdb46633198031108843c5466330737108842108cc416c7e0e2967af33fb77808218dcc97f60104042108cc6633108844233198cc1c8e6211088682b36d94cbec51d8462ed0862eff00a0efbf9b00494270fdfbe29b9bcd37159b6ca648008c3afb76d7900ff7f424404768ac3bebed19a6e6f34d122448d711a360913068d1be2244c00310ea3925071df97e8b95e3a33fe63068d1be2244c1a3469ca2448e91a346d0de69b2da810610d1c38f7c7e8d07be33e87d86ab6e2b36dcde69b2db08118611874fd1828b839119ff008f65b7159b6e13e7f08025cee00a440f46b7fa32080c9ed0c6762b7012e770386456dc0acdb65373708008860c207ce22bf408c3c773d84e11cf7962db29b9bcd37159b6ca6e6f2ddfc50bf6bc2bad009280661fb110160000f19b6ca6e6f34d1a3468c089121e6a346838b891212c211a344624489118d1a02ae142e40f99749e5510083aae483ed0477bcae340544890f351a341c5c489096108d1a231224488c68d071712244d0de69b2db8acdb2e020f739e63c1a96faf3dba50448093ea72dc3ff67793c8e86f34d96dc566db9bcd365b7159b6d12f9bcc054fa1e250cfce410127d4f15c04673f0388150fe36379a6cb6e2b36dcde69b05ee2b36d94c98ffc69ff009809dd4fa20343e1066086e2ff00d44ffd146cc0d5fe301bc7e984d827751f821fe6006801eb06b7379a6c17b8acdb7159b6ca6e6f34db6c9adedb29917b8acdb6537379a6e2b36d94dcde69b6d935bdb65322f7159b6ca6e6f34dc566db29b9bcd36db26b7b6ca645ee2b36d94dcde69a211088437198cce4221109c2331982e21108a33198cc038884421e0c6633395c42210f02331980f3108844238cc660a88442708cc667231088435198cc66211088437198cce4221109c2331982e21108a33198cc03888442703198cc674379a6cb6e2b36db4c8bde9b2d935b9bcd365b7159b6e6f34d96dc566db69917bd365b26b7379a6cb6e2b36d1a34689f312243e11a341e512244b98d1a3448912308d1a00f9312243e11a3405f062448808d1a344891235c468d07944890f8468d1be2244891a34689f312243e11a341e512244b98d1a3448912308d1a00f9312244d0566db29b9bcd36db26b7b6ca645ee2b36d94dcde69b8acdb6537379a6db64d6f6d94c8bdc566db29b9bcd37159b6ca6e6f34db6c9adedb29917b8acdb6537379a69fffda00080101000000100c39e1ce1e70e1873c3861cf0e70f3870c39e1c30e7873879c3861cf0e2492208200020412440e1cf0e70f3861c39e1c70e7873879c30e1cf0e049200900012009240101873c39c3ce1c30e7870c39e1ce1e70e1873c38f3c71e787d471e78e3f873c39c7ffc870e7871c39e1cafff00fdb873c38fff007ed5ff00ff00ff00ff00efdb861cf1bfff00ff00fec39e1c30e79fff00ff00ff00fe1cf0ff00b7fd7fff00ff00ff00f6fbb7e1cf1fff00ff00ff00ff0079e1c70e7bff00ff00ff00ff00fccf0e3873dfff00ff00ff00ff00f278702001ff00ff00ff00ff00ff00c00000c39fff00ff00ff00ff00ff0033c3861d7fff00ff00ff00ff00ff009e1c39dfff00ff00ff00ff00ff00f870fc39ff00ff00ff005fff00ff00dc38e1c3ff00ff00905fff00fee1c7ff00ff00ff00f600ff00ff00f7ff00c309ff00ff008001ff00ff00cf0e187fff00f0000fff00ff00f87e1cff00ff0080000fff00fa1c70efff00fc0000ff00ff00d0e3877fff00e00001ff00ff0087020fff00fd00001fff00f8400c3fff00f00000ff00ff00dc3861ff00ff00800003ff00ff00e1c30fff00f800000fff00ff000fdb7fff00e00001ff00ff00bbfe1fff00fe000007ff00fe1c70ff00ff00f000007fff00e0e3b7ff00ff00c00001ff00ff00fee18fff00fe00000fff00fb870c7fff00f40001ff00ff00dc3f1dff00ff00f0000fff00fe1e386fff00ff00c0007fff00f871c37fff00fc000fff00ff00c38025ff00ff00f801ff00ff00fe00060fff00ff00f6dfff00ff00de1c30ff00ff00ff00ff00ff00ff00fef0e001ff00ff00f9d5ff00ff00f840e1dfff00ff00800bff00ff0021c70eff00ff00e0000bff00fb0e3873ff00fc00000fff00d870387fff008000001ffc7870c3ff00e80000017fe3c3861fff0080000007ff009e1c492ff000000017f4881c39ff00400000003ebc38e1cf7c00000000f1e1c09245a0000000074802030e640000000075cf0e187390000000024e7871e78e0000000004f1c7f0e787000000009cf0e3873c3c00000038e7871ffefd80000001ff00dfb70c39e1a0000001873c3861cf0eb0000f0c39e1ff006ffb7fa6d2bfedf76fc39e1ce1e70c3873c38e1cf0e70f3861c39e1c70e7873879c30e1cf0e040000104090408000001873c39c3ce1c30e7870c39e1ce1e70e1873c3873870e70e1870e70e1f873c39c3ce1870e7871c39e1ce1e70c3873c38e1cf0e70f3861c39e1c7fffc4002a1000010303040201050101010100000000010011311021612041517140b130508191a1f0c1d1e1f1ffda0008010100013f10acf5f75622b0d4c1d1075abddab83bd064d61acc57d559f5cf5f75622b0d4c1d1075f173d7dd588ac35307441d6af76ae0ef4193586b315f5567d73d7dd588ac35307441d7c5cf5f75622b0d4c1d1075abddab83bd064d61acc57d559f5cf5f75622b0d4c1d1075afcc5662b3140204872b105882324d60598acc55d325882c410821018acc5662818cac41620b104404806cb31598a10e0395882c414307598acc519609c2c416208801205c2cc5662b3140c21620b1046200582cc5662ad992c41620840bd85662b31440025c2c41620b10598acc566280024395882c411926b02cc5662ae992c416208442031598acc503195882c41620880900d9662b31421c072b105882c434475f55666b2d448d1277abd9ab93ad020565ac4d7dd58f5c75f55666b2d448d1277f171d7d5599acb5123449deaf66ae4eb4081596b135f7563d71d7d5599acb5123449debf31598acc513363305882c4100c73fa598acc51131bf2b105882066e82b31598a68bb95882c41620800397bacc56628913232b1058821f8b8598acc510064e5620b1040898b5d662b31598a78b305882c41011749598acc51311bf2b10588205cc7f4b31598a222c90b105882c41662b31598a266c80b105882018e7f4b31598a22637e5620b1040cdd05662b314c177365882c41620800397bacc56628913232b105882c4344f5f75622b0d4c1d1075abddab83bd064d61acc57d559f5cf5f75622b0d4c1d1075f173d7dd588ac35307441d6af76ae0ef4193586b315f5567d73d7dd588ac35307441d6bdbc14de0a6f05139a53f909fc840c4dd37829bc144c45993f909fc84271764de0a6f0534d9a53f909fc84fe42658d09bc14de0a302c9fc84fe421ceee9bc14de0a302c9fc84fe4275cf09bc152803b2a583ed7409b1ba43b45fb0a0000fdc86ff00eb40921fb2248fd80a935f741e1c01404cdd37829bc14d8a53f909fc84fe426f0537829bc14fb4653f909fc840c4dd37829bc144c45993f909fc84271764de0a6f0534d9a53f909fc84fe42658d09bc14de0a302c9fc84fe427f234475f55666b2d448d1277abd9a30cfd8156e23f80859001e9ca991f7f8c9bf58590262c60e8dfe84b96b8b11020417d71d7d5599acb5123449dfc5c75f55666b2d448d1277abd8800e400e4ab7893fc050ccf1622492e4b9f08b39501b0439b0a8e5f958e98ebeaaccd65a891a24ef5f8160581000026e1645910937b82c0b029cd8eb22c880f0e4ac0b02022ecb22c8b2226248162b02c0802d61591308803728a374dba110731f1e2e13302c12fcab113724ac0b0200004dc2c8b22126f7058160539b1d6459101e1c9581604045d9645916444c4902c5605811016b0ac8b22c9a27afbab11586a60e883ad1b9765b04f031c71e6317faa15ea391b853d7dd588ac35307441d7c5cf5f75622b0d4c1d10754b54703728e80eb1bf7e783980dc22b609bec6beeac4561a983a20eb5ee3909c72138e42124ec98f0531e0ab2eb5d38e4271c85780d74c78298f050902e9c72138e422434a63c14c78298f051065f640cb7c5b0ed1e9847e84c0ffed0844ec3b8565d6ba71c84e390af01ae98f0531e0a1205d38e4271c84486374c78298f0531e0a20cbec9c72138e42bacba63c14c78298f074475f55666b2d448d0d90bbdff00e112e5cfd11d26e52505091b6b8dc5666b2d448d1277f171d7d5599acb5122b765e00dfe8e0a763ed41422471499acb5123449dfc5c75f55666b2d448a3d26c0df1f491c3b11fb5ba0dc70a66b2d448d1277afc01600b00444100480b21590a0b86fdac01600ac06b74b21590a324012e1600b00441a0219c87dcffafa584dee41dc224363fa590ac8519200970b00580220c6c1642b21590a0102405802c0111601618590ac85643a27afbab11586a07bb16c0e512e5cfd30f72e723fd4080041706290d4c1d1075f173d7dd588ac34d90207251c9725f4e74ed8cbfca435307441d7c5d4041d26b4449a15a286cad0059216608ad83b4339fa7c170af5e2ff00a401648ad385b4544c6102b401dcd75475f55666b2ab81cb81e41980ed1eff009908007a3e3986c4072101d1c10e0d448d1277f171d7d5599a80c1800e514aeffaf118c03925580a7c9b05c27c032fd8e17a824416508704bab50de458ab68fb43c57457bba5448d1277affe197f0cbf865c2765fc3afe1d362d97f0cbf864d3975fc3afe1d3c369efe18960e53eb7c8809d04b3f13611c6765271b948f0cc36414f9400e17f0cadbbc2fe1d7f0ebf875c89bafe197f0cb80ebf875fc3afe1f44f5f7562280215800e510aee7c2391804928d97f8373dfca0e7037082db06dcf5e1be2bdc3aa183a20ebe2e7afbab1146f19f5f08062301724a6407100e73f390042088210e364ce7c2e26763d29460e883af8ba899320d688034ab44c6d949a1b5af0af4f2393c7824458965be848e0f84376dc272da2a0231915a21ec6baa3afaab329e6d8e89249264f82d64add912497327c2be5b5d1dbc268cd8e1091a24efe2e3afaab329b49fd43c2b7cec7df7f11f398ede0e2f374246893bd7e02b01580a200012015902c8105c17e9602b01570bdbb4cc05c7830cec0128842925cf88d9bb8678446537172b205902c81109100ac056028c304b1cac81640b20d13d7dd5885963c133b901e2bab92df9f0b281a20ebe2e7afbaaf3c013e177623e2e2603e133cf77f7e7441d7c5cf5f755e386f0bfd3fcf1448420782c03906883ad7b9e539e539e5086a61c261c2b6ce139e539e5300e481e105dc91e28b88e4f846e7a261c261c261c222ebee9cf29cf2aebd30e130e130e34475f554ed73fe0f84dbc03e2f4b0f844c7c7de893bf8b8ebeaf15b914d9df8afbb3f71f0bf45ef449debf02c0b022040360b22c8840bdc5605810190f0d63ac4b8e8f88c642e4ff006dbc2fd32c8b22c88180245cac0b02226d605916459344f5f7546f7f2de1daee4ebc33ed13d1000000580f081c587bd1075f173d7dd507271e188043182885006f17f9e15b0dd38c7862c70d1075af7f013f809fc04d9a537929bc944c45d3f809fc04eb6d87f7e21b7d83c144e1623f7e03c01b2077cf880f89fd26f2537929bc94eb1a13f809fc04245937929bc94de4e88ebeaae4c3f15ac6c28226847efe6398136d400006161e2387c3424efe2e3afaaa2ee0f09c9dc478b71ce0ee11725b1bfdf8c50a26c13033b1b078d6b9c81a24ef5f982cc1660808b9dc2c4562288738fdacc16608099df8402445de3b87d923f0aeddeb910416218ea2cdd0046316df71318fb1f1c9cf2622b11588a244e1aeb305982000e9c2c45622b11d13d7dd588577ed1f27f6601441f428ed83f0bfbc20e4f715bd0cdd00006018790400492c100630c6883af8b9ebeeac42cc2e1f577f18bc8c1d1075afccb32cc88420382b12c48c0b585665995b1244818c91896ef14538cc965026782de47b289f4ce89768e8113eefc0595f808079fd82027ef20733a2cbfed72dcc706de31d6b9b0e82260ceb12c4b1200001370b32cc84b80e16258962d11d7d5599a3010b031efc26e20e495653173015ac37c58884e449e4fc9f8c07b2b00439b0ab60c740f84040124b0421bb19091a24efe2e3afaab334e76671da82c7e7380806e50c3b8fe213c0967c26304e0ffa5692caf02f78f7a091a24efe2e3afaab3357901b83bdfe679e886ddabf470361e2c26b7f9b7081c426e3e67805d734123449dfc4cf5f75622ae010bf6f90960e51cb9adbff00ca9f21c65b72829d26c12523e46006e9ef6a983a20ebe2e7afbab11585586ff23f1120024960118c9d824f961c680b830fc400490007250b7d93dd4c1d1075f173d7dd588ac2b74083c1404588c7e1703db21bf9a3856041968ece0fc3682c3f650d4c1d1075afccb32cc80024392b12c48c9b581665995f32589624021018acc8d300be47c178eddcf03cf181b95839080c8e08707581c125c04260000304021018accb32062ceb12c4b1220240360b32cc84380e56258962d11d7d5599acb5b0ff00e47542403a39372fa0485cff00cea02039258042dc1dca92d448d1277f171d7d5599acb5281b83628c0ee52e469709585ffc7d04a131270830007d30abc5871596a246893bd7e62b31598a266c660b105882018e7f4b31598a22637e5620b1040cdd05662b314d17728ac23078289077e79a80850039442524ff004270a3c875a1a0130fe0a22637e5620b1040cdd05662b314c177365882c41620800397bacc56628913232b105882c4344f5f75622b0d4c1a410220f08f46c47ee8d213f439efb5cfbd6c0191bd222b0d4c1d1075f173d7dd588ac35306bbd4d8f09a2cc1d8ab3de4fd0c800905d13046e1d5906db1ff00b588ac35307441d6bdbc26f09bc27cd29fca7f28189ba6f09bc22622cc9fca7f2b7c5d93784de134d9a53f94fe53f9440f47a4ff0056007639fa19209cc003929911a1c8028189ba6f09bc22622cc9fca7f2b7c5d93784de134d9a53f94fe53f94cb1a13784de118164fe53f94fe74475f55666b2d448d12768e46018821c14da8c8778eb94412208208907e8113e9516a5e1617fb7029eaaccd65a891a24efe2e3afaab33596a246893ba9118e304f6374d778e2e179a04512c000e4a6e7a6006e7be1099b580357d5599acb5123449debf02c0b0200004dc2c8b22126f705816057c9b1d6459101e1c9581604045d9645916444c4902c560581005ac29fc42c0807053b85f7874764f0ae60f47c994caf3dc6e7a0a70efb84b0200004dc2c8b22126f7058160539b1d6459101e1cac0b02022ecb22c8b2226248162b02c0880b5856459164d13d7dd588ac35307441d6adf00c8074fc7777f948464b6e1bfe5e28b9aa00394d4419eff82672c59cff00e689ebeeac4561a983a20ebe2e7afbab11586a60e883ad5eea1008621c23460f83f509f489ec274601bb38fcfcee22b607299c9026e4dfa94de0303fea642b09d53d7dd588ac35307441d6bdc72138e4271c84249d931e0a63c1565d6ba71c84e390af01ae98f0531e0a1205d38e4271c8448694c78298f0531e0a20cbec9c72138e42badba63c14c782ad77b271c84e390aeb6e98f0531e15dc1e4d87f215f8de1c3f685fd843feafd3a1feb29e2741fd2843f722390fdebffb542313a25eed185bdba03fd504fd927d21bf0cd272381b913ff8b1a50004e3908c136298f0531e0a63c14e3909c72138e42124ec98f0531e0ab2eb5d38e4271c85780d74c78298f050902e9c72138e422431ba63c14c78298f051065f64e3909c7215d65d31e0a63c14c783a23afaab33596a246893bd5ecd5c9d68102b2d626beeac7ae3afaab33596a246893bf8b8ebeaaccd65a891a24ef57b357275a040acb589afbab1eb8ebeaaccd65a891a24efe2e3afaab33596a246893bd5ecd5c9d68102b2d626beeac7ae3afaab33596a246893bd7e00b00580222080240590ac8505c37ed600b0056035ba590ac8519200970b00580220d01642b21590a0102405802c0119601618590ac85492ed600b00421c018e1642b214420092b005802c01127372b21590a104090e5600b0057035ba590ac8515837ed600b0040011018ac85642b215802c01600888200901642b214170dfb5802c01580d6e9642b214648025c2c016008831b0590ac856428040901600b00445805861642b21590e89ebeeac4561a983a20eb57bb57077a0c9ac3598afaab3eb9ebeeac4561a983a20ebe2e7afbab11586a60e883ad5eed5c1de8326b0d662beaacfae7afbab11586a60e883ad7f52ea5d48083a4d6889341752ea450d95a202c90ba975270b68a890c202ea5d4803b95afc85d4ba910f62b4447121752ea5d49cbd6891b202ea5d4818fb2b4001e4ba9752064e83a28ea5d4ba9010749ad112682ea5d48a1b2b4405921752ea4e5b454486101752ea401dcd75475f55666b2d448d1277abd9ab93ad020565ac4d7dd58f5c75f55666b2d448d1277f171d7d5599acb5123449deaf66ae4eb4081596b135f7563d71d7d5599acb5123449dfc5c75f55666b2d448d1277abd9ab93ad020565ac4d7dd58f5c75f55666b2d448d1277afffd9, 'cliente', '2025-11-06 19:46:30'),
(2, 'Jeferson Jociney', 'Jaimes Passuni', 'jefersonjaimes1623@gmail.com', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '931976361', 'Avenida los pinos 711', NULL, 'admin', '2025-11-06 19:52:03'),
(3, 'Jeferson Jociney ', 'Jaimes Passuni', 'duduphudu@gmail.com', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '931976361', 'Avenida los pinos 711', 0xffd8ffe000104a46494600010100000100010000ffdb0043000c08090a09070c0a090a0d0c0c0e111d131110101123191b151d2a252c2b292528282e3442382e313f3228283a4e3a3f44474a4b4a2d37515751485642494a47ffdb0043010c0d0d110f1122131322473028304747474747474747474747474747474747474747474747474747474747474747474747474747474747474747474747474747ffc200110801cc01cc03011100021101031101ffc4001b00010002030101000000000000000000000001060204050307ffc400160101010100000000000000000000000000000102ffda000c03010002100310000000faa800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020820f33c4c093dcf624900000000000000000000000000000000004189cf386728d23000c8dc3b477cdb24900000000000000000000000000000020c0e1595b344804800800ccb096997d89000000000000000000000000000008394536cd304800000000db2ef9bd0a900000000000000000000000000020e314722c000000000020f596f075890000000000000000000000000083513e7ba9e5280000000000041e85ee5ea120000000000000000000000000c4a459c4b265000000000000107bcbf433649000000000000000000000000344f9dd98d932800000000000010764bccb90000000000000000000000001532af64d8940000000000002c105f65eb4b20000000000000000000000189f3c342c9b128000000000000022cee4b77964000000000000000000000106b1f36162c4a0000000000000059e92fd2a5f500000000000000000000000e314459b9589400000000000000b3197e892f4400000000000000000000002b2951269625000000000000002c896f12f70000000000000000000000029f657000000000000000001644b7296c4000000000000000000000014fb2b6480000000000000001644b7597be000000000000000000000082bd653491625000000000000002cc65fa24bd100000000000000000000000d28f9c8d4589400000000000000b3de5fa3cbea0000000000000000000000181f3e39f64d89400000000000001165865b94b2000000000000000000000002b2546c9b128000000000000031b3e839bd3590000000000000000000000082b054ec9b12800000000000003dacfa3e6faac80000000000000000000000414438f64d89400000000000001165ce5b04b200000000000000000000001051ce2593625000000000000004596e96cb2c800000000000000000000000a695db26c4a000000000000008b2eb2f7a59000000000000000000000001572a962c4a000000000000008b3e819bd359000000000000000000000001c728764d89400000000000001367d2737654000000000000000000000003ccf9dd9a648b12800000000001644bb87d16335000000000000000000000000839450c8b1625000000000000896df16426800000000000000000000000041522b24d800000000000107725ba991200000000000000000000000008358f9c18d80000000000083d8fa24bb24800000000000000000000000000829857ec120000000002c82d52da65900000000000000000000000000020d13e7764120000000000f53e8e7bca0000000000000000000000000002082916710900000000020eb4d5f52400000000000000000000000000000556caa920000000000edcd5dd240000000000000000000000000000053acae120000000000b14d5c1240000000000000000000000000000313e7b668000000000020b5cb682400000000000000000000000000003029d55f49000000000225b396b32000000000000000000000000000041e319944ae513600000004b91683b841bc00000000000000000000000000062724da8de35ea84686b322500010989d69ab89bc0e11d636000000000000000000000000003134eca09de2db05d728b6738900007a45a8b12e40f33e76748ba19120000000000000000000004006b9c12b367859ed1f4697dd47915138164004a75a5b82ee02482b654016f2c6492000000000000000000403039e728e41cd31164d9117396c0b20c4e3594f358f62da9de97259041e47ce4d72492e2770f4240000000000000001060725383a9c997c41200013a92df964031398504bd1d900020acd952b265020f73ac76e5ea1ee480000000000080699c238269d93625000001265fa32ed920f13e7a699d03e8264480789f38b3c2c99401004be874cec9d8368924000000820f138c706ce61882400000004896dcb652482a3656802f276a59201592a5612540000100937ced9d99774c812010799c9382720f327590025000000044bd15bf991ce3e7facc007425fa04b903c8f9c9e1610a000160100012efcbd93ba6e920a7d9c33c25916000000000000251f45374a59c0b24031b2fb2f5e515c4a793400000000000440ae89623b91f30d4912858128000000000589712d45aa5e014bb04832b3e899bb8b89f3bb9d30a00000000000205083d0c250000000000000001166f4bf43960a0eb3cd25475e4bdca5d03e77648000000000000001048000000000000000045932fd0a5e81cb4a0d082d696894b5e29b648000000000000000000000000000000000b225b34b6d303e6660909712c4a5a41c4b00000000000000000000000000000000002c8976e5fa31e07cd8212d45a1705f9b9e160000000000000000000000000000000000589625bf8b2815303ba9759796b4026c0000000000000000000000000000000000b2254b613a9652aa606e27d125a92d6c9b0000000000000000000000000000000000003dcef15924107d14a21aa48000000000000000000000000000000000000374d124189642ba0000000000000000000fffc400341000020201030205030205030500000000010203040005061131411013214050122030145122346171812432522363707292ffda0008010100013f00ff00c90481d4f18d6a05e7995461d56929e0cc30eb147a79b8babd1278130c4b75dba4c870104723e459820e490077272deb94aaf21e4072d6eb73ca578727d66f4fc8798818f2c92312cec4e7ae7f93e0ace8794761fd89cafad5e80f026ca5bac97fa2d2653d4aadc5e62947c6c92a4485e46083350dd15e1e52b7f1be5dd62edc27eb94a8ce49f5725bfb9e707e0232296485c3c6e54e695b99e2e22bbfe1f2b588acc61e270e0fc56adad41a7211c8797b2e5ed4edde6264721307e5ec7be69da9d8a13064724775cd2b5487508b943c37c46bfac250ae510f331c96592693eb979766f6352c4b564f32162846689ac47a842039e261f0da8dc4a54de57396ad4972cbcd2f527d9d5b125698490b152b9a1eaa9a8d6ffbabf084e6e8d47f536cd743c2a60f6946e4946c896327804739a7dd4bd584a9f07ab5a1528492e48ed2c8f237ab31c1ed00cdb5a9b53b7e4b9e637c5208e47c16f1b7ea95707b60595c32f5cdbb785cd397b94c1f004f00939add833eab29ecb83dbed3b660be616e8707c05f93caa533fecb8ec6495dcf527dc5397cab9149cf01581cace25811c742bf01b9e631692f83dc1cd0a5f374b8be03794bc5548b07b9da8ff5e95f01bd24ff00530a7bad9879d31fff007f80de719fd442f83dcecf52ba61f80de1017a01f17dc3724103ae68708834b8bfa8f80d56b8b1a7cb19c65fa5ca9ea0fb8d3a1363508a3ec587390c62389517a003e0080508cd7aa9a9aa483b37aae0f6dd8e6d0a65ecbd93f05bc29092b8b43aa62fb60393c01cf2736fd31534d41dd87c16edbe6302a277c5f6d41a38efc2f37aa06cad2a4b5d648f8fa48f4f82dd479d4db07b7d9f33cb41d1cf210fc16ee50ba960f6fb2ff927f82de6bc5d89f07b7da08574bf82de5173123fb7fec736f45e56949f05b9eb1b1a5381db17db46bf5c813bb119a7a7974614fd907c14b1acb13c6dea18707356a4d46fba11c2b1e54e0f6ba3d76b1aa44bd406e4e22851c0e83e0f5dd312fd63da45c78a48a468a4f465f683d780b9b574a7ae86d4dd5fe1776e9c0716e31ed36ce946d4dfa8987fd34c5002800703e1750ac2dd3788f7193c4f5ec3c4fd54fb2a55dadd94810752328564a9556141d07c3eecd3cc537ea93a3f5f01ec368e9fc21b4ff11ab535bb45e2c96268667471f4b2e0fcc329c26cdb8e11d198654856bd54897a28f89ddb5441744a9d64c1f9f6ba86d57e2b79748b07e7da2bcea0ff0015bca5e6d44983f3ecb4ff005333fc4b1e0739aed9f3f5594f653ec36646046eff0013e9eaa737369060736e11cae03c8fca3c36a5a358186542039f4f8824004e432f9ace7b03c64b12ca8c8e390735cd25e859e50731b603f9218249a40912176639a46d80bc4b73ff008cb346296bf968a1481cae50b0cdcc32fa489f0c735fd4d2855e3abbe68f2acda7c6e3c2dd68edd768a400823356d325d3a7208e6363e8d9e9c9fdc7e139a568762f382e0c71e50d2ebd08c08d393e3ae6a31d0b3138f57e4654b096a05990820fc21cd4b51868425e47f5ec32fdc7bd65a4739b42f7123d47f1bb4e2b95da294020e6b1a44da74ddda3ce795e47df5eb4b6e40902166cd1f6da41c4b70077c4458d02a0000f19e55861791fd154727355b8d76f3ca4f201e066d9d58d59bf4b2f46c520a820fa1f82b37abd64266942e6a1baa25e52982e7b3e5ab735c90bcce4f3e14ec355b31cca78e0f072a4cb62b2cabd1878cf5e2b11949503039abedc780996a72570ab292aca55b9e0f3f601c9e07539a568162eb8797948f2869d5e9461624c1f66edd43ca83f4a8dc3b671e8460e410c0f0466d9d604b1fe92c3ff0018c1ef5a68d012ee064faed1879e650d96376274862cb3afdfb1c82fc0c9259653cbc8cfe03c768dcf3a9987ba7d9c020839ab6830dd05e30124cb946c5290a4c9e152a58b937970a127b9cd276dc55807b5fc72622851c28e00fb6cccb5e0795fa28cbf65ee5d795cf73f4f8c524914a2443c32e68fb8a19a1096cfd0f914d14a39470d83dc3c891a92ec140ee72eee1a7587087cdcb7ba2d4fc884796326b96677e6495ce71d49e307dfb6adfe9f535ec8d83edd725a51563fac18e6233128a7cbfaba66de9e94d500aca1187dfbb6ff00082ac6707db05cb15df98a671c654dd36e3fe6007ca9b969cffefe63c86dc138e62955b07b3b3a9d4aa0f9b300465ddd63d56aa65cd52ddb7e649b07e3898c522c83aab66996059d3e397f71f658952bc2f2b9e154739aadf7bf6ddc9e101f0d0ae9a7a82707846c421d032f423edb33ad6aef2bf45197ed3dbb8f2b742707dfc64562687d6395d72a6e3bb070a5c38ca7baa097d2642995b51a967d229949ce411c8fcb3dc82baf32ca172eee9ad0929083265cd7ef59e5012831dde53cbb163e03f2719b3ed96acf03f54fb3756a85985387060ce8791db36cdf16e908dc8fad3eddd9a8058c5443fdf001c60fc6923c679476539575dbb5ba3fd795376274b51e56d5e9d8e024a31595872ac0fdf24d1c4a5a470a32e6e3a75b9087cccb9b9adcfc88b845c96c4d3f265919f001ebec066816bf4baa292780d88791cf86b57852a2efcf0d8f23cb234aedcb31fb341bc696a0093c236230740ebea08f1b332d7aef2bf4519a8596b775e573ec1394f543c654d5eed4f5494b653dd9d12d2654d5a9d951f44a01c0ca472083e37375c8fc8a89966f5ab2499667383da29fa6457ff8904668f6059d3a27e793c786eeb123de117444fb7923b7f50736d5b7b3a602fdbc776df315615d3abf5c0381ecd0b2b1646656ec729eb976a7472f9a76e8827fe0b03e8391cf14881d24041c1ed88cd9b6f94781f066e9d37f53544c83974c27078c513cb2ac6bea58f19a6544a749225eca306390a858f619acdb36f5295cf453c0f6f1d99d102a4ec00f71a2da3535347ecc714864047718eab22321e8735ed38d0bce401e5b1e460f1daf57cfd4c3f64c00786b731874b99b3924976f56f8f5254861d54f23343b42d69d19ea40e0f86bd412e507eee83082a594f553c78ecc8b88e597c777cfe5d258fbbe01f21b36df05ebbf84c7885cf6fa4e5921acca474facf8ecefe49fc77658f37501176183e434ab26a6a11cbdb9e32360e8187719a83f974257eff4e31e6473fbb78ecc9798e64c192b08e2673d865f99a7bb248dff003e3e479238619b7ad0b3a62772b9b8a4f2f4994fd9b426115d74eefe1b86c8afa5bf6271493ea7af7f92d9f70473bd5eef9bb25e34d29d9f17c7459c41aa44f8a7ea4047719bc6d87956af75f93d367356fc72af5e4039bc270d056c1e2ac5183af55209ff000734cb62c698937ecb9aa5936b5095fe4c7fbc7f7cbf23c94a0facfd8734899c6deb001e99d793fd7dd7ffc400141101000000000000000000000000000000b0ffda0008010201013f00524fffc400141101000000000000000000000000000000b0ffda0008010301013f00524fffd9, 'cliente', '2025-11-10 23:13:22'),
(5, 'Jhesly ', 'Barzola Borja', 'barzolajhesly@gmail.com', '15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225', '987654321', 'Santa Clara', NULL, 'admin', '2025-11-13 16:51:02');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carritos`
--
ALTER TABLE `carritos`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_carrito` (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id_detalle_compra`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `mensajes_web`
--
ALTER TABLE `mensajes_web`
  ADD PRIMARY KEY (`id_mensaje`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `id_pedido` (`id_pedido`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carritos`
--
ALTER TABLE `carritos`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes_web`
--
ALTER TABLE `mensajes_web`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carritos`
--
ALTER TABLE `carritos`
  ADD CONSTRAINT `carritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `detalle_carrito`
--
ALTER TABLE `detalle_carrito`
  ADD CONSTRAINT `detalle_carrito_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carritos` (`id_carrito`),
  ADD CONSTRAINT `detalle_carrito_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
