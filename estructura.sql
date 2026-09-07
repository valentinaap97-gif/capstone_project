--------- Clientes Creacion
CREATE TABLE IF NOT EXISTS clientes (
    id              BIGINT       GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    documento       VARCHAR(20)  NOT NULL,
    nombre          VARCHAR(80)  NOT NULL,
    apellido        VARCHAR(80)  NOT NULL,
    email           VARCHAR(160) NOT NULL,
    telefono        VARCHAR(40),
    direccion       VARCHAR(200),
    ciudad          VARCHAR(80),
    provincia       VARCHAR(80),
    pais            VARCHAR(80)  NOT NULL DEFAULT 'Argentina',
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    creado_en       DATE  NOT NULL DEFAULT now(),
    actualizado_en  DATE  NOT NULL DEFAULT now()
);

INSERT INTO clientes (documento, nombre, apellido, email, telefono, direccion, ciudad, provincia) VALUES
    ('20345678901', 'Lucía',    'Fernández', 'lucia.fernandez@example.com',   '+54 11 4555-1010', 'Av. Rivadavia 1234',   'CABA',         'Buenos Aires'),
    ('27298877665', 'Martín',   'Gómez',     'martin.gomez@example.com',      '+54 11 4555-2020', 'Belgrano 890',         'La Plata',     'Buenos Aires'),
    ('23411223344', 'Sofía',    'Ramírez',   'sofia.ramirez@example.com',     '+54 351 555-3030', 'San Martín 45',        'Córdoba',      'Córdoba'),
    ('20255667788', 'Diego',    'Torres',    'diego.torres@example.com',      '+54 341 555-4040', 'Pellegrini 2100',      'Rosario',      'Santa Fe'),
    ('27388990011', 'Valentina','Sosa',      'valentina.sosa@example.com',    '+54 261 555-5050', 'Las Heras 320',        'Mendoza',      'Mendoza'),
    ('20399001122', 'Nicolás',  'Herrera',   'nicolas.herrera@example.com',   '+54 11 4555-6060', 'Corrientes 3450',      'CABA',         'Buenos Aires'),
    ('27266554433', 'Camila',   'Acosta',    'camila.acosta@example.com',     '+54 381 555-7070', 'Muñecas 512',          'San Miguel',   'Tucumán'),
    ('20477889900', 'Federico', 'Molina',    'federico.molina@example.com',   '+54 223 555-8080', 'Colón 1780',           'Mar del Plata','Buenos Aires');

------------ Productos
CREATE TABLE IF NOT EXISTS productos (
    id              BIGINT        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre          VARCHAR(160)  NOT NULL,
    descripcion     TEXT,
    categoria       VARCHAR(60)   NOT NULL DEFAULT 'general',
    precio          NUMERIC(12,2) NOT NULL,
    stock           INTEGER       NOT NULL DEFAULT 0,
    activo          BOOLEAN       NOT NULL DEFAULT TRUE,
    creado_en       DATE   NOT NULL DEFAULT now(),
    actualizado_en  DATE   NOT NULL DEFAULT now()
);


INSERT INTO productos ( nombre, descripcion, categoria, precio, stock) VALUES
    ('Notebook 14" 16GB RAM',      'Notebook de uso profesional, SSD 512GB.',        'tecnologia',  1250000.00,  15),
    ('Monitor 27" QHD',            'Panel IPS 165Hz, entrada HDMI y DisplayPort.',   'tecnologia',   385000.00,  32),
    ('Teclado mecánico retro',     'Switches marrones, layout latinoamericano.',     'tecnologia',    89500.00,  74),
    ('Mouse inalámbrico ergonómico','Sensor 16000 DPI, batería recargable.',         'tecnologia',    45900.00, 120),
    ('Auriculares con cancelación','Bluetooth 5.3, autonomía de 30 horas.',          'tecnologia',   210000.00,  28),
    ('Silla ergonómica',           'Soporte lumbar regulable, apoyabrazos 4D.',      'oficina',      430000.00,  11),
    ('Escritorio elevable',        'Regulación eléctrica de altura, 140x70cm.',      'oficina',      690000.00,   6),
    ('Lámpara de escritorio LED',  'Temperatura de color regulable, puerto USB.',    'oficina',       38000.00,  95),
    ('Hub USB-C 7 en 1',           'HDMI 4K, lector SD, dos puertos USB 3.0.',       'accesorios',    72000.00,  58),
    ('Cable HDMI 2.1 de 2 metros', 'Soporta 4K a 120Hz.',                            'accesorios',    18500.00, 240),
    ('Soporte articulado para monitor', 'Brazo de aluminio, hasta 32 pulgadas.',      'accesorios',    96000.00,  40),
    ('Disco externo SSD 1TB',      'USB-C, lectura de 1050 MB/s.',                   'accesorios',   215000.00,   0)

