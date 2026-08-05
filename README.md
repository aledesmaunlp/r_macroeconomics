

# r_macroeconomics
Sitio: https://aledesmaunlp.github.io/r_macroeconomics/
This document contains my R summaries for economists.

<!-- Chat de organizacion: https://chat.deepseek.com/a/chat/s/dd566aa1-45db-475d-a369-7afdeac022d4 -->
Repositorio personal para el análisis de datos en macroeconomía aplicada. 
Este proyecto es 100% individual, por lo que la estructura prioriza mi flujo de trabajo local por encima de los estándares colaborativos (ej. se suben múltiples `.Rproj` para abrir carpetas sueltas).

---

## ⚠️ ADVERTENCIAS PARA MI YO DEL FUTURO (y posibles colaboradores fantasmas)

1.  **Problema de las rutas (el más importante):** 
    Al tener múltiples `.Rproj` en subcarpetas (`Clase 2/`, `Clase 3/`, etc.), si abres RStudio haciendo doble clic en uno de ellos, la raíz del proyecto cambiará. 
    - **Regla de oro:** Usa SIEMPRE el paquete `here` (ej. `here::here("data", "raw", "archivo.csv")`) en TODOS los scripts para apuntar a los datos. 
    - O, si prefieres la opción bruta, ejecuta `setwd("~/ruta/hasta/r_macroeconomics")` al inicio de cada script.

2.  **Archivos pesados no subidos a GitHub:**
    - GitHub tiene un límite de 100 MB por archivo y 5 GB total para repositorios gratuitos. 
    - Las bases de datos crudas, `.sqlite`, `.duckdb`, `.zip` y los archivos comprimidos NO están en el repo. 
    - **Consulta** `docs/registro_datos_omitidos.md` para saber exactamente qué archivos quedaron fuera y dónde deberías colocarlos manualmente si clonas este repo en otro PC.

3.  **Limpieza de salidas:**
    - Los archivos `.html` y `.pdf` generados por los scripts (como las guías prácticas) no se suben para no ensuciar el historial. Se regeneran fácilmente al correr los `.Rmd`.

---

## 1 -  🗂️ Estructura del Proyecto

```text
r_macroeconomics/
├── README.md                 # Este archivo
├── .gitignore                # Archivos y carpetas ignoradas por Git
├── r_macroeconomics.Rproj    # Punto de entrada PRINCIPAL (ábreme a mí primero)
│
├── bibliography/             # Archivos .bib y PDFs ligeros de referencias
├── templates/                # Plantillas de documentos o gráficos
├── references/               # Manuales, cheatsheets o guías externas
├── docs/                     # Documentación general
│   └── registro_datos_omitidos.md  # 📝 Bitácora de lo que NO se subió
│
├── data/                     # Datos del proyecto
│   ├── raw/                  # Datos CRUDOS (NO se suben a Git, solo su registro)
│   ├── interim/              # Datos en proceso de limpieza (NO se suben)
│   └── processed/            # Datos finales listos para análisis (NO se suben)
│
├── courses/                  # Contenido de las clases
│   ├── Clase 2/
│   ├── Clase 3/
│   ├── Clase 4/
│   └── Complejidad Económica/
│
├── assignments/              # Entregas y talleres prácticos
│   ├── Entrega M2/           (ex Ledesma_EntregaM2)
│   └── Taller Integrador/    (ex clase_4_taller_integrador)
│
├── research/                 # Análisis exploratorios o experimentos sueltos
├── archive/                  # Cosas viejas que no quiero borrar, pero ya no uso
└── output/                   # Gráficos, tablas o resultados exportados (NO se suben)
```

### 🚀 Cómo correr los scripts
Siempre parte desde la raíz:

Abre RStudio.

Ve a File > Open Project y selecciona r_macroeconomics.Rproj (el de la raíz).

Si necesitas abrir un script específico (ej. courses/Clase 4/script_clase4.R), navega a él dentro del panel de archivos de RStudio, pero NO cierres el proyecto raíz.

Ejecuta el script. El paquete here resolverá las rutas automáticamente.

