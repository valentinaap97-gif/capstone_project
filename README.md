CAPSTONE PROYECT 
# 🛒 Proyecto SQL: Gestión, Auditoría y Limpieza de Datos (Data Cleaning)
Proyecto desarrollado en **PostgreSQL** (ejecutado y gestionado mediante **DBeaver**), enfocado en el modelado de bases de datos relacionales, auditoría de datos, técnicas avanzadas de **Data Cleaning**, persistencia de información y consultas analíticas de negocio (Business Intelligence).
---
## 📂 Estructura del Proyecto
El proyecto consta de tres tablas principales diseñadas para simular un sistema de comercio electrónico:

1. **`clientes`**: Almacena la información personal y de contacto de los compradores (con restricciones de unicidad en documentos y valores por defecto).
2. **`productos`**: Contiene el catálogo de artículos disponibles (tecnología, oficina, accesorios), gestionando precios, stock y estados de disponibilidad.
3. **`pedidos`**: Tabla transaccional diseñada con "datos sucios" (valores nulos, textos vacíos, formatos de fecha locales, precios con símbolos de moneda, espacios en blanco y errores de tipeo) para practicar flujos completos de limpieza y normalización.
---
## ⚙️ Fases del Proyecto
### 1. Creación de Estructuras e Inserción
* Creación de tablas relacionales con tipos de datos robustos, restricciones (`PRIMARY KEY`, `NOT NULL`, `DEFAULT`) y columnas autoincreméntales (`GENERATED ALWAYS AS IDENTITY`).
* Inserción de datos maestros y datos transaccionales intencionalmente corrompidos para auditar y transformar.
### 2. Procesamiento de Información y Limpieza Consistente (Data Cleaning)
Implementación de un script de actualización masiva (`UPDATE`) con persistencia en la base de datos que soluciona los siguientes escenarios críticos en la tabla `pedidos`:
* **Precios (`precio`)**: Eliminación de símbolos (`$`), espacios internos, reemplazo de comas decimales por puntos, y manejo de excepciones (textos como `'consultar'` o nulos) respaldados por un valor por defecto.
* **Cantidades (`cantidad`)**: Conversión segura a enteros positivos aplicando valor absoluto (`ABS`) y normalización de textos escritos a mano (ej. `'dos'` a `2`).
* **Fechas (`fecha`)**: Detección y normalización de formatos locales (`DD/MM/YYYY`) hacia el estándar ISO (`YYYY-MM-DD`), descartando fechas imposibles y aplicando la fecha actual por defecto ante valores corruptos.
* **Estados (`estado`)**: Estandarización de mayúsculas, eliminación de espacios sobrantes con `TRIM` y `LOWER`, y asignación de un estado por defecto (`'pendiente'`) en registros vacíos.
---
## 📊 Consultas Analíticas (Reporting & Business Intelligence)
El proyecto incluye reportes analíticos avanzados sobre los datos ya normalizados:
* **Top 5 Clientes por Gasto Total:** Identificación de los compradores que generan mayor volumen de ingresos a través de una agregación con `JOIN` y `GROUP BY`.
* **Ventas Totales por Mes:** Análisis temporal de ingresos utilizando funciones de conversión y extracción de fechas (`TO_CHAR`).
* **Productos Menos Vendidos:** Auditoría de rotación de inventario con `LEFT JOIN` para detectar artículos con menor salida comercial.
* **Ranking por Categoría (`RANK()`):** Uso de funciones de ventana (*Window Functions*) para jerarquizar los pedidos de mayor valor dentro de cada categoría de productos.
* **Ticket Promedio por Categoría:** Análisis del valor monetario medio por transacción para orientar decisiones y estrategias comerciales.
---
## 🛠️ Tecnologías y Herramientas Utilizadas
* **Motor de Base de Datos:** PostgreSQL
* **Entorno de Desarrollo (IDE):** DBeaver
* **Lenguaje:** SQL (DDL, DML, Funciones de texto, Expresiones Regulares, Window Functions)