select * from productos 
where stock <= 32 and stock != 0


--------------- PEDIDOS
CREATE TABLE pedidos (
    id              BIGINT       GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero          VARCHAR(30)  NOT NULL,
    cliente_id      BIGINT,
    producto_id     BIGINT,
    cantidad        TEXT,
    precio          TEXT,
    fecha           TEXT,
    estado          TEXT,
    observaciones   TEXT,
    creado_en       DATE  NOT NULL DEFAULT now(),
    actualizado_en  DATE  NOT NULL DEFAULT now()

);

INSERT INTO pedidos (numero, cliente_id, producto_id, cantidad, precio, fecha, estado, observaciones) VALUES

-- Limpias: sirven de referencia para comparar.
('PED-0001', 1, 1,  '1',   '1250000.00', '2026-07-03', 'entregado', NULL),
('PED-0002', 2, 2,  '2',   '385000.00',  '2026-07-11', 'pagado',    NULL),

-- NULL: la celda está realmente vacía.
('PED-0003', 3, 3,  '3',   NULL,         NULL,         'pendiente', 'Sin precio ni fecha'),
('PED-0004', 4, 4,  '1',   NULL,         '2026-08-19', 'pendiente', 'Sin precio'),
('PED-0005', 5, 5,  '2',   '210000.00',  NULL,         NULL,        'Sin fecha ni estado'),

-- Texto vacío: parece NULL, pero no lo es.
('PED-0006', 6, 6,  '1',   '',           '',           'pendiente', 'Vacío, no NULL'),
('PED-0007', 7, 7,  '',    '690000.00',  '2026-08-28', '',          'Cantidad y estado vacíos'),

-- Solo espacios.
('PED-0008', 1, 8,  '4',   '   ',        '  ',         'pendiente', 'Espacios en blanco'),

-- Números con símbolos o espacios adentro.
('PED-0009', 2, 9,  '2',   '$ 72000',    '2026-09-01', 'pagado',    'Precio con signo peso'),
('PED-0010', 3, 11, '1',   '96 000',     '2026-09-02', 'enviado',   'Precio con espacio'),
('PED-0011', 4, 5,  '1',   '210000,50',  '2026-08-15', 'pagado',    'Precio con coma decimal'),

-- Fecha escrita al revés (día/mes/año).
('PED-0012', 5, 10, '10',  '18500.00',   '03/09/2026', 'enviado',   'Fecha en formato local'),

-- Fecha que no existe: mes 13, día 45.
('PED-0013', 6, 4,  '2',   '45900.00',   '2026-13-45', 'pendiente', 'Fecha imposible'),

-- Texto donde tendría que haber números o fechas.
('PED-0014', 7, 12, '1',   'N/D',        'sin fecha',  'pendiente', 'Texto en vez de datos'),
('PED-0015', 1, 3,  'dos', 'consultar',  'ayer',       'PENDIENTE', 'Todo escrito a mano'),

-- Mismo estado, escrito distinto.
('PED-0016', 2, 8,  '3',   '38000.00',   '2026-09-03', '  Pagado ', 'Estado con mayúscula y espacios'),

-- Números negativos: son válidos para SQL, imposibles para una venta.
('PED-0017', 3, 10, '-2',  '-18500.00',  '2026-09-01', 'pendiente', 'Cantidad y precio negativos'),

-- Sin cliente ni producto asignado.
('PED-0018', NULL, NULL, '1', '',        NULL,         NULL,        'Sin cliente ni producto');

select * from pedidos
where precio is null
or fecha is null

-- =====================================================================
-- FASE 2: LIMPIEZA Y TRANSFORMACIÓN DE DATOS (DATA CLEANING)
-- =====================================================================

-- 1. Identificación de nulos y vacíos en columnas críticas (precio y fecha)
-- Permite auditar cuántos registros están incompletos o corruptos.
SELECT 
    id,
    numero,
    precio,
    fecha,
    observaciones
FROM pedidos
WHERE precio IS NULL 
   OR TRIM(precio) = '' 
   OR fecha IS NULL 
   OR TRIM(fecha) = '';


