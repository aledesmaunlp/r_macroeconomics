#Cargamos las librerías que vamos a utilizar (en caso de ser necesario, instalamos los paquetes que falten)
library(tidyverse)
library(ggplot2)
library(plotly)

#Pasamos de notación científica a decimal
options(scipen = 999)

#1.Cargamos la base de empleo industrial utilizada en el curso
empleo_industrial <- read_csv("bases/empleo_industrial.csv")

#Realizamos algunas modificaciones a la base empleo_industrial: renombramos algunas variables, creamos la variable participación del empleo industrial, seleccionamos a los países y filtramos años sin datos.
empleo_industrial <- empleo_industrial %>%
  rename(
    Ocupados_industria = Ocup_INDUSTRIA,
    Ocupados_total = Ocup_TOTAL_ECONOMIA,
    Año = Anio)

#Graficamos la participación del empleo industrial regional en el empleo industrial mundial

empleo_industrial <- empleo_industrial %>%
  filter (Año= !1999)

empleo_industrial_mundial <- empleo_industrial %>%
  filter(Año >= 1978, Año <=2018) %>%
  group_by (Año)%>%
  summarise(Ocupados_industria_mundial = sum (Ocupados_industria, na.rm = TRUE))%>%
  ungroup()

empleo_industrial_regional <- empleo_industrial %>%
  filter (Año >= 1978, Año <=2018) %>%
  group_by (Año, Regiones.economicas) %>%
  summarise (Ocupados_industria_regional = sum (Ocupados_industria, na.rm =TRUE)) %>%
  ungroup()

empleo_industrial_regional <- empleo_industrial_regional %>% 
  left_join(empleo_industrial_mundial, by ="Año") %>% 
  mutate (participacion_industria_regional = Ocupados_industria_regional/Ocupados_industria_mundial) %>% 
  ungroup()

grafico_participacion_empleo_industrial_regional <- empleo_industrial_regional %>%
  ggplot(aes(x = Año, y = participacion_industria_regional * 100, fill = Regiones.economicas)) +
  geom_col(position = "stack") +
  labs(
    title = "Participación del empleo industrial por región económica sobre el empleo industrial mundial",
    subtitle = "(1978–2018)",
    caption = "Fuente: Graña y Terranova (2022)",
    x = "Año",
    y = "Participación (%)",
    fill = "Regiones económicas") +
  scale_x_continuous(
    breaks = seq(1978, 2018, by = 4),
    expand = c(0, 0)) +
  theme_classic()

grafico_participacion_empleo_industrial_regional