### 📦 Dependencias principales (si falta alguna, instálala)
r
install.packages(c("tidyverse", "here", "data.table", "duckdb", "RSQLite", "readxl"))
📌 Nota sobre el flujo de Git
Como soy el único usuario, hago commits grandes y mensajes directos.
Si aparece algún conflicto en el futuro, revisar primero las rutas y los archivos ignorados.

## 2. Gitignore → en su documento

## 3. El archivo de registro de lo que NO se sube
¿Cuál es? Se llama registro_datos_omitidos.md y debe ir dentro de la carpeta docs/.

¿Por qué ahí? Porque docs/ es la carpeta estándar para documentación. Si lo pones en data/ corres el riesgo de que el .gitignore lo borre si configuras data/ de forma muy agresiva. En docs/ estará siempre visible y seguro.

Crea la carpeta docs/ si no existe, y dentro pega este contenido:

markdown

## Registro de Archivos y Datos OMITIDOS en el Repositorio

> **Motivo:** Estos archivos no se suben a GitHub porque son demasiado pesados (> 50 MB), son datos crudos descargables desde fuentes externas, o son resultados temporales que se generan con los scripts.

---

| Nombre / Carpeta | Ubicación original (dentro del proyecto) | Tamaño aprox. | Fuente / Origen | ¿Cómo obtenerlo / replicarlo? |
| :--- | :--- | :--- | :--- | :--- |
| Carpeta `BACI/` | `courses/Complejidad Económica/BACI/` | ~ 2 - 3 GB | CEPII (http://www.cepii.fr) | Descargar desde la web oficial. El script `calculo_diversidad.R` lo lee. |
| Carpeta `bases/` (Clase 2) | `courses/Clase 2/bases/` | ~ 500 MB | Propia / INEGI / BCRA | No se sube por peso. Revisar correo o disco externo. |
| Carpeta `bases/` (Clase 4) | `courses/Clase 4/bases/` | ~ 800 MB | Encuestas de hogares | Reemplazar con una muestra pequeña si se quiere testear. |
| Carpeta `base/` | `assignments/Entrega M2/base/` | ~ 300 MB | Datos de la entrega | Se guarda localmente en el disco D:/. |
| Carpeta `resultados/` | `assignments/Entrega M2/resultados/` | ~ 100 MB | Salidas de gráficos/tablas | Se regenera ejecutando `script_entrega.R`. No hace falta subirlo. |
| `EHP_registro_noviembre_2019.md` | `docs/EHP_registro_noviembre_2019.md` | 50 MB | Registro administrativo | Archivo confidencial. No compartir. |
| Cualquier `.sqlite` o `.duckdb` | Repartidos por todo el proyecto | Variable | Datos procesados en caché | Se crean automáticamente al correr los scripts de limpieza. |

---

## 📂 Estructura local necesaria para que los scripts funcionen

Si alguien (o yo en otro ordenador) clona este repositorio, debe crear manualmente estas carpetas vacías y colocar los archivos pesados según la tabla de arriba:

```text
r_macroeconomics/
├── data/
│   ├── raw/
│   ├── interim/
│   └── processed/
├── courses/
│   ├── Clase 2/bases/
│   ├── Clase 3/Complejidad Económica/BACI/
│   └── Clase 4/bases/
└── assignments/
    └── Entrega M2/base/
Última actualización: Agosto 2026
```

### ✅ Resumen de tu nuevo estado

1. **README.md** → En la raíz. Te recuerda el problema de las rutas (múltiples Rproj) y la existencia del registro.
2. **.gitignore** → Ya sabe ignorar carpetas como `BACI`, `bases`, `resultados`, TODOS los pesos pesados, pero **respeta** tus `.Rproj` anidados (porque no tiene la regla `*.Rproj`).
3. **`docs/registro_datos_omitidos.md`** → Tu bitácora personal. Ahí anotas todo lo que no subiste y dónde conseguirlo.

Con esto, tu repositorio estará liviano, limpio y perfectamente documentado. ¡A darle al código!