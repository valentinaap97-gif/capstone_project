CAPSTONE PROYECT 
# 📊 Capstone Project: Auditoría, Limpieza y Análisis de E-Commerce en PostgreSQL

## 🚀 1. Configuración del Entorno y Carga de Datos
El proyecto se desarrolló utilizando **PostgreSQL** como motor de base de datos y **DBeaver** como interfaz de gestión.

* **Creación de la Base de Datos:** Se creó una nueva base de datos llamada `capstone_project`.
* **Carga del Dataset:** Se descargó el dataset de e-commerce y se integró a la base de datos mediante la opción de **restaurar backup**, seleccionando el archivo correspondiente para poblar las tablas iniciales.

---

## 🗂️ 2. Arquitectura de Datos y Relaciones
La base de datos está compuesta por tres tablas principales que interactúan entre sí:
* **`clientes`**: Contiene la información de los compradores (`id`, `nombre`, `apellido`).
* **`productos`**: Contiene el catálogo de artículos, precios base y categorías (`id`, `nombre`, `categoria`).
* **`pedidos`**: Tabla transaccional que registra las compras realizadas (`id`, `numero`, `cliente_id`, `producto_id`, `cantidad`, `precio`, `fecha`).

> **Relaciones (JOINs):** La tabla `pedidos` actúa como tabla de hechos, conectándose mediante claves foráneas (`cliente_id` con `clientes.id` y `producto_id` con `productos.id`) para cruzar la información del cliente y del producto adquirido.

---

## 🧹 3. Desafíos Técnicos y Fase de Limpieza de Datos
El dataset presentaba importantes problemas de calidad, ya que campos clave como `precio`, `cantidad` y `fecha` estaban almacenados como tipo `TEXT` e incluían nulos, símbolos monetarios, textos basura y errores lógicos de calendario (como fechas inválidas tipo `2026-13-45`).

* **Limpieza de Precios:** Se utilizaron funciones condicionales (`CASE`, `COALESCE`) y reemplazos masivos (`REPLACE`, `TRIM`) para aislar textos corruptos (como *"consultar"*) y castear el valor a tipo numérico (`::NUMERIC`).
* **Limpieza de Cantidades:** Se normalizaron textos escritos a mano (como traducir *"dos"* a `2`) y se aplicó un valor por defecto con `COALESCE` para evitar romper los cálculos.
* **Validación de Fechas:** Se implementaron filtros estrictos de formato y rangos lógicos (validando que los meses estén entre 1 y 12 y los días entre 1 y 31) para transformar fechas válidas mediante `TO_DATE` y descartar de forma segura anomalías como el mes 13.

---

## 📈 4. Análisis de Negocio (Preguntas Clave)

### Pregunta 1: Top 5 clientes por gasto total
Identifica a los compradores con mayor volumen de facturación histórica utilizando agregaciones (`GROUP BY` + `SUM`) sobre los datos ya limpios.

### Pregunta 2: Ventas totales por mes
Agrupa la facturación de forma cronológica (`YYYY-MM`) utilizando CTEs (`WITH`) para excluir registros nulos o fechas erróneas y visualizar la tendencia comercial.

### Pregunta 3: Los 3 productos menos vendidos
Utiliza un `LEFT JOIN` con la tabla de productos para detectar artículos con menor salida en inventario y evaluar rotación de stock.

### Pregunta 4: Ranking de pedidos por categoría con `RANK()`
Implementa una función de ventana (`RANK() OVER (PARTITION BY categoria ORDER BY ... DESC)`) para ordenar los pedidos según su monto dentro de cada categoría comercial.

### Pregunta 5: Ticket promedio por categoría
Calcula el valor transaccional medio por categoría para enfocar estrategias de venta y campañas de los agentes de atención.