-- 2. Limpieza, conversión de tipos (CAST) y gestión de nulos con COALESCE
-- Transformamos los campos TEXT en tipos numéricos y de fecha reales, 
-- aplicando COALESCE para asignar valores por defecto en caso de nulos.
SELECT 
    id,
    numero,
    cliente_id,
    producto_id
FROM pedidos;
    
    -- Limpieza de precio: elimina símbolos, espacios, convierte comas a puntos y hace CAST a NUMERIC.
    -- Si es nulo o texto inválido, COALESCE asigna un valor por defecto (ej. 0.00).
   SELECT 
    precio AS precio_original,
    COALESCE(
        CASE 
            WHEN precio IS NULL OR TRIM(precio) = '' OR precio ~ '[A-Za-z]' OR precio = 'consultar' THEN NULL
            ELSE REPLACE(REPLACE(REPLACE(TRIM(precio), '$', ''), ' ', ''), ',', '.')::NUMERIC
        END, 
        0.00
    ) AS precio_limpio
FROM pedidos;
    -- Limpieza de cantidad: traduce texto a número y convierte a INTEGER, manejando nulos.
   SELECT 
    cantidad AS cantidad_original,
    COALESCE(
        CASE 
            WHEN cantidad = 'dos' THEN 2
            WHEN cantidad IS NULL OR TRIM(cantidad) = '' OR cantidad ~ '[A-Za-z]' THEN NULL
            ELSE TRIM(cantidad)::INTEGER
        END, 
        1
    ) AS cantidad_limpia
FROM pedidos;
    -- Limpieza de fechas: valida formatos y convierte de TEXT a DATE de forma segura.
  SELECT 
    fecha AS fecha_original,
    CASE 
        -- 1. Si es nulo, vacío, tiene letras o dice "sin fecha", lo descartamos
        WHEN fecha IS NULL OR TRIM(fecha) = '' OR fecha ~ '[A-Za-z]' OR fecha = 'sin fecha' THEN NULL
        
        -- 2. Si viene en formato local DD/MM/YYYY
        WHEN fecha LIKE '__/__/____' THEN TO_DATE(fecha, 'DD/MM/YYYY')
        
        -- 3. Si viene en formato YYYY-MM-DD, validamos que el mes (1-12) y el día (1-31) sean lógicos antes de convertir
        WHEN fecha ~ '^\d{4}-\d{2}-\d{2}$' 
             AND SUBSTRING(fecha, 6, 2)::INT BETWEEN 1 AND 12 
             AND SUBSTRING(fecha, 9, 2)::INT BETWEEN 1 AND 31 
        THEN fecha::DATE
        
        -- 4. Cualquier otra cosa extraña o fecha imposible (como la 2026-13-45) cae aquí y se vuelve NULL de forma segura
        ELSE NULL
    END AS fecha_limpia
FROM pedidos;

-- Top 5 clientes por gasto total-- 
SELECT 
    c.id AS cliente_id,
    c.nombre || ' ' || c.apellido AS cliente_nombre,
    SUM(
        COALESCE(
            CASE 
                WHEN p.precio IS NULL OR TRIM(p.precio) = '' OR p.precio ~ '[A-Za-z]' OR p.precio = 'consultar' THEN NULL
                ELSE REPLACE(REPLACE(REPLACE(TRIM(p.precio), '$', ''), ' ', ''), ',', '.')::NUMERIC
            END, 
            0.00
        ) * 
        COALESCE(
            CASE 
                WHEN p.cantidad = 'dos' THEN 2
                WHEN p.cantidad IS NULL OR TRIM(p.cantidad) = '' OR p.cantidad ~ '[A-Za-z]' THEN NULL
                ELSE TRIM(p.cantidad)::INTEGER
            END, 
            1
        )
    ) AS gasto_total
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY gasto_total DESC
LIMIT 5;

