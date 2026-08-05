
#Adrian LEDESMA
#09/06/2026

#CARGO LIBRERIAS → revisar cuales contiene
library(tidyverse) #ggplot adentro

#CARGO DATOS → toma CSV desde base/
empleo <- read_csv("base/empleo_sectores_base.csv") %>%
  filter(!is.na(anio))  # Borro  fila si año NA

# EXPLORACION INICIAL
# VR → Estructura / valores unico clave
glimpse(empleo)
unique(empleo$iso3)  #paises disponibles prueba
unique(empleo$sector_desc) #sectores disponibles prueba

#1.PROCESAMIENTO SIMPLE → pipe filtrar Argentina, share  ∆ porcentaje
#___________________________________________________________________
proc_simple <- empleo %>%
  filter(iso3 == "ARG") %>%  #Filtro solo ARG 
  mutate(share_pct = round(share_empleo * 100, 2)) # Proporcion ∆ porcentaje

write_csv(proc_simple, "resultados/procesamiento_simple.csv") #Guardar CSV resultados

# 2. PROCESAMIENTO COMPLEJO → varios pipes, evolucion empleo por sector ARG
# cortes 60,90,2018
#___________________________________________________________________

proc_complejo <- empleo %>%
  filter(iso3 == "ARG") %>%                              # filtrar ARG
  filter(anio %in% c(1960, 1990, 2018)) %>%              # cortes
  mutate(share_pct = round(share_empleo * 100, 2)) %>%   # ∆ %
  group_by(anio, gran_sector) %>%                        # group anio sextor
  summarise(                                             # resumir x grupo
    empleo_total_miles = sum(empleo_miles, na.rm = TRUE),        # total empleo en miles
    share_total_pct    = round(sum(share_pct, na.rm = TRUE), 1)  # share acumulado %
  ) %>%
  arrange(anio, gran_sector) %>%                        # ordenar x anio sector
  mutate(periodo = case_when(                           # etiqueta periodos
    anio == 1960 ~ "Industrialización (1960)",
    anio == 1990 ~ "Reestructuración (1990)",
    anio == 2018 ~ "Actualidad (2018)"
  ))

write_csv(proc_complejo, "resultados/procesamiento_complejo.csv") # Guardar resultado como CSV 


# 3. VISUALIZACIÓN SIMPLE → graf barras , share empleo por gran sector arg 2018
#__________________________________________________________________________

datos_viz_simple <- empleo %>% #preparo datos para viz simple arg 2018
  filter(iso3 == "ARG", anio == 2018) %>%            # ARG año más reciente
  mutate(share_pct = round(share_empleo * 100, 2))   # convertir %
#
p1 <- ggplot(datos_viz_simple, #Graficar
             aes(x = gran_sector, y = share_pct, fill = gran_sector)) +
  geom_col() +                                       # gráfico de columnas
  labs(
    title    = "Estructura del empleo en Argentina (2018)",
    subtitle = "Participación porcentual por gran sector",
    x        = "Gran sector",
    y        = "Share del empleo (%)",
    fill     = "Sector",
    caption  = "Fuente: Fundar — empleo_sectores_base.csv"
  ) +
  theme_classic()                                    # estética plana


ggsave("resultados/viz_simple.png", plot = p1, #guardo resultado PNG
       width = 18, height = 12, units = "cm", dpi = 150)

# 4- VISUALIZACIÓN COMPLEJA
# Evolución del share de empleo por sector en ARG (1960-2018)
# Separado por gran sector con facet_wrap
#___________________________________________________________-_____________

datos_viz_compleja <- empleo %>% #preparar datos: ARG todos los años, sectores
  filter(iso3 == "ARG") %>%                          # filtrar ARG
  mutate(
    share_pct    = round(share_empleo * 100, 2),     # convertir %
    sector_corto = str_wrap(sector_desc, width = 22) # cortar nombres 
  )

p2 <- ggplot(datos_viz_compleja, #Graficar
             aes(x = anio, y = share_pct, color = sector_corto)) +
  geom_line(linewidth = 0.8) +                       # líneas de evolución temporal
  facet_wrap(~ gran_sector, ncol = 2) +              # panel por gran sector
  labs(
    title    = "Evolución de la estructura de empleo en Argentina (1960–2018)",
    subtitle = "Share de empleo por sector productivo — Bienes vs. Servicios",
    x        = "Año",
    y        = "Share del empleo (%)",
    color    = "Sector",
    caption  = "Fuente: Fundar — empleo_sectores_base.csv"
  ) +
  scale_x_continuous(breaks = seq(1960, 2018, by = 10)) + # marcas cada 10 años
  theme_classic() + 
  theme(
    legend.position  = "bottom",                         
    legend.text      = element_text(size = 6),          
    strip.background = element_rect(fill = "#EEEDFE"), 
    strip.text       = element_text(face = "bold"),  
    axis.text.x      = element_text(angle = 45, hjust = 1) # rotar enX
  )

ggsave("resultados/viz_compleja.png", plot = p2, # Guardar PNG
       width = 24, height = 16, units = "cm", dpi = 150) 
