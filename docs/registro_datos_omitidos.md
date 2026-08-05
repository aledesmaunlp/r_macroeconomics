# Registro de Archivos y Datos OMITIDOS en el Repositorio

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