--Ventas totales por mes (Funciones de fecha)--
WITH pedidos_por_mes AS (
    SELECT 
        TO_CHAR(
            CASE 
                WHEN p.fecha IS NULL OR TRIM(p.fecha) = '' OR p.fecha ~ '[A-Za-z]' OR p.fecha = 'sin fecha' THEN NULL
                WHEN p.fecha LIKE '__/__/____' THEN TO_DATE(p.fecha, 'DD/MM/YYYY')
                WHEN p.fecha ~ '^\d{4}-\d{2}-\d{2}$' 
                     AND SUBSTRING(p.fecha, 6, 2)::INT BETWEEN 1 AND 12 
                     AND SUBSTRING(p.fecha, 9, 2)::INT BETWEEN 1 AND 31 
                THEN p.fecha::DATE
                ELSE NULL
            END, 
            'YYYY-MM'
        ) AS anio_mes,
        COALESCE(
            CASE 
                WHEN p.precio IS NULL OR TRIM(p.precio) = '' OR p.precio ~ '[A-Za-z]' OR p.precio = 'consultar' THEN NULL
                ELSE REPLACE(REPLACE(REPLACE(TRIM(p.precio), '$', ''), ' ', ''), ',', '.')::NUMERIC
            END, 
            0.00
        ) * 
        COALESCE(
            CASE 
                WHEN p.cantidad = 'dos' THEN 2
                WHEN p.cantidad IS NULL OR TRIM(p.cantidad) = '' OR p.cantidad ~ '[A-Za-z]' THEN NULL
                ELSE TRIM(p.cantidad)::INTEGER
            END, 
            1
        ) AS subtotal
    FROM pedidos p
)
SELECT 
    anio_mes,
    SUM(subtotal) AS ventas_totales
FROM pedidos_por_mes
WHERE anio_mes IS NOT NULL
GROUP BY anio_mes
ORDER BY anio_mes;

--Los 3 productos menos vendidos--
SELECT 
    pr.id AS producto_id,
    pr.nombre AS producto_nombre,
    pr.categoria,
    COALESCE(SUM(
        COALESCE(
            CASE 
                WHEN p.cantidad = 'dos' THEN 2
                WHEN p.cantidad IS NULL OR TRIM(p.cantidad) = '' OR p.cantidad ~ '[A-Za-z]' THEN NULL
                ELSE TRIM(p.cantidad)::INTEGER
            END, 
            1
        )
    ), 0) AS total_unidades_vendidas
FROM productos pr
LEFT JOIN pedidos p ON pr.id = p.producto_id
GROUP BY pr.id, pr.nombre, pr.categoria
ORDER BY total_unidades_vendidas ASC
LIMIT 3;

--Ranking de pedidos por categoría con RANK() (Window Function)--

WITH pedidos_calculados AS (
    SELECT 
        pr.categoria,
        p.numero AS numero_pedido,
        pr.nombre AS producto,
        COALESCE(
            CASE 
                WHEN p.precio IS NULL OR TRIM(p.precio) = '' OR p.precio ~ '[A-Za-z]' OR p.precio = 'consultar' THEN NULL
                ELSE REPLACE(REPLACE(REPLACE(TRIM(p.precio), '$', ''), ' ', ''), ',', '.')::NUMERIC
            END, 
            0.00
        ) * 
        COALESCE(
            CASE 
                WHEN p.cantidad = 'dos' THEN 2
                WHEN p.cantidad IS NULL OR TRIM(p.cantidad) = '' OR p.cantidad ~ '[A-Za-z]' THEN NULL
                ELSE TRIM(p.cantidad)::INTEGER
            END, 
            1
        ) AS monto_total_pedido
    FROM pedidos p
    JOIN productos pr ON p.producto_id = pr.id
)
SELECT 
    categoria,
    numero_pedido,
    producto,
    monto_total_pedido,
    RANK() OVER (PARTITION BY categoria ORDER BY monto_total_pedido DESC) AS ranking_en_categoria
FROM pedidos_calculados;

-- Calculamos el ticket promedio por categoría para entender qué tipo de productos 
-- generan transacciones de mayor valor y enfocar las campañas comerciales de los agentes.
WITH detalle_transacciones AS (
    SELECT 
        pr.categoria,
        p.numero AS numero_pedido,
        COALESCE(
            CASE 
                WHEN p.precio IS NULL OR TRIM(p.precio) = '' OR p.precio ~ '[A-Za-z]' OR p.precio = 'consultar' THEN NULL
                ELSE REPLACE(REPLACE(REPLACE(TRIM(p.precio), '$', ''), ' ', ''), ',', '.')::NUMERIC
            END, 
            0.00
        ) * 
        COALESCE(
            CASE 
                WHEN p.cantidad = 'dos' THEN 2
                WHEN p.cantidad IS NULL OR TRIM(p.cantidad) = '' OR p.cantidad ~ '[A-Za-z]' THEN NULL
                ELSE TRIM(p.cantidad)::INTEGER
            END, 
            1
        ) AS monto_total
    FROM pedidos p
    JOIN productos pr ON p.producto_id = pr.id
)
SELECT 
    categoria,
    ROUND(AVG(monto_total), 2) AS ticket_promedio,
    COUNT(numero_pedido) AS cantidad_pedidos_asociados
FROM detalle_transacciones
GROUP BY categoria
ORDER BY ticket_promedio DESC;