# BALANCE TÉCNICO Y METODOLÓGICO — MÓDULOS 2 Y 3

**Diplomatura en Programación en R Aplicada a la Economía — FCE-UBA**
**Adrián Ledesma**
**Inventario de instrumentos, procedimientos, fuentes y estructuras de trabajo**
**Julio 2026**

---

## ÍNDICE

- [BLOQUE A — Texto de contexto para conversación nueva](#bloque-a--texto-de-contexto-para-conversación-nueva)
- [BLOQUE B — Balance completo por sección](#bloque-b--balance-completo-por-sección)
  1. [Flujo de trabajo en RStudio](#1-flujo-de-trabajo-en-rstudio)
  2. [Lectura y diagnóstico de bases](#2-lectura-y-diagnóstico-de-bases)
  3. [Limpieza y preparación](#3-limpieza-y-preparación)
  4. [Joins y puentes entre bases](#4-joins-y-puentes-entre-bases)
  5. [Agregación y cálculos](#5-agregación-y-cálculos)
  6. [Visualización](#6-visualización)
  7. [Exportación](#7-exportación)
  8. [Manejo de bases grandes](#8-manejo-de-bases-grandes)
  9. [Fuentes y bases de datos](#9-fuentes-y-bases-de-datos--inventario-con-referencias)
  10. [Debugging y resolución de problemas](#10-debugging-y-resolución-de-problemas)
  11. [Estructura de entrega](#11-estructura-de-entrega)
- [BLOQUE C — Síntesis de competencias adquiridas](#bloque-c--síntesis-de-competencias-adquiridas)

---

# BLOQUE A — TEXTO DE CONTEXTO PARA CONVERSACIÓN NUEVA

*Copiar y pegar tal cual al abrir sesión nueva.*

```
CONTEXTO — Adrián Ledesma, Diplomatura en Programación en R Aplicada
a la Economía, FCE-UBA.

MÓDULOS COMPLETADOS:
- Módulo 2 (Programación en R, docente Celina Santellán) — nota 9/10
- Módulo 3 (Indicadores de la producción) — entregado y aceptado 27/07/2026

ENTORNO: RStudio, R 4.6.0, Windows. tidyverse 2.0.0, writexl, gt,
paletteer instalados.

ESTRUCTURA DE TRABAJO CONSOLIDADA:
Proyecto .Rproj en raíz / carpeta bases/ / carpeta resultados/ /
scripts comentados con encabezado y versión V.n.n / documento PDF de
análisis / compresión ZIP para entrega por formulario.

MÉTODO DE APRENDIZAJE PREFERIDO: top-down — ver funcionar primero,
mecanismos después. Instrucción paso a paso: se indica qué hacer, se
ejecuta, se reporta resultado, se sigue.

PREFERENCIAS DE RESPUESTA: texto plano, científico y conciso, sin
framing motivacional, citas APA a fuentes vivas. En tareas de
escritura: intervención mínima, preservar voz y registro, marcar
cambios con justificación.

PENDIENTE DE MÓDULOS ANTERIORES: scripts de Clase 4 y 5 del Módulo 2
no generados; verificar si bases de clases son idénticas a bases
generales del módulo.
```

---

# BLOQUE B — BALANCE COMPLETO POR SECCIÓN

---

## 1. FLUJO DE TRABAJO EN RSTUDIO

### 1.1. Creación de proyecto

Secuencia establecida y validada dos veces (M2 y M3):

```
1. Crear manualmente carpeta raíz: Apellido_EntregaMn
2. Crear subcarpetas: bases/ y resultados/
3. Depositar los .csv/.xlsx en bases/
4. RStudio: File > New Project > Existing Directory > seleccionar raíz
5. Verificar en esquina superior derecha que el proyecto está activo
```

**Por qué importa:** el `.Rproj` fija el working directory en la raíz. Todas las rutas del script pasan a ser relativas (`"bases/archivo.csv"`), lo que hace el proyecto portable — el corrector lo descomprime en su máquina y funciona sin editar una sola línea. Este punto fue explícitamente destacado en la devolución del Módulo 2.

### 1.2. Convenciones de nombres

Regla de cátedra (Clase 1, Módulo 2), aplicada consistentemente:

- minúsculas
- sin tildes ni ñ
- separador guion bajo `_`
- sin espacios

Aplicado a: `script_parte1_desindustrializacion.R`, `g1_participacion_pib_industrial.png`, `ubicuidad_productos.xlsx`.

### 1.3. Consola vs Script — división funcional

| Espacio | Uso |
|---|---|
| **Consola** (panel inferior izq.) | Exploración, diagnóstico, verificación puntual, `install.packages()`, `rm(list=ls())` |
| **Script** (panel superior izq.) | Todo lo que debe quedar registrado y ser reproducible |

Criterio operativo: *si el corrector necesita verlo para entender qué hiciste, va al script. Si es un chequeo tuyo de un momento, va a la consola.*

### 1.4. Panel Environment

Panel superior derecho. Función diagnóstica constante: permite verificar en tiempo real cuántas filas y columnas tiene cada objeto después de cada operación. Detectar que `pib_9paises` quedó en 486 filas y `poblacion` en 495 anticipó que el `left_join` iba a generar NAs — problema resuelto antes de que apareciera.

Limpieza de memoria antes de cargar bases pesadas:

```r
rm(list = ls())
```

### 1.5. Versionado manual

Encabezado estándar consolidado:

```r
# ============================================================
# Adrián Ledesma
# Actividad Integradora Módulo 3 — Parte 1
# Desindustrialización y NDIT
# V.1.1
# ============================================================
```

Función: permitir reconstruir el estado del script en caso de error, y dejar rastro de autoría y propósito para el corrector.

### 1.6. Ejecución selectiva

- `Ctrl+S` — guardar
- `Ctrl+A` — seleccionar todo
- `Ctrl+Enter` — ejecutar selección

Patrón de trabajo: escribir bloque → guardar → seleccionar solo ese bloque → ejecutar → verificar → siguiente bloque. Evita re-ejecutar cargas pesadas innecesariamente.

---

## 2. LECTURA Y DIAGNÓSTICO DE BASES

### 2.1. Lectura

```r
objeto <- read_csv("bases/archivo.csv")
```

`read_csv()` de readr (no `read.csv()` de base R): devuelve tibble, infiere tipos, reporta especificación de columnas.

### 2.2. Inspección estructural — trío de diagnóstico

```r
glimpse(objeto)        # estructura: filas, columnas, tipos, primeros valores
names(objeto)          # nombres exactos de columnas
unique(objeto$columna) # valores únicos de una variable
```

Variante para exploración ordenada y acotada:

```r
unique(base$columna) %>% sort() %>% head(20)
```

### 2.3. `problems()` — diagnóstico de parsing

Instrumento clave descubierto en Módulo 2:

```r
problems(objeto)
```

Devuelve tibble con: `row`, `col`, `expected`, `actual`, `file`.

**Caso resuelto (M2):** `empleo_sectores_base.csv` devolvía 1.062 warnings del tipo `expected 7 columns, got 1 column`. El diagnóstico reveló filas separadoras de bloque que contenían solo el código de país (`"ARG"`, `"BOL"`) sin las otras seis columnas.

**Solución:**

```r
empleo <- read_csv("base/empleo_sectores_base.csv") %>%
  filter(!is.na(anio))
```

Resultado: 4.248 → 3.186 filas limpias.

> **Lección conceptual importante:** `problems()` sigue reportando los errores después del filtrado, porque registra lo ocurrido *durante la lectura*, no el estado del objeto filtrado. No es un fallo del fix — es el comportamiento esperado.

### 2.4. Detección de tipos incorrectos

`glimpse()` reveló en `poblacion.csv`:

```
$ Population <chr> "11290128", "11567667", ...
```

Números almacenados como texto (`chr`) por comillas en el CSV origen. Sin conversión, cualquier operación aritmética falla silenciosamente o devuelve NA.

**Conversión:**

```r
mutate(poblacion = as.numeric(poblacion))
```

### 2.5. Verificación de orden de magnitud

Procedimiento de validación sustantiva antes de graficar:

```r
pib_industrial %>% filter(geocodigoFundar == "USA", anio == 2020) %>% pull(industry_gdp)
# [1] 2122560637045
```

2,1 billones USD para el PIB industrial estadounidense en 2020 → consistente con USD constantes. Si hubiera devuelto 2.000.000 habría indicado millones o moneda local.

> **Principio:** antes de graficar, verificar que los números tienen sentido en el mundo real. Un gráfico prolijo sobre datos en unidades equivocadas es peor que ningún gráfico.

### 2.6. `pull()` vs `select()`

```r
select(columna)  # devuelve tibble de una columna
pull(columna)    # devuelve vector — útil para inspección rápida
```

---

## 3. LIMPIEZA Y PREPARACIÓN

### 3.1. `rename()` con backticks

Para nombres de columna con espacios, barras o caracteres especiales:

```r
rename(
  pais_ingles = `Country/Area`,
  anio        = Year,
  poblacion   = Population
)
```

Los backticks son obligatorios cuando el nombre original no es un identificador válido de R.

### 3.2. `filter()` con `%in%`

Para múltiples valores en lugar de encadenar `==` con `|`:

```r
filter(pais_ingles %in% c("Argentina", "Brazil", "Mexico"))
```

### 3.3. `mutate()` + `case_when()` — recodificación manual

Patrón usado para construir dos columnas nuevas en una sola pasada:

```r
mutate(
  pais = case_when(
    pais_ingles == "Argentina" ~ "Argentina",
    pais_ingles == "Brazil"    ~ "Brasil",
    pais_ingles == "Mexico"    ~ "México"
  ),
  iso3 = case_when(
    pais_ingles == "Argentina" ~ "ARG",
    pais_ingles == "Brazil"    ~ "BRA",
    pais_ingles == "Mexico"    ~ "MEX"
  )
)
```

Sintaxis: `condición ~ valor`. Evalúa en orden, la primera coincidencia gana. Sin `TRUE ~ valor` final, los no coincidentes quedan `NA`.

### 3.4. `grepl()` para búsqueda parcial

Instrumento decisivo cuando dos países faltaban en el filtro:

```r
poblacion %>% 
  filter(grepl("Kingdom|China|Chin", `Country/Area`)) %>% 
  distinct(`Country/Area`)
```

Reveló los nombres reales en la base ONU:

- `"China (mainland)"` — no `"China"`
- `"United Kingdom of Great Britain and Northern Ireland"` — no `"United Kingdom"`

El pipe `|` dentro del patrón funciona como OR lógico.

### 3.5. `distinct()`

Para ver valores únicos sin las repeticiones de la serie temporal:

```r
distinct(`Country/Area`)
```

### 3.6. `select()` — reducción y reordenamiento

```r
select(anio, pais, iso3, poblacion)   # mantiene y reordena
select(-producto, -valor_miles_usd)   # elimina
```

---

## 4. JOINS Y PUENTES ENTRE BASES

Esta fue la dificultad estructural central del Módulo 3 y merece tratamiento detallado.

### 4.1. Diagnóstico del problema

Dos bases a unir:

| Base | Identificador de país |
|---|---|
| `pib_industrial_mundial.csv` | `geocodigoFundar` = ISO3 + `geonombreFundar` en **español** |
| `poblacion.csv` | `Country/Area` en **inglés**, sin ISO3 |

No hay clave común directa. `"Argentina"` coincide por casualidad; `"Alemania"` vs `"Germany"` no.

### 4.2. Estrategia A — Puente manual (usada en Parte 1)

Construir el ISO3 desde el nombre en inglés vía `case_when`, solo para los 9 países necesarios.

- **Ventaja:** no requiere archivo externo.
- **Límite:** no escala. Con 238 países sería inviable.

### 4.3. Estrategia B — Diccionario externo (usada en Parte 2)

`country_codes_V202601.csv` de BACI actúa como tabla puente:

```
country_code | country_name | country_iso2 | country_iso3
     32      | Argentina    |      AR      |     ARG
```

```r
comercio_mundial <- comercio_mundial %>%
  left_join(
    paises_baci %>% select(country_code, country_iso3),
    by = c("i" = "country_code")
  ) %>%
  filter(!is.na(country_iso3))
```

**Ventaja:** escala a 238 países automáticamente.

### 4.4. Sintaxis de `left_join` con claves de distinto nombre

```r
by = c("i" = "country_code")
```

Lee: *la columna `i` de la base izquierda corresponde a `country_code` de la derecha.* El orden importa: izquierda primero.

### 4.5. `left_join` con clave compuesta

```r
left_join(poblacion %>% select(anio, iso3, poblacion), 
          by = c("anio", "iso3"))
```

Une por dos columnas simultáneamente. Necesario en series temporales por país: un país tiene 55 filas, una por año.

### 4.6. Reducir la base derecha antes de unir

```r
left_join(paises_baci %>% select(country_code, country_iso3), ...)
```

Traer solo las columnas necesarias evita arrastrar columnas redundantes que después hay que limpiar.

### 4.7. Filtrar NAs post-join

```r
filter(!is.na(country_iso3))
filter(!is.na(poblacion))
```

`left_join` conserva todas las filas de la izquierda. Las que no encontraron par quedan con `NA`. Filtrar explícitamente es más seguro que dejar que propaguen.

### 4.8. Justificación metodológica de la inconsistencia

Habiendo usado dos estrategias distintas en un mismo trabajo, se redactó justificación explícita para el documento:

> *"En la Parte 1 el diccionario de países no estaba disponible inicialmente debido a que el archivo `country_codes_V202601.csv` no había sido reconocido por el entorno de trabajo al momento de ejecutar el script, por lo que se optó por una solución manual mediante `case_when` para los 9 países seleccionados. Una vez identificado el problema —la ruta del archivo no coincidía con el directorio del proyecto— se incorporó el diccionario completo en la Parte 2, permitiendo un join automático con los 238 países de la base BACI."*

> **Principio general:** una inconsistencia metodológica documentada y explicada vale más que una inconsistencia oculta.

---

## 5. AGREGACIÓN Y CÁLCULOS

### 5.1. La distinción fundamental: `summarise()` vs `mutate()` bajo `group_by()`

Probablemente la lección conceptual más transferible de todo el trabajo.

```r
# COLAPSA: una fila por grupo
group_by(anio) %>%
  summarise(total = sum(valor))

# NO COLAPSA: mantiene todas las filas, agrega columna con el total del grupo
group_by(anio) %>%
  mutate(total = sum(valor)) %>%
  ungroup()
```

**Cuándo usar cada uno:**

- `summarise()` → cuando el resultado *es* la agregación (PIB mundial por año)
- `mutate()` → cuando necesitás el total *junto a* cada observación para dividir (calcular participación)

### 5.2. `.groups = "drop"`

```r
summarise(total = sum(valor), .groups = "drop")
```

Sin este argumento, `summarise()` sobre múltiples grupos deja el resultado agrupado por las variables restantes y emite el aviso:

```
`summarise()` has grouped output by 'anio'. You can override using the `.groups` argument.
```

No es error, pero deja el objeto agrupado, lo que produce comportamiento inesperado en operaciones posteriores. Fue observación pendiente en M2 y se aplicó sistemáticamente en M3.

### 5.3. `ungroup()`

Cierre explícito de agrupamiento. Necesario tras `group_by() %>% mutate()`. Encadenar múltiples agrupamientos sin desagrupar produce cálculos sobre grupos anidados no deseados.

Patrón de cálculo secuencial con tres niveles de agregación distintos:

```r
comercio_mundial <- comercio_mundial %>%
  group_by(country_iso3) %>%
  mutate(expo_total_pais = sum(valor_miles_usd, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(expo_totales = sum(valor_miles_usd, na.rm = TRUE)) %>%
  group_by(producto) %>%
  mutate(expo_producto = sum(valor_miles_usd, na.rm = TRUE)) %>%
  ungroup()
```

Tres totales en tres niveles distintos (país / mundo / producto), todos conservando el grano original de la base.

### 5.4. `na.rm = TRUE`

Sin este argumento, un solo `NA` en la serie devuelve `NA` para toda la suma. Regla: incluirlo por defecto en toda agregación sobre datos reales.

### 5.5. Cálculo de participación porcentual — patrón de dos pasos

```r
# Paso 1: total de referencia
pib_mundial_anual <- pib_industrial %>%
  group_by(anio) %>%
  summarise(pib_industrial_mundial = sum(industry_gdp, na.rm = TRUE))

# Paso 2: unir y dividir
pib_participacion <- pib_9paises %>%
  left_join(pib_mundial_anual, by = "anio") %>%
  mutate(participacion_pct = (industry_gdp / pib_industrial_mundial) * 100)
```

> **Punto conceptual relevante:** el denominador se calcula sobre la base *completa* (todos los países), no sobre los 9 seleccionados. De lo contrario la "participación mundial" sería participación dentro de la muestra.

> **Punto adicional:** en un cociente, la unidad monetaria y el año base se cancelan. Por eso la participación porcentual es comparable sin importar si la base está en USD constantes de 2015 o de 2017.

### 5.6. Cálculo per cápita

```r
mutate(pib_industrial_pc = industry_gdp / poblacion)
```

Simple, pero requiere que ambas variables sean numéricas (de ahí la importancia del `as.numeric()` previo) y que el join haya sido por `anio` + `iso3`.

### 5.7. Ventaja Comparativa Revelada (VCR) — Índice de Balassa

Fórmula:

```
        exportaciones del producto i por el país x / exportaciones totales del país x
VCR = ────────────────────────────────────────────────────────────────────────────────
        exportaciones mundiales del producto i / exportaciones mundiales totales
```

Implementación:

```r
mutate(
  vcr = (valor_miles_usd / expo_total_pais) /
        (expo_producto / expo_totales)
)
```

**Interpretación:** VCR > 1 indica que el país exporta ese producto en una proporción mayor a la que representa el producto en el comercio mundial → ventaja comparativa revelada.

### 5.8. Normalización de VCR (del script de cátedra)

```r
mutate(IVCRmas1   = vcr + 1) %>% 
mutate(IVCRmenos1 = vcr - 1) %>% 
mutate(IVCRnorm   = round(IVCRmenos1 / IVCRmas1, digits = 2))
```

Transforma el rango `[0, ∞)` en `[-1, 1]`, simétrico y comparable. Útil para tablas y mapas de calor.

### 5.9. Ubicuidad

Concepto de la teoría de complejidad económica (Hidalgo & Hausmann): cuántos países exportan un producto con ventaja comparativa.

```r
ubicuidad <- comercio_mundial %>%
  filter(vcr > 1) %>%
  group_by(producto) %>%
  summarise(n_paises_vcr = n(), .groups = "drop") %>%
  arrange(desc(n_paises_vcr))
```

`n()` cuenta filas por grupo. Como la base ya está colapsada a una fila por país-producto, contar filas equivale a contar países.

**Resultado obtenido:** 5.606 productos con al menos un exportador con VCR.

### 5.10. Extremos de una distribución ordenada

```r
top10_ubicuos      <- ubicuidad %>% arrange(desc(n_paises_vcr)) %>% head(10)
top10_poco_ubicuos <- ubicuidad %>% arrange(n_paises_vcr) %>% head(10)
```

### 5.11. Join para enriquecimiento descriptivo

Los códigos HS6 son numéricos e ilegibles. Cruce con diccionario de productos:

```r
top10_ubicuos %>%
  mutate(producto = as.character(producto)) %>%
  left_join(
    product_codes %>% mutate(code = as.character(code)),
    by = c("producto" = "code")
  )
```

> **Detalle técnico crítico:** ambas claves deben tener el mismo tipo. `as.character()` en ambos lados evita el fallo silencioso por incompatibilidad `dbl` vs `chr` (que además destruiría los ceros a la izquierda de los códigos HS: `010231` → `10231`).

---

## 6. VISUALIZACIÓN

### 6.1. Estructura base de ggplot2

```r
objeto %>%
  ggplot(aes(x = variable_x, y = variable_y, color = grupo)) +
  geom_line() +
  labs() +
  scale_x_continuous() +
  theme_classic() +
  theme()
```

Nota de sintaxis: dentro de ggplot se encadena con `+`, no con `%>%`.

### 6.2. Doble codificación estética — hallazgo del Módulo 3

```r
aes(x = anio, y = participacion_pct, color = pais, linetype = grupo)
```

Nueve países en un solo panel son ilegibles solo por color. Agregar `linetype` mapeado a la variable de agrupamiento regional permite leer simultáneamente:

- **qué país** es cada línea (color)
- **a qué grupo** pertenece (tipo de trazo: sólido / punteado / rayado)

Solución más económica que un `facet_wrap` cuando se quiere preservar la comparación visual directa entre grupos.

### 6.3. Variable auxiliar de agrupamiento

```r
mutate(grupo = case_when(
  iso3 %in% c("ARG", "BRA", "MEX") ~ "América Latina",
  iso3 %in% c("USA", "FRA", "GBR") ~ "Desarrollados tradicionales",
  iso3 %in% c("JPN", "KOR", "CHN") ~ "Asia Oriental"
))
```

La variable no existe en los datos originales: se construye específicamente para la visualización, siguiendo la agrupación que propone la consigna.

### 6.4. `labs()` completo

```r
labs(
  title    = "Participación en el PIB industrial mundial (1970–2024)",
  subtitle = "9 países seleccionados por región",
  x        = "Año",
  y        = "% del PIB industrial mundial",
  color    = "País",
  linetype = "Grupo",
  caption  = "Fuente: Fundar — pib_industrial_mundial.csv (USD constantes)"
)
```

El `caption` con fuente y unidad de medida es requisito de calidad en trabajo con datos económicos. Los argumentos `color` y `linetype` renombran los títulos de las leyendas correspondientes.

### 6.5. Control del eje temporal

```r
scale_x_continuous(breaks = seq(1970, 2024, by = 5))
```

Sin esto, ggplot elige breaks automáticos que rara vez coinciden con marcas significativas. Variante usada en M2: `by = 10`.

Opcional: `expand = c(0, 0)` elimina el margen interno del panel.

### 6.6. Ajustes de `theme()` — repertorio consolidado

```r
theme(
  axis.text.x      = element_text(angle = 45, hjust = 1),  # rotar etiquetas
  legend.position  = "right",                              # o "bottom"
  legend.text      = element_text(size = 8),               # achicar texto
  legend.key.width = unit(1.5, "cm"),                      # ensanchar clave
  strip.background = element_rect(fill = "#EEEDFE"),       # fondo de facet
  strip.text       = element_text(face = "bold")           # texto de facet
)
```

### 6.7. Diagnóstico visual iterativo — caso registrado

Primera versión del gráfico 1: `legend.position = "bottom"` con 9 países + 3 grupos → la leyenda se cortó, China y Corea del Sur quedaron fuera del canvas.

Corrección aplicada:

```r
legend.position  = "right",
legend.text      = element_text(size = 8),
legend.key.width = unit(1.5, "cm")

# y ampliar el lienzo:
ggsave(..., width = 28, height = 16, units = "cm", dpi = 150)
```

> **Principio:** el gráfico se verifica visualmente antes de darlo por cerrado. Un gráfico con leyenda incompleta es un gráfico inutilizable.

### 6.8. `str_wrap()` para etiquetas largas *(M2)*

```r
mutate(sector_corto = str_wrap(sector_desc, width = 22))
```

Inserta saltos de línea a los N caracteres. Destacado explícitamente en la devolución del Módulo 2 como "solución elegante que evita que las etiquetas se superpongan".

### 6.9. `facet_wrap()` *(M2)*

```r
facet_wrap(~ gran_sector, ncol = 2)
```

Divide en paneles según una variable categórica. Alternativa al doble mapeo estético cuando los grupos no necesitan compararse en la misma escala visual.

### 6.10. Geoms utilizados

| Geom | Uso |
|---|---|
| `geom_line(linewidth = 0.7)` | series temporales |
| `geom_col()` | barras con valores ya calculados |
| `geom_point(size = 1)` | marcar observaciones sobre la línea |
| `geom_col(position = "stack")` | columnas apiladas (composición) |

Nota: `linewidth` reemplaza al antiguo `size` para líneas en ggplot2 ≥ 3.4.

### 6.11. `ggplotly()` *(disponible, no usado en la entrega)*

```r
library(plotly)
ggplotly(objeto_ggplot)
```

Convierte un ggplot en gráfico interactivo con tooltips. Presente en el script de referencia de cátedra. No aplicable a exportación PNG estática.

---

## 7. EXPORTACIÓN

### 7.1. `ggsave()`

```r
ggsave("resultados/g1_participacion_pib_industrial.png",
       plot = g1, width = 28, height = 16, units = "cm", dpi = 150)
```

Especificar `width`, `height`, `units` y `dpi` explícitamente fue destacado en la devolución del M2. Sin esos parámetros, ggplot usa las dimensiones de la ventana Plots, lo que produce resultados no reproducibles.

Dimensiones utilizadas:

- 18 × 12 cm — gráfico simple
- 24 × 16 cm — gráfico con facets
- 28 × 16 cm — gráfico con leyenda lateral extensa

### 7.2. `write_csv()`

```r
write_csv(proc_simple, "resultados/procesamiento_simple.csv")
```

### 7.3. `write_xlsx()` con múltiples hojas

```r
library(writexl)

write_xlsx(
  list(
    "Mas ubicuos"   = top10_ubicuos_desc,
    "Menos ubicuos" = top10_poco_ubicuos_desc
  ),
  path = "resultados/ubicuidad_productos.xlsx"
)
```

Una lista nombrada genera un archivo Excel con una hoja por elemento, usando el nombre del elemento como nombre de hoja. Sin dependencia de Java (a diferencia de `xlsx`).

### 7.4. `cat()` como confirmación de ejecución

```r
cat("Archivo exportado correctamente a resultados/ubicuidad_productos.xlsx\n")
```

Marcador visible en consola. Útil en scripts largos para confirmar que una operación silenciosa se completó.

### 7.5. Carpeta `resultados/` como salida única

Toda exportación apunta a `resultados/`. Ninguna a la raíz ni a `bases/`. La separación entrada/salida es requisito explícito de ambas consignas.

---

## 8. MANEJO DE BASES GRANDES

### 8.1. El caso BACI

| Dato | Valor |
|---|---|
| Filas reales | **11.250.411** |
| Columnas | 6 (`t, i, j, k, v, q`) |
| Granularidad | año × exportador × importador × producto |

La muestra del enunciado indicaba ~1.049.000 filas. La base real tenía diez veces más. Se procesó sin error.

### 8.2. Estrategia de reducción temprana — el paso decisivo

```r
comercio_mundial <- comercio_mundial %>%
  select(i, k, v) %>%                    # 6 columnas → 3
  group_by(i, k) %>%                     # colapsar dimensión importador
  summarise(valor_miles_usd = sum(v, na.rm = TRUE), .groups = "drop")
```

**Resultado: 11.250.411 → 565.074 filas.** Reducción del 95%.

**Razonamiento:** la VCR se calcula sobre exportaciones totales de un país por producto, sin importar el destino. La dimensión `j` (importador) es información que el indicador no usa. Colapsarla *antes* de cualquier cálculo posterior evita operar sobre once millones de filas en cada paso.

> **Principio general transferible:** identificar qué dimensiones de la base no participan del cálculo final y colapsarlas en el primer paso. Es la diferencia entre un script que corre en segundos y uno que agota la memoria.

### 8.3. `select()` antes de `group_by()`

Reducir columnas antes de agrupar disminuye la carga de memoria de la operación de agrupamiento.

### 8.4. Advertencia al usuario en scripts lentos

```r
cat("Cargando BACI — puede tardar unos segundos...\n")
comercio_mundial <- read_csv("bases/BACI_HS22_Y2024_V202601.csv")
```

### 8.5. Limpieza previa de memoria

```r
rm(list = ls())
```

Ejecutado antes de correr Parte 2 para liberar los objetos de Parte 1.

---

## 9. FUENTES Y BASES DE DATOS — INVENTARIO CON REFERENCIAS

### 9.1. Utilizadas en Módulo 3

| Base | Institución | URL | Descripción |
|---|---|---|---|
| `pib_industrial_mundial.csv` | Fundar / Argendata | https://argendata.fund.ar/ | PIB industrial, 200+ países, 1970–2024, USD constantes. 10.930 filas. Columnas: `anio`, `geocodigoFundar` (ISO3), `geonombreFundar` (español), `industry_gdp` |
| `poblacion.csv` | ONU — División de Estadísticas, Cuentas Nacionales | https://unstats.un.org/unsd/snaama/ | Población por país y año. 12.100 filas. Nombres en inglés, `Population` como `chr` |
| `BACI_HS22_Y2024_V202601.csv` | CEPII | http://www.cepii.fr/CEPII/en/bdd_modele/bdd_modele_item.asp?id=37 | Flujos comerciales año-exportador-importador-producto. HS6. Valores en miles USD, cantidades en toneladas |
| `country_codes_V202601.csv` | CEPII (paquete BACI) | ídem | 238 países. `country_code`, `country_name`, `country_iso2`, `country_iso3` |
| `product_codes_HS22_V202601.csv` | CEPII (paquete BACI) | ídem | 5.609 productos. `code`, `description` |

**Cita académica de BACI:**

> Gaulier, G. y Zignago, S. (2010). *BACI: International Trade Database at the Product-Level. The 1994-2007 Version.* CEPII Working Paper, N°2010-23.

### 9.2. Utilizadas o registradas en Módulo 2

| Base | Institución | Descripción |
|---|---|---|
| `empleo_sectores_base.csv` | Fundar | Estructura productiva LATAM. 6 países (ARG/BOL/CHL/COL/MEX/PER), 1960–2018, 12 sectores. **Base de la entrega M2** |
| `ecopop_base.csv` | Fundar | Economía popular CABA 2023. 1.795 filas, 165 variables. Barrios populares |
| `usu_individual_T324.txt` | INDEC | EPH T3 2024. 47.564 filas, ~180 columnas |
| `base_sipa.csv` | MTESS | Empleo y remuneraciones por provincia, 2009–2024. 5.118 filas |
| `ipc_ceped_data.xlsx` | CEPED-UBA | IPC mensual 2000–2024, base ene2006=100 |
| `gapminder_2000.csv` | Gapminder | 203 países, año 2000. Fertilidad, esperanza de vida, población, mortalidad infantil, PBI |

### 9.3. Bases del taller de cátedra M3 (referencia, no entregadas)

- `empleo_industrial.csv` — Graña y Terranova (2022). Ocupados industria / total economía por región
- `valor_agregado.csv` — ONU. Manufacturing (ISIC D) para ARG/KOR/USA
- `expo_mundiales.csv` — Fundar. Exportaciones por categoría tecnológica (clasificación Lall)

### 9.4. Enlaces institucionales

- Fundar: https://fund.ar/
- Argendata (estructura productiva): https://argendata.fund.ar/topico/estructura-productiva/
- Fundar (economía popular CABA): https://fund.ar/publicacion/economia-popular-caba/
- ONU Cuentas Nacionales: https://unstats.un.org/unsd/snaama/Basic
- CEPII BACI: https://www.cepii.fr/CEPII/en/bdd_modele/bdd_modele_item.asp?id=37

---

## 10. DEBUGGING Y RESOLUCIÓN DE PROBLEMAS

### 10.1. Catálogo de problemas resueltos

| # | Problema | Diagnóstico | Solución |
|---|---|---|---|
| 1 | 1.062 warnings de parsing (M2) | `problems()` → filas separadoras de bloque con 1 columna | `filter(!is.na(anio))` |
| 2 | Aviso de reagrupamiento en `summarise()` | Agrupamiento múltiple sin cierre | `.groups = "drop"` |
| 3 | `Population` como texto | `glimpse()` → tipo `chr` | `as.numeric()` |
| 4 | Nombres de países en distintos idiomas | Comparación de `unique()` de ambas bases | `case_when` (P1) / diccionario ISO3 (P2) |
| 5 | Dos países no encontrados en el filtro | `grepl()` con patrón alternativo | Nombres oficiales completos |
| 6 | Leyenda cortada en el gráfico | Inspección visual del PNG | `legend.position = "right"` + ampliar canvas |
| 7 | Archivo `country_codes` no disponible inicialmente | Verificación de contenido de `bases/` | Localizado y cargado; justificado en el documento |
| 8 | Incertidumbre sobre unidad monetaria | Verificación de orden de magnitud contra dato conocido | Confirmado USD constantes |
| 9 | Base 10× más grande que lo anunciado | `glimpse()` post-carga | Reducción temprana por colapso de dimensión |

### 10.2. Protocolo de debugging consolidado

```
1. Leer el mensaje completo — distinguir Error (detiene) de Warning (no detiene)
2. Aislar: ¿en qué línea exacta ocurre?
3. Inspeccionar el objeto inmediatamente anterior con glimpse()
4. Verificar tipos de datos de las columnas involucradas
5. Verificar valores únicos si el problema es de coincidencia
6. Probar el fix en consola antes de escribirlo en el script
7. Re-ejecutar y verificar contra un valor conocido
```

### 10.3. Verificación por caso testigo

Después de cada transformación relevante, inspeccionar un caso conocido:

```r
pib_participacion %>% filter(iso3 == "ARG") %>% head(5)

comercio_mundial %>% 
  filter(country_iso3 == "ARG") %>% 
  arrange(desc(vcr)) %>% 
  head(10)
```

En el segundo caso, el resultado (aceites de soja, harinas oleaginosas, pescado) confirmó que el cálculo de VCR era correcto: el perfil exportador argentino apareció donde debía.

### 10.4. Validación sustantiva de resultados

Los resultados de ubicuidad se validaron contra la expectativa teórica:

**Más ubicuos (63–114 países):** chatarra de aluminio, cobre, hierro; residuos plásticos y de papel; plantas medicinales; aguas azucaradas → productos de bajo contenido tecnológico.

**Menos ubicuos (1 país):** derivados halogenados de hidrocarburos, alcaloides de cornezuelo, ésteres de fosfito, organofosforados, filetes de pangasius → productos de alta especialización.

La coincidencia con lo que predice la teoría de complejidad económica funcionó como validación del cálculo.

### 10.5. Documentación de decisiones

Toda decisión metodológica no obvia se documenta: en comentarios del script y, si afecta la interpretación, en el documento de análisis.

---

## 11. ESTRUCTURA DE ENTREGA

### 11.1. Plantilla validada (usada en M2 y M3)

```
Apellido_EntregaMn/
├── Apellido_EntregaMn.Rproj
├── script_parte1_[tema].R
├── script_parte2_[tema].R
├── Apellido_EntregaMn_analisis.pdf
├── bases/
│   └── [todos los .csv/.xlsx de entrada]
└── resultados/
    ├── [gráficos .png]
    ├── [tablas .xlsx]
    └── [procesamientos .csv]
```

### 11.2. Requisitos formales verificados en ambos módulos

- `.Rproj` obligatorio
- carpeta `bases/` con los datos de entrada
- carpeta `resultados/` con las salidas
- script(s) con todos los códigos
- nomenclatura `Apellido_EntregaMn`
- compresión ZIP
- envío por formulario Google

### 11.3. Documento de análisis

Requisito M3: *"un archivo pdf o word con el análisis realizado"*.

- **Vía elegida:** Google Docs → insertar PNG y tablas → exportar PDF
- **Alternativa evaluada y descartada por tiempo:** R Markdown / Quarto

Formato aplicado: fuente 11–12 pt, interlineado 1,5, márgenes normales, títulos en negrita.

### 11.4. Contenido del documento M3

1. Encabezado institucional + autor + módulo
2. Sección Parte 1 con dos gráficos y dos párrafos interpretativos
3. Sección Parte 2 con dos tablas y párrafo interpretativo
4. Respuestas a las dos preguntas conceptuales
5. Fuentes y referencias

### 11.5. Consideración sobre el tamaño del ZIP

BACI es una base pesada. Alternativas contempladas:

- **A:** incluirla y verificar aceptación del formulario *(opción usada — aceptada)*
- **B:** excluirla y documentar la URL de descarga en el script

### 11.6. Verificación pre-entrega

```
□ Los scripts corren de principio a fin sin error
□ Todas las rutas son relativas
□ Los archivos exportados están efectivamente en resultados/
□ El PDF está en la raíz
□ La carpeta se llama Apellido_EntregaMn
□ El ZIP se generó desde la carpeta raíz
```

---

# BLOQUE C — SÍNTESIS DE COMPETENCIAS ADQUIRIDAS

### Nivel 1 — Operativo *(consolidado)*

Proyecto, rutas relativas, lectura de CSV/XLSX, `glimpse`, `filter`, `select`, `mutate`, `rename`, exportación con `write_csv` / `ggsave`.

### Nivel 2 — Transformación *(consolidado)*

`group_by` + `summarise` vs `group_by` + `mutate`, `case_when`, `left_join` con claves simples y compuestas, conversión de tipos, `arrange`, `distinct`, `n()`.

### Nivel 3 — Visualización *(consolidado)*

`ggplot` con múltiples mapeos estéticos, `facet_wrap`, control de escalas, personalización de `theme`, exportación parametrizada, diagnóstico visual iterativo.

### Nivel 4 — Diagnóstico *(en consolidación)*

`problems()`, `grepl()` para búsqueda parcial, verificación por caso testigo, validación de órdenes de magnitud, validación sustantiva contra expectativa teórica.

### Nivel 5 — Arquitectura de datos *(introducido)*

Estrategias de puente entre bases sin clave común, reducción temprana de dimensiones en bases masivas, cálculo de indicadores compuestos multinivel (VCR, ubicuidad).

### Pendientes identificados

- `lubridate` y manejo de fechas *(Clase 4 M2, sin script generado)*
- Loops `for` / `while` y automatización *(Clase 4 M2)*
- `pivot_wider` / `pivot_longer` *(visto en script de cátedra, no ejecutado)*
- `gt` y `paletteer` para tablas de presentación *(instalados, no usados)*
- R Markdown / Quarto para documentos reproducibles

---

*Documento cerrado. Módulos 2 y 3 completados. Módulo 3 entregado y aceptado el 27/07/2026.*


Acá va. Cuatro backticks en el envoltorio, igual que antes.


# ADDENDUM AL BALANCE TÉCNICO Y METODOLÓGICO

**Complemento del documento principal — Módulos 2 y 3**
**Diplomatura en Programación en R Aplicada a la Economía — FCE-UBA**
**Adrián Ledesma**

> Este addendum recupera veinte puntos que quedaron fuera del balance principal:
> instrucciones utilizadas pero no documentadas, técnicas presentes en los scripts
> de cátedra que fueron revisados pero no extraídos, metodología de trabajo, y
> los hallazgos sustantivos de la investigación.

---

## ÍNDICE DEL ADDENDUM

- [A. Instrucciones usadas y no documentadas](#a-instrucciones-usadas-y-no-documentadas)
- [B. Técnicas presentes en los scripts de cátedra](#b-técnicas-presentes-en-los-scripts-de-cátedra)
- [C. Metodología de trabajo con IA](#c-metodología-de-trabajo-con-ia)
- [D. Hallazgos sustantivos sistematizados](#d-hallazgos-sustantivos-sistematizados)
- [E. Marcos interpretativos como herramienta](#e-marcos-interpretativos-como-herramienta)

---

# A. INSTRUCCIONES USADAS Y NO DOCUMENTADAS

## A.1. `options(scipen = 999)` — la línea invisible

```r
options(scipen = 999)
```

Presente en **todos** los scripts —los míos y los de cátedra— y omitida del balance principal.

**Qué hace:** desactiva la notación científica en la impresión de números. `scipen` es la penalización que R aplica a la notación científica; un valor alto la vuelve prácticamente imposible.

| Sin `scipen` | Con `scipen = 999` |
|---|---|
| `2.12256e+12` | `2122560637045` |
| `1.5871446` | `1.5871446` |
| `2.3881378e-4` | `0.00023881378` |

**Por qué fue decisivo en este trabajo:** la verificación de orden de magnitud que hicimos sobre `industry_gdp` —confirmar que USA en 2020 daba 2,1 billones y no 2 millones— habría sido imposible de leer en notación científica. La línea que parece cosmética resultó operativa para el diagnóstico de unidades.

**Regla:** primera línea después de las librerías, en todo script que trabaje con datos económicos.

---

## A.2. `head()` + `tail()` como par de diagnóstico

Usado sobre `ubicuidad` para inspeccionar simultáneamente ambos extremos de una distribución ordenada:

```r
ubicuidad <- comercio_mundial %>%
  filter(vcr > 1) %>%
  group_by(producto) %>%
  summarise(n_paises_vcr = n(), .groups = "drop") %>%
  arrange(desc(n_paises_vcr))

head(ubicuidad, 10)   # los más ubicuos
tail(ubicuidad, 10)   # los menos ubicuos
```

**Valor diagnóstico:** en una base ordenada, `head` y `tail` juntos muestran el rango completo del fenómeno. Si `head` da 114 países y `tail` da 1, la distribución tiene el sesgo que la teoría predice. Si ambos dieran valores similares, algo estaría mal en el cálculo.

**Diferencia con `top10_*`:** `tail()` devuelve las últimas filas en el orden existente; `arrange(n_paises_vcr) %>% head(10)` reordena ascendente y toma las primeras. Para el archivo exportado se usó la segunda forma porque garantiza el orden dentro de la tabla.

---

## A.3. Instalación de paquetes y lectura de sus avisos

```r
install.packages("writexl")
install.packages("gt")
install.packages("paletteer")
```

**Comportamiento normal durante la instalación:** texto en rojo en consola. **No es error.** Son logs de compilación, descarga y verificación de dependencias.

**Aviso encontrado en esta sesión:**

```
Aviso:
package 'writexl' was built under R version 4.6.1
```

**Lectura correcta:** el paquete fue compilado bajo una versión de R ligeramente posterior a la instalada (4.6.0). Es un aviso de compatibilidad, no un fallo. El paquete funciona. Solo importa si el paquete usa características introducidas en la versión posterior, lo cual es infrecuente en paquetes maduros.

**Cuándo sí preocuparse:**

| Mensaje | Gravedad |
|---|---|
| `Aviso: ... was built under R version X` | Ninguna |
| `Warning: package 'X' is not available` | Alta — el paquete no existe o el nombre está mal |
| `Error: installation of package 'X' had non-zero exit status` | Alta — falló la compilación |

---

## A.4. `library()` como verificación de instalación

Método usado para confirmar que los tres paquetes habían quedado efectivamente instalados:

```r
library(writexl)
library(gt)
library(paletteer)
```

**Lógica:** si el paquete no está instalado, `library()` devuelve error explícito:

```
Error in library(writexl) : there is no package called 'writexl'
```

Si carga —aunque emita avisos— está instalado y disponible.

**Distinción conceptual:**

- `install.packages()` — descarga e instala. **Una vez por máquina.**
- `library()` — carga el paquete en la sesión activa. **Una vez por sesión**, al inicio del script.

---

# B. TÉCNICAS PRESENTES EN LOS SCRIPTS DE CÁTEDRA

> Las siguientes técnicas están resueltas y disponibles en el material del taller
> (`cadenas.R`, `vcr completo.R`, `clase_4_taller_integrador.R`). Fueron revisadas
> durante el trabajo pero no incorporadas a la entrega. Constituyen repertorio
> inmediatamente disponible.

---

## B.1. `source()` — modularización de scripts

De `Taller VCR.R` y `vcr completo.R`:

```r
source("cadenas.R")
```

**Qué hace:** ejecuta el contenido completo de otro script `.R` como si estuviera escrito en ese punto. Los objetos que ese script crea quedan disponibles en el Environment.

**Para qué sirve:**

1. Aislar bloques largos que no cambian (definiciones de agrupaciones, diccionarios, funciones auxiliares)
2. Reutilizar el mismo bloque en varios scripts sin duplicar código
3. Mantener el script principal legible

**Estructura implicada en el taller:**

```
Taller P.2/
├── Taller P.2.Rproj
├── vcr completo.R      ← script principal, invoca a cadenas.R
├── cadenas.R           ← módulo: define comercio_cadenas
└── BACI/
    └── [bases]
```

**Requisito:** el script invocado debe usar rutas relativas al proyecto, no al script. Con `.Rproj` activo esto se cumple automáticamente.

**Aplicación posible a mi trabajo:** el bloque de recodificación de países de la Parte 1 (el `case_when` de 9 países × 2 columnas, ~30 líneas) podría haber ido a `paises.R` e invocarse con `source("paises.R")`.

---

## B.2. `complete()` — grilla completa de combinaciones

De `cadenas.R`:

```r
library(tidyr)

comercio_cadenas <- comercio_cadenas %>%
  complete(
    pais,
    cadena,
    fill = list(valor = 0)
  )
```

**Problema que resuelve:** después de `group_by(pais, cadena) %>% summarise(...)`, solo existen las combinaciones que aparecen en los datos. Si Bolivia no exporta semiconductores, la fila `BOL × Semiconductores` **no existe** —no es que valga cero, sencillamente no está.

**Consecuencia si no se corrige:**

- Las tablas pivoteadas quedan con `NA` en lugar de `0`
- Los gráficos de barras omiten categorías en lugar de mostrarlas vacías
- Los cálculos de participación dan resultados incorrectos

**Qué hace `complete()`:** genera el producto cartesiano de las variables indicadas y rellena las combinaciones faltantes con el valor especificado en `fill`.

```
ANTES                          DESPUÉS
pais  cadena          valor    pais  cadena          valor
ARG   Soja            9754     ARG   Soja            9754
ARG   Autos           1200     ARG   Litio              0   ← creada
BOL   Litio            340     ARG   Autos           1200
                               ARG   Semiconductores    0   ← creada
                               BOL   Soja               0   ← creada
                               BOL   Litio            340
                               BOL   Autos              0   ← creada
                               BOL   Semiconductores    0   ← creada
```

**Distinción con `replace_na()`:** `replace_na()` reemplaza NAs en filas existentes; `complete()` **crea** las filas que faltan.

---

## B.3. `factor()` con `levels` explícitos — orden sustantivo

De `cadenas.R`:

```r
mutate(
  cadena = factor(cadena,
                  levels = c(
                    "Soja",
                    "Litio",
                    "Autos",
                    "Semiconductores",
                    "Nuclear",
                    "Espacial"
                  )
  )
)
```

**Problema que resuelve:** R ordena las variables de texto alfabéticamente. En un gráfico o tabla, las cadenas aparecerían como: Autos, Espacial, Litio, Nuclear, Semiconductores, Soja. Orden sin ningún sentido analítico.

**Qué hace:** convierte la variable en factor y fija el orden de sus niveles según un criterio sustantivo —en este caso, **nivel de complejidad tecnológica ascendente**.

**Dónde impacta el orden del factor:**

- Orden de las barras en `geom_col()`
- Orden de las categorías en la leyenda
- Orden de las filas en tablas
- Orden de los paneles en `facet_wrap()`

**Aplicación posible a mi trabajo:** los tres grupos regionales (`América Latina`, `Asia Oriental`, `Desarrollados tradicionales`) aparecieron en la leyenda en orden alfabético. Un `factor()` con `levels` los habría ordenado según el eje analítico del trabajo —por ejemplo: centro tradicional / ascenso asiático / periferia latinoamericana.

```r
# Mejora posible, no aplicada
mutate(grupo = factor(grupo, levels = c(
  "Desarrollados tradicionales",
  "Asia Oriental",
  "América Latina"
)))
```

---

## B.4. `distinct(.keep_all = TRUE)` — colapsar conservando columnas

De `vcr completo.R`:

```r
comercio_mundial <- comercio_mundial %>% 
  select(-producto, -valor_miles_usd) %>% 
  distinct(pais, .keep_all = TRUE)
```

**Contexto:** después de calcular `expo_total_pais` y `expo_totales` con `group_by() %>% mutate()`, cada país aparece repetido en tantas filas como productos exporta. Para pegar esos totales a otra base se necesita **una fila por país**.

**Qué hace:**

- `distinct(pais)` sin más → devuelve solo la columna `pais`
- `distinct(pais, .keep_all = TRUE)` → devuelve **la primera fila completa** de cada valor único de `pais`, con todas sus columnas

**Por qué funciona acá:** como `expo_total_pais` y `expo_totales` son idénticos en todas las filas del mismo país, tomar la primera es equivalente a tomar cualquiera.

**Alternativa con `summarise`:**

```r
group_by(pais) %>%
  summarise(across(everything(), first))
```

Más explícita pero más verbosa. `distinct(.keep_all = TRUE)` es el idiom estándar para este caso.

**Precaución:** solo es correcto cuando las columnas que se conservan son constantes dentro del grupo. Si varían, `distinct` toma la primera arbitrariamente y el resultado es silenciosamente incorrecto.

---

## B.5. `pivot_wider()` — de formato largo a ancho

De `vcr completo.R`:

```r
vcr_seleccion_tabla <- vcr_seleccion %>% 
  select(country_iso3, cadena, IVCRnorm) %>% 
  pivot_wider(
    names_from  = country_iso3,
    values_from = IVCRnorm
  )
```

**Qué hace:**

```
FORMATO LARGO (tidy)              FORMATO ANCHO (presentación)
country_iso3  cadena   IVCRnorm   cadena           ARG   BRA   CHN   USA
ARG           Soja       0.82     Soja            0.82  0.71 -0.45 -0.12
ARG           Autos     -0.31     Litio          -0.88  0.34  0.55 -0.20
BRA           Soja       0.71     Autos          -0.31  0.12  0.41  0.28
BRA           Autos      0.12     Semiconductores -0.95 -0.87  0.62  0.44
...
```

**Argumentos:**

- `names_from` — la columna cuyos valores se convierten en **nombres de columna**
- `values_from` — la columna cuyos valores **rellenan** la grilla

**Cuándo usarlo:** el formato largo es el correcto para procesar y graficar (es el que ggplot espera). El formato ancho es el correcto para **presentar** —una tabla que un lector humano recorre con la vista.

**Regla operativa:** procesar en largo, pivotear a ancho solo en el último paso, exclusivamente para presentación.

**Inversa:** `pivot_longer()` va de ancho a largo. Necesario cuando la base viene con años o categorías como columnas.

**Complemento indispensable:** `complete()` antes de pivotear. Sin grilla completa, `pivot_wider()` deja `NA` en las celdas faltantes.

---

## B.6. Bloque `gt()` — tabla de presentación con formato

De `vcr completo.R`, resuelto línea por línea:

```r
library(gt)
library(paletteer)

vcr_seleccion_tabla %>% 
  gt() %>% 
  tab_header(
    title    = "VENTAJAS COMPARATIVAS REVELADAS",
    subtitle = "en cadenas productivas seleccionadas"
  ) %>% 
  cols_label("cadena" = "Cadenas de productos") %>% 
  cols_align(
    align   = "left",
    columns = cadena
  ) %>% 
  data_color(
    columns = paises_seleccionados,
    method  = "numeric",
    palette = paletteer_d("rcartocolor::BluYl", direction = -1),
    domain  = c(-1, 1)
  ) %>% 
  tab_source_note("Fuente: Elaboración propia con base en datos CEPII")
```

**Desglose de cada función:**

| Función | Rol |
|---|---|
| `gt()` | Convierte el data frame en objeto tabla formateable |
| `tab_header(title, subtitle)` | Encabezado de la tabla |
| `cols_label()` | Renombra columnas **solo para la vista** —no altera los datos |
| `cols_align(align, columns)` | Alineación por columna; texto a la izquierda, números a la derecha |
| `data_color()` | Mapa de calor sobre las celdas numéricas |
| `tab_source_note()` | Nota de fuente al pie |

**Sobre `data_color()`:**

- `method = "numeric"` — escala continua, no categórica
- `palette = paletteer_d("rcartocolor::BluYl", direction = -1)` — paleta del paquete `rcartocolor` vía `paletteer`; `direction = -1` invierte el gradiente
- `domain = c(-1, 1)` — **fija el rango de la escala explícitamente**. Sin esto, la escala se ajusta al mínimo y máximo observados, lo que hace incomparables dos tablas distintas. Como el IVCR normalizado va de −1 a 1 por construcción, fijar el dominio es obligatorio.

**Sobre `paletteer`:** paquete-agregador que da acceso unificado a cientos de paletas de decenas de paquetes. Sintaxis: `paletteer_d("paquete::paleta")` para discretas, `paletteer_c()` para continuas.

**Estado en mi trabajo:** `gt` y `paletteer` fueron instalados pero no utilizados. La consigna del M3 pedía exportación en `.xlsx`, no tabla formateada. Quedan disponibles para trabajos donde la presentación tabular importe.

---

## B.7. Índice base 100 — subsetting condicional dentro de `mutate()`

De `clase_4_taller_integrador.R`:

```r
valor_agregado <- valor_agregado %>%
  group_by(País) %>%
  mutate(
    indice_VA_industrial_pc = VA_industrial_pc / VA_industrial_pc[Año == 1970] * 100
  ) %>%
  ungroup()
```

**Técnica no trivial:** `VA_industrial_pc[Año == 1970]` extrae, **dentro de cada grupo**, el valor de la variable en el año base. Ese escalar divide a toda la serie del grupo.

**Anatomía:**

```r
group_by(País)                      # define el ámbito del subsetting
  mutate(
    indice = variable /             # numerador: cada valor de la serie
             variable[Año == 1970]  # denominador: el valor del año base DEL GRUPO
             * 100                  # escala a base 100
  )
```

**Por qué es potente:** resuelve en una línea lo que de otro modo requiere crear una tabla auxiliar con los valores base y hacer un `left_join`.

**Qué permite analíticamente:** comparar **trayectorias** en lugar de **niveles**. Dos países con PIB per cápita muy distinto pueden compararse en su dinámica: quién creció más rápido desde el mismo punto de partida normalizado.

**Aplicación directa a mi trabajo:** el gráfico 2 (PIB industrial per cápita en USD constantes) muestra niveles. Un tercer gráfico con índice base 1970 = 100 habría mostrado que Corea del Sur multiplicó su PIB industrial per cápita por un factor enormemente superior al de cualquier otro país de la muestra —dato que el gráfico de niveles oculta parcialmente porque Corea parte de un valor bajo.

```r
# Extensión no realizada
pib_percapita <- pib_percapita %>%
  group_by(iso3) %>%
  mutate(indice_pc = pib_industrial_pc / pib_industrial_pc[anio == 1970] * 100) %>%
  ungroup()
```

**Precaución:** si el año base tiene `NA` o no existe para algún grupo, el índice completo de ese grupo queda `NA`. Verificar con `filter(!is.na(variable))` antes.

---

## B.8. `geom_col(position = "stack")` — composición acumulada

De `clase_4_taller_integrador.R`:

```r
grafico_participacion <- empleo_industrial_regional %>%
  ggplot(aes(x = Año, 
             y = participacion_empleo_industrial_regional * 100, 
             fill = Regiones.economicas)) +
  geom_col(position = "stack") +
  labs(
    title    = "Participación del empleo industrial por región económica",
    subtitle = "(1978–2018)",
    caption  = "Fuente: Graña y Terranova (2022)",
    x        = "Año",
    y        = "Participación (%)",
    fill     = "Regiones económicas"
  ) +
  scale_x_continuous(
    breaks = seq(1978, 2018, by = 4),
    expand = c(0, 0)
  ) +
  theme_classic()
```

**Opciones de `position` en `geom_col`:**

| Valor | Efecto |
|---|---|
| `"stack"` | Apila los segmentos; la altura total es la suma. **Muestra composición** |
| `"dodge"` | Barras lado a lado. **Compara magnitudes** |
| `"fill"` | Apila normalizando a 100%. **Muestra proporción, oculta el total** |

**Cuándo elegir cada uno:**

- Si la pregunta es *"¿cómo se reparte el total?"* → `stack`
- Si la pregunta es *"¿quién tiene más?"* → `dodge`
- Si la pregunta es *"¿cómo cambió la proporción, con independencia del volumen?"* → `fill`

**Diferencia con mi enfoque:** usé `geom_line` con 9 series superpuestas. `geom_col(position = "stack")` con los 3 grupos regionales agregados habría mostrado la **recomposición** de la industria mundial de forma más inmediata —el bloque asiático desplazando visualmente al bloque desarrollado a lo largo del eje temporal.

**Nota sobre `expand = c(0, 0)`:** elimina el margen que ggplot agrega por defecto en los extremos del eje. En gráficos de columnas apiladas evita el espacio en blanco antinatural en los bordes.

---

## B.9. Clasificación tecnológica Lall

De `clase_4_taller_integrador.R`, variable `lall_desc_full` de la base `expo_mundiales.csv` (Fundar):

```r
expo_industria <- expo_mundiales %>%
  filter(lall_desc_full %in% c(
    "Manufacturas basadas en recursos naturales",
    "Manufacturas de baja tecnología",
    "Manufacturas de media tecnología",
    "Manufacturas de alta tecnología"
  ))
```

**Qué es:** taxonomía de Sanjaya Lall (2000) que clasifica las exportaciones según intensidad tecnológica. Categoría analítica estándar en estudios de desarrollo industrial y complejidad económica.

**Categorías completas del esquema:**

| Categoría | Ejemplos |
|---|---|
| Productos primarios | Granos, minerales sin procesar, petróleo crudo |
| Manufacturas basadas en RRNN | Aceites vegetales, harinas, alimentos procesados, metales refinados |
| Manufacturas de baja tecnología | Textiles, calzado, juguetes, muebles |
| Manufacturas de media tecnología | Automotriz, maquinaria, química industrial |
| Manufacturas de alta tecnología | Electrónica, farmacéutica, aeroespacial, instrumentos de precisión |

**Relación directa con el ejercicio de ubicuidad:**

La clasificación Lall y el índice de ubicuidad miden dimensiones convergentes desde ángulos distintos:

- **Lall** clasifica *a priori*, por atributo tecnológico del producto
- **Ubicuidad** clasifica *a posteriori*, por cuántos países logran exportarlo con VCR

Los resultados que obtuve confirman la convergencia:

| Ubicuidad medida | Categoría Lall correspondiente |
|---|---|
| Chatarra de aluminio (114 países) | Basadas en RRNN / primarios |
| Residuos plásticos (76 países) | Basadas en RRNN |
| Aguas azucaradas (73 países) | Baja tecnología |
| Alcaloides farmacéuticos (1 país) | Alta tecnología |
| Derivados halogenados (1 país) | Alta tecnología |

**Nota metodológica:** la conexión entre ambos indicadores podría haber sido explicitada en el documento de análisis del M3. La ubicuidad **valida empíricamente** lo que Lall clasifica taxonómicamente.

**Referencia:** Lall, S. (2000). *The Technological Structure and Performance of Developing Country Manufactured Exports, 1985-98.* Oxford Development Studies, 28(3).

---

## B.10. `ggplotly()` — interactividad

De `clase_4_taller_integrador.R`:

```r
library(plotly)

grafico <- datos %>% ggplot(aes(...)) + geom_line()

grafico              # versión estática
ggplotly(grafico)    # versión interactiva
```

**Qué agrega:** tooltips al pasar el cursor, zoom, pan, aislamiento de series haciendo clic en la leyenda, descarga como PNG desde el navegador.

**Dónde se ve:** panel Viewer de RStudio (no Plots).

**Limitación operativa:** el objeto resultante es HTML, no imagen. `ggsave()` no funciona sobre él. Para conservarlo:

```r
htmlwidgets::saveWidget(ggplotly(grafico), "resultados/grafico_interactivo.html")
```

**Por qué no se usó en la entrega:** ambas consignas pedían gráficos exportados a la carpeta `resultados/` en formato imagen, insertables en un documento PDF. La interactividad no era aprovechable en ese soporte.

**Cuándo sí conviene:** presentaciones en pantalla, dashboards, exploración de datos con muchas series donde el aislamiento por clic ayuda a leer.

---

## B.11. Eliminación de años sin datos

De `clase_4_taller_integrador.R`:

```r
# Eliminamos el año 1999, ya que no hay datos para China
empleo_industrial <- empleo_industrial %>% 
  filter(Año != 1999)
```

**Técnica trivial, decisión metodológica no trivial.**

**El problema:** si un país tiene un hueco en la serie, cualquier agregación por año produce un total inconsistente —el mundo de 1999 sería un mundo sin China.

**Las opciones:**

| Opción | Consecuencia |
|---|---|
| Eliminar el año completo | Serie consistente, pierde un punto |
| Dejar el `NA` con `na.rm = TRUE` | Total de ese año subestimado — **error silencioso** |
| Interpolar | Introduce dato no observado |

**La decisión de cátedra:** eliminar el año. Y —lo relevante— **documentarla en el comentario**.

**Aplicación a mi trabajo:** el `filter(!is.na(poblacion))` que apliqué después del join cumple función análoga. La diferencia es que el mío eliminó filas país-año individuales; el de cátedra elimina el año completo para todos los países.

> **Criterio general:** cuando se agrega sobre grupos, la ausencia de un miembro
> del grupo en un período distorsiona el total. Eliminar el período completo
> preserva la comparabilidad de la serie agregada.

---

# C. METODOLOGÍA DE TRABAJO CON IA

---

## C.1. Protocolo de delimitadores jerárquicos

Método desarrollado para transmitir estructuras de carpetas complejas con contenido anidado sin ambigüedad.

**Sintaxis:**

```
#TRABAJAREMOS AL MENOS CON ESTO PARA EL TALLER INTEGRADOR#
##Carpeta: Complejidad Economica → (--SubCarpeta: BACI + --Archivos)
###ABRE_SUB_BACI
[ contenido anidado, muestras de archivos ]
###CIERRA_SUB_BACI
###ABRE_ARCHIVOS
#ABRE cadenas.R
[ código completo ]
#CIERRA cadenas.R
###CIERRA_ARCHIVOS
##Carpeta: Desindustrialización y NDIT
#ACTIVIDAD INTEGRADORA MODULO 3
```

**Regla explícita que acompañó el envío:**

> *"Considerá la jerarquía de las almohadillas SOLO cuando no están entre corchetes
> o llaves. Lo que está dentro de esos conjuntos, leelo contextualmente, incluso si
> uno faltara, tratando de entender que el verdadero índice es este: [...] y el
> resto son almohadillas contextuales o bien markdowns heredados."*

**Por qué funcionó:** el problema de pegar código dentro de un mensaje estructurado en Markdown es que los `#` del código (comentarios de R) colisionan con los `#` de la jerarquía de títulos. La regla resuelve la ambigüedad: los `#` dentro de delimitadores `ABRE/CIERRA` son comentarios; los de afuera son estructura.

**Verificación solicitada:** se pidió devolución estructurada con marcador de confirmación (🟩) por cada elemento captado. Eso permitió detectar antes de empezar que había un archivo (`Taller P.2.Rproj`) sin contenido relevante y otro (`country_codes`) cuya disponibilidad había que confirmar.

**Transferibilidad:** aplicable a cualquier situación donde haya que transmitir estructura + contenido heterogéneo en un solo mensaje.

---

## C.2. Paso a paso vs bloque completo — el tradeoff

Ambas modalidades se usaron en el mismo trabajo, deliberadamente.

### Modalidad A — Paso a paso *(usada en Parte 1)*

```
Instrucción → ejecución → reporte de resultado → verificación → siguiente
```

| Ventaja | Costo |
|---|---|
| Cada error se detecta en el momento | Alto consumo de contexto |
| El estado del objeto se verifica antes de seguir | Muchos turnos |
| Se aprende el mecanismo, no solo el resultado | Lento |

**Cuándo:** territorio desconocido, bases con estructura no verificada, técnicas nuevas.

**Casos donde salvó el trabajo en Parte 1:**

- Detectar que `Population` era `chr` antes de intentar dividir
- Descubrir que los nombres de países estaban en idiomas distintos antes de armar el join
- Encontrar que `"China"` y `"United Kingdom"` no existían con esos nombres exactos

### Modalidad B — Bloque completo *(usada en Parte 2)*

```
Código completo → ejecución → reporte de errores → corrección puntual
```

| Ventaja | Costo |
|---|---|
| Muy económico en contexto | Un error temprano invalida todo lo posterior |
| Rápido | Menor comprensión del mecanismo |

**Cuándo:** el patrón ya está validado, hay presión de tiempo, se dispone de script de referencia.

**Por qué funcionó en Parte 2:** existía `vcr completo.R` como referencia validada por la cátedra. El código no se estaba inventando: se estaba adaptando uno que ya funcionaba.

### Regla derivada

> **Paso a paso donde no sabés qué vas a encontrar.
> Bloque completo donde el patrón ya está validado.**

---

## C.3. Estrategia de modelo y gestión de sesiones

**Asignación por tipo de tarea:**

| Tarea | Modelo |
|---|---|
| Código iterativo, debugging, paso a paso | Sonnet |
| Síntesis densa, balance estructurado, redacción extensa | Opus |

**Gestión de contexto:**

1. Conversaciones separadas por tema — no acumular todo en una sesión
2. Al abrir sesión nueva, pegar bloque de contexto en texto plano
3. Solicitar resumen estructurado **antes** de agotar el contexto, no después
4. Texto plano en lugar de formato rico cuando el contexto aprieta

**Señal de alerta operativa:** cuando aparece la preocupación *"¿me alcanza el contexto para terminar?"*, ya es momento de pedir el resumen y abrir sesión nueva. Esperar más implica riesgo de perder el hilo a mitad de trabajo.

**Aplicación concreta en esta sesión:** el balance principal se solicitó explícitamente antes de cerrar, con la indicación de continuar en sesión nueva con modelo superior.

---

## C.4. Detectabilidad de escritura asistida

**Discusión sostenida sobre los párrafos de análisis del M3.**

**Estimación:** 70–80% detectable como asistido, principalmente en los párrafos largos de interpretación.

**Marcadores que elevan la detectabilidad:**

- Fluidez uniforme sin variación de ritmo
- Simetría estructural excesiva entre párrafos
- Exhaustividad sin jerarquía —todo dicho con el mismo peso
- Ausencia de vacilación, de rodeo, de reformulación
- Cierres siempre concluyentes

**Vías de reducción identificadas:**

1. Romper alguna oración larga en dos cortas
2. Introducir una observación personal sobre el proceso de trabajo con los datos
3. Dejar una imprecisión controlada o una duda explícita
4. Variar el largo de los párrafos
5. Referir a algo específico de la cursada o del propio recorrido

**Consideración contextual:** en una diplomatura en R aplicada, el foco de corrección está en el código, no en el ensayo. La consigna del M3 lo explicita: *"la motivación del ejercicio y el espíritu de corrección se centran en el proceso pedagógico detrás del módulo y en el uso de R"*.

---

## C.5. Los quince marcadores de estilo

Lista de rasgos de escritura propia, provista como restricción para la redacción del análisis. Registrada acá por ser el instrumento que hizo que el texto sonara propio.

### Estructura y organización

1. **Apertura por enumeración de ejes** — anunciar los factores del análisis antes de desarrollarlos (*"debe tener en cuenta al menos una serie de factores: ..."*)
2. **Estructura contrastiva explícita** del tipo *"mientras que para X... para Y..."* — recurso central para plantear clivajes entre corrientes o posiciones
3. **Cierres de párrafo con tesis sintética** — cada bloque termina en formulación fuerte y cerrada, no en acumulación de datos
4. **Pregunta retórica autorrespondida como bisagra estructural** — introduce enumeración o desarrollo técnico (*"¿Cómo se da el ajuste? Tiene dos vías..."*), no es recurso dialógico real

### Sintaxis y registro

5. **Sintaxis hipotáctica extensa** — oraciones largas con subordinadas encadenadas (causales con *"por cuanto"*, relativas, concesivas) en vez de períodos cortos
6. **"Entonces" como conector de retomada** — dentro o al inicio de la oración, marcando consecución lógica dentro de un mismo párrafo expositivo
7. **Matización retórica por gradación** — litotes (*"no pocas veces"*), pares del tipo *"en el mejor de los casos... en el peor..."*, conectores formales (*"en realidad"*, *"más bien"*)
8. **Hedge oral insertado en frase formal** — expresiones como *"podríamos decir"* que se cuelan en medio de una oración de registro académico; rastro de oralidad en la escritura expositiva
9. **Inciso entre rayas que atribuye autoría de un concepto en aposición** — comentario lateral sobre la marcha (*"—distinción que constituye, en sí misma, un aporte del propio Salter—"*)

### Movimiento argumentativo

10. **Elevación teórica del problema aplicado** — pasar de la pregunta puntual a una afirmación sobre el núcleo epistemológico de la disciplina; generalizar lo aplicado hacia lo ontológico

### Léxico y aparato erudito

11. **Siglas definidas in situ y reutilizadas**, con la fórmula fija *"de ahora en más"* (TTI, VC, EPD, IB/EB, TCR)
12. **Compulsión de siglado** — tendencia a acuñar sigla para cualquier término técnico recurrente, incluso de uso único
13. **Cadenas de autores sin aparato de cita completo** — corrientes o autores agrupados entre paréntesis, asumiendo reconocimiento del lector
14. **Léxico técnico específico sin glosa** — vocabulario tratado como compartido con el corrector
15. **Cambio de código al inglés a mitad de oración** para terminología técnica puntual, sin cursiva ni traducción

### Aplicación verificable en el documento del M3

| Marcador | Instancia |
|---|---|
| 2 | *"mientras que para los países desarrollados tradicionales [...] para los países del este asiático"* |
| 5 | Períodos de 60+ palabras con subordinación encadenada |
| 6 | *"Entonces, lo que el gráfico muestra no es únicamente..."* |
| 7 | *"en el mejor de los casos [...] en el peor"*; *"no pocas veces"*; *"más bien"* |
| 8 | *"Podríamos decir, entonces, que..."* |
| 9 | *"—distinción que la NDIT permite precisar—"* |
| 11 | NDIT, VCR, TCE definidas in situ |
| 15 | *catching-up*, *upgrading* sin cursiva ni traducción |

---

# D. HALLAZGOS SUSTANTIVOS SISTEMATIZADOS

---

## D.1. Participación en el PIB industrial mundial (1970–2024)

**Fuente:** Fundar / Argendata. USD constantes. Muestra: 9 países.

| País | 1970 | 2024 | Movimiento |
|---|---|---|---|
| **Estados Unidos** | ~28% | ~16% | −12 p.p. |
| **China** | ~0% | >30% | +30 p.p. |
| **Japón** | ~10% | ~6,5% | Pico ~14% (1991), luego declive |
| **Francia** | ~4% | ~2% | Contracción sostenida |
| **Reino Unido** | ~4,5% | ~1,5% | Contracción sostenida |
| **Argentina** | ~1,6% | ~1% | Estancamiento con leve declive |
| **Brasil** | ~2,5% | ~2% | Estancamiento |
| **México** | ~2% | ~2% | Estancamiento |
| **Corea del Sur** | ~0,5% | ~3,5% | Ascenso sostenido |

**Puntos de inflexión identificados:**

- **c. 1991** — Japón alcanza su máximo histórico (~14%) e inicia el descenso
- **c. 2001** — China acelera tras el ingreso a la OMC; la pendiente se empina notoriamente
- **c. 2009–2010** — **cruce China / Estados Unidos**: China supera a EEUU en participación en el PIB industrial mundial
- **2010–2024** — China continúa la expansión; EEUU se estabiliza en torno al 15–16%

**Lectura estructural:** el gráfico no registra industrialización generalizada sino **redistribución geográfica** de una masa industrial mundial. La suma de la participación de los tres desarrollados tradicionales cae de ~36% a ~20%; la suma del bloque asiático pasa de ~11% a ~40%.

**El caso latinoamericano:** ARG, BRA y MEX no muestran caída abrupta sino **planicie**. En un mundo donde la torta se redistribuye, mantener la porción constante equivale a no participar del proceso. Es marginalización por inmovilidad relativa.

---

## D.2. PIB industrial per cápita (1970–2024)

**Fuente:** Fundar (PIB industrial) + ONU División de Estadísticas (población). USD constantes.

| País | 1970 (aprox.) | 2024 (aprox.) | Factor |
|---|---|---|---|
| **Corea del Sur** | ~150 | ~10.000 | ×66 |
| **Japón** | ~2.700 | ~8.000 | ×3 |
| **Estados Unidos** | ~3.800 | ~6.700 | ×1,8 |
| **Francia** | ~2.400 | ~4.000 | ×1,7 |
| **Reino Unido** | ~2.300 | ~4.100 | ×1,8 |
| **China** | ~50 | ~3.400 | ×68 |
| **Argentina** | ~1.885 | ~2.000 | ×1,06 |
| **México** | ~1.100 | ~2.100 | ×1,9 |
| **Brasil** | ~600 | ~850 | ×1,4 |

**Hallazgo central —el cruce Corea/Argentina:**

En 1970 Corea del Sur tenía un PIB industrial per cápita **inferior al argentino** (~150 vs ~1.885 USD constantes). En 2024 lo quintuplica largamente (~10.000 vs ~2.000).

Corea multiplicó su PIB industrial per cápita por un factor cercano a 66. Argentina, por 1,06.

**Sobre China —la corrección poblacional:** China lidera ampliamente en participación agregada (>30%) pero queda en la franja media-baja en términos per cápita (~3.400). La masa poblacional opera como divisor. El contraste entre ambos gráficos es la mejor ilustración de por qué los indicadores agregados y per cápita responden preguntas distintas.

**Sobre Estados Unidos —desindustrialización relativa:** su per cápita crece, pero menos que el de sus competidores asiáticos, y su participación mundial cae. La desindustrialización estadounidense es **relativa**, no absoluta: sigue produciendo más que antes, pero pesa menos en un mundo donde otros crecieron mucho más rápido.

**El estancamiento latinoamericano:** ARG, BRA y MEX describen la misma forma —oscilación en torno a un nivel sin tendencia ascendente clara. En términos relativos, es retroceso sostenido frente a economías que sí acumularon base industrial.

---

## D.3. Ubicuidad de productos (BACI HS22, 2024)

**Base procesada:** 11.250.411 flujos comerciales → 565.074 pares país-producto → **5.606 productos** con al menos un exportador con VCR > 1.

### Los diez más ubicuos

| Rango | Código HS6 | Producto | Países con VCR |
|---|---|---|---|
| 1 | 760200 | Aluminio: desechos y chatarra | **114** |
| 2 | 740400 | Cobre: desechos y chatarra | **108** |
| 3 | 720449 | Desechos y chatarra ferrosos n.c.p. | **99** |
| 4 | 854911 | Desechos de acumuladores de plomo-ácido | **95** |
| 5 | 970539 | Colecciones y piezas de coleccionista, interés numismático | **87** |
| 6 | 121190 | Plantas y partes de plantas (perfumería, farmacia) | **76** |
| 7 | 391590 | Plásticos: desechos, recortes y desperdicios | **76** |
| 8 | 720410 | Desechos y chatarra de fundición | **74** |
| 9 | 220210 | Aguas minerales y gaseadas con azúcar añadido | **73** |
| 10 | 470710 | Papel o cartón: desechos de papel kraft sin blanquear | **63** |

**Patrón:** siete de diez son **residuos, desechos o chatarra**. Los otros tres son plantas medicinales, bebidas azucaradas y coleccionables numismáticos. Ningún producto manufacturado complejo.

### Los diez menos ubicuos

| Código HS6 | Producto | Países con VCR |
|---|---|---|
| 010231 | Búfalos vivos, reproductores de raza pura | 1 |
| 030462 | Filetes congelados de pangasius/siluro | 1 |
| 160417 | Preparaciones de anguila | 1 |
| 290375 | Derivados halogenados de hidrocarburos acíclicos (dos o más halógenos) | 1 |
| 290436 | Fluoruro de perfluorooctano sulfonilo | 1 |
| 292023 | Ésteres de fosfito y sus sales | 1 |
| 293154 | Derivados organofosforados halogenados: triclorfón (ISO) | 1 |
| 293336 | Compuestos heterocíclicos con anillo de piridina sin condensar | 1 |
| 293963 | Alcaloides del cornezuelo de centeno, ácido lisérgico y sus sales | 1 |
| 382713 | Mezclas con derivados halogenados de metano, etano o propano | 1 |

**Patrón:** siete de diez son **compuestos químicos de síntesis compleja**. Los otros tres son nichos acuícolas y ganaderos de altísima especificidad.

### Validación del cálculo por caso testigo

Perfil de VCR más altos para Argentina, obtenido en la verificación:

| Código | Producto | VCR relativa |
|---|---|---|
| 320110 | Extracto de quebracho | Muy alta |
| 150710 | Aceite de soja en bruto | Muy alta |
| 090300 | Yerba mate | Muy alta |
| 150790 | Aceite de soja refinado | Alta |
| 230400 | Tortas y residuos de aceite de soja | Alta |
| 230250 | Residuos de leguminosas | Alta |

El resultado es coincidente con el perfil exportador argentino conocido. La coincidencia funcionó como validación del cálculo de VCR.

### Interpretación

La distribución de la ubicuidad es fuertemente asimétrica: un conjunto pequeño de productos que casi cualquier economía puede exportar con ventaja, y una cola larga de productos que solo una economía en el mundo logra exportar con ventaja.

Los productos ubicuos requieren capacidades ampliamente disponibles —extraer, procesar mínimamente, recolectar. Los productos no ubicuos requieren capacidades tecnológicas acumuladas, marcos regulatorios específicos, cadenas de proveedores especializadas.

---

# E. MARCOS INTERPRETATIVOS COMO HERRAMIENTA

---

## E.1. Nueva División Internacional del Trabajo (NDIT)

**Referencia base del módulo:** Fröbel, F., Heinrichs, J. y Kreye, O. (1980). *La nueva división internacional del trabajo*. Siglo XXI Editores.

**Tesis central:** desde los años 70, la producción industrial deja de organizarse dentro de fronteras nacionales y pasa a fragmentarse en segmentos relocalizables. Las etapas intensivas en trabajo migran a economías con salarios bajos; las etapas de diseño, control y comercialización permanecen en los centros.

**Diferencia con la división internacional del trabajo clásica:**

| DIT clásica (siglo XIX–XX) | NDIT (post-1970) |
|---|---|
| Centro industrial / periferia primaria | Fragmentación del proceso productivo |
| Países completos especializados | **Etapas** especializadas |
| Industrialización = desarrollo | Industrialización sin desarrollo (maquila) |

**Qué permite leer en los datos de este trabajo:**

- El desplazamiento del PIB industrial hacia Asia **no es** difusión del desarrollo: es **relocalización selectiva** de segmentos productivos
- El estancamiento latinoamericano no es residuo del pasado: es una **posición asignada** en la nueva configuración
- Corea del Sur constituye la excepción que confirma la regla: logró escalar hacia segmentos de mayor valor en lugar de quedar fijada en el segmento de ensamblaje

**Concepto operativo clave:** *industrialización sin desarrollo*. Un país puede aumentar su producción industrial y no mejorar su posición relativa, si lo que crece es el segmento de menor valor agregado de la cadena.

---

## E.2. Teoría de la Complejidad Económica (TCE)

**Referencia:** Hidalgo, C. y Hausmann, R. (2009). *The building blocks of economic complexity*. PNAS, 106(26).

**Los dos indicadores duales:**

| Indicador | Definición | Nivel |
|---|---|---|
| **Diversidad** | Cuántos productos exporta un país con VCR | País |
| **Ubicuidad** | Cuántos países exportan un producto con VCR | Producto |

**El razonamiento:** un producto exportado por muchos países requiere capacidades ampliamente disponibles. Un producto exportado por pocos requiere capacidades escasas.

Los dos indicadores se corrigen mutuamente: un país puede exportar muchos productos, pero si todos son ubicuos, su complejidad es baja. Un producto puede ser poco ubicuo, pero si los pocos que lo exportan son países poco diversificados, puede tratarse de una rareza geológica y no de sofisticación tecnológica.

**Concepto de *capacidades*:** conocimiento productivo no codificable, distribuido en personas, organizaciones e instituciones. No se transfiere comprando maquinaria: se acumula produciendo.

**Qué permite leer en los datos de este trabajo:**

- Que 114 países exporten chatarra de aluminio con VCR indica que la capacidad requerida —recolectar, clasificar, embarcar— está universalmente disponible
- Que un solo país exporte alcaloides de cornezuelo con VCR indica una combinación de capacidades que casi nadie logró reunir
- La **especialización en productos ubicuos es una trampa**: no genera aprendizaje ni externalidades tecnológicas; no abre puertas a productos adyacentes de mayor complejidad

**Concepto operativo clave:** *espacio de producto*. Los productos están conectados por las capacidades que comparten. Un país se mueve desde lo que ya sabe hacer hacia lo adyacente. Especializarse en productos ubicuos, que están en la periferia del espacio de producto, deja pocas rutas de salida.

---

## E.3. Articulación entre ambos marcos

Los dos marcos del módulo describen el mismo fenómeno desde ángulos complementarios:

| | NDIT | TCE |
|---|---|---|
| **Unidad de análisis** | Etapa productiva | Capacidad |
| **Pregunta** | ¿Dónde se produce cada etapa? | ¿Qué sabe hacer cada país? |
| **Mecanismo** | Relocalización por costos | Acumulación de capacidades |
| **Indicador usado acá** | Participación en PIB industrial | Ubicuidad de productos |
| **Diagnóstico periférico** | Fijación en segmentos de bajo valor | Especialización en productos ubicuos |

**Síntesis que articula ambos:** la NDIT explica *cómo* se distribuyó geográficamente la producción; la TCE explica *por qué* esa distribución tiende a reproducirse. La primera describe el movimiento; la segunda, la inercia.

**Formulación que sintetiza el trabajo completo:**

> La ubicuidad no es solo un indicador de complejidad económica sino, más bien,
> el registro estadístico de una división internacional del trabajo que reproduce
> y amplía las asimetrías entre economías industrializadas y periféricas.

---

## E.4. Referencias completas del marco conceptual del módulo

- Fröbel, F., Heinrichs, J. y Kreye, O. (1980). *La nueva división internacional del trabajo*. Siglo XXI Editores. *(caps. 1–2 en el material del módulo — PDF escaneado sin texto extraíble)*
- Gaulier, G. y Zignago, S. (2010). *BACI: International Trade Database at the Product-Level. The 1994-2007 Version*. CEPII Working Paper, N°2010-23.
- Graña, J. M. y Terranova, F. (2022). *(fuente de la base de empleo industrial del taller de cátedra)*
- Hidalgo, C. y Hausmann, R. (2009). The building blocks of economic complexity. *PNAS*, 106(26), 10570–10575.
- Lall, S. (2000). The Technological Structure and Performance of Developing Country Manufactured Exports, 1985-98. *Oxford Development Studies*, 28(3), 337–369.

---

## CIERRE DEL ADDENDUM

**Estado del repertorio técnico tras Módulos 2 y 3:**

| Dominio | Consolidado | Disponible sin usar | Pendiente |
|---|---|---|---|
| **Proyecto y estructura** | `.Rproj`, rutas relativas, bases/resultados | — | — |
| **Lectura y diagnóstico** | `read_csv`, `glimpse`, `problems`, `unique`, `head`/`tail`, `scipen` | — | — |
| **Transformación** | `filter`, `select`, `mutate`, `case_when`, `rename`, `arrange`, `distinct` | `complete`, `factor(levels)`, `distinct(.keep_all)` | — |
| **Agregación** | `group_by`+`summarise`, `group_by`+`mutate`, `n()`, `.groups` | Índice base con subsetting condicional | — |
| **Joins** | `left_join` simple, compuesto, con claves de distinto nombre | — | Otros tipos de join |
| **Reshape** | — | `pivot_wider` | `pivot_longer` |
| **Visualización** | `geom_line`, `geom_col`, `facet_wrap`, `theme`, escalas, doble estética | `position="stack"/"fill"/"dodge"`, `ggplotly` | — |
| **Tablas** | — | `gt` completo, `paletteer` | — |
| **Exportación** | `ggsave`, `write_csv`, `write_xlsx` multi-hoja | `saveWidget` | — |
| **Modularización** | — | `source()` | Funciones propias |
| **Bases grandes** | Reducción temprana de dimensiones | — | `data.table`, `arrow` |
| **Fechas** | — | — | `lubridate` |
| **Iteración** | — | — | `for`, `while`, `purrr::map` |
| **Documentos** | Word/Docs → PDF | — | R Markdown, Quarto |

---

*Addendum cerrado. Complementa el Balance Técnico y Metodológico — Módulos 2 y 3.*
*Módulo 3 entregado y aceptado el 27 de julio de 2026.*
