#script_clase4
library(tidyverse)
library(readxl)
library(lubridate)
install.packages("eph")
library(eph)

SIPA <- read_csv("bases/base_sipa.csv", 
                 show_col_types = FALSE)
class(SIPA$Periodo)
SIPA <- SIPA %>% 
  mutate(Periodo = as.Date(Periodo))

class(SIPA$Periodo)

table(SIPA$Variable)

head(SIPA)

SIPA <- SIPA %>% 
  mutate(Anio = year(Periodo))
flujo1 <- SIPA %>% 
  group_by(Anio, Variable) %>% 
  summarise(Promedio = mean(Valor))

flujo1

flujo2 <- SIPA %>%
  filter(Variable == "Empleo asalariado en el sector privado") %>% 
  group_by(Anio) %>% 
  summarise(Promedio = mean(Valor))

flujo2
flujo3 <- SIPA %>%
  filter(Variable == "Empleo en casas particulares") %>% 
  group_by(Anio) %>% 
  summarise(Promedio = mean(Valor)) %>% 
  arrange(-Anio)

flujo3

SIPA <- SIPA %>% 
  mutate(Mes = month(Periodo),
         Trimestre = quarter(Periodo))
ipc_mensual <- read_xlsx("bases/ipc_ceped_data.xlsx")

class(ipc_mensual$fecha)

ipc_mensual <- ipc_mensual %>% 
  mutate(fecha = as.Date(fecha))

class(ipc_mensual$fecha)

remuneracion_media <- SIPA %>% 
  filter(Variable == "Remuneración promedio - sin estacionalidad") %>% 
  mutate(indice_remuneraciones = Valor/Valor[Periodo == "2009-01-01"]*100)
ipc_mensual <- ipc_mensual %>% 
  mutate(indice_ipc_2009 = valor/valor[fecha == "2009-01-01"]*100)

remuneracion_real <- remuneracion_media %>%
  left_join(ipc_mensual, by = c("Periodo" = "fecha"))
remuneracion_real <- remuneracion_real %>% 
  mutate(indice_real = indice_remuneraciones/indice_ipc_2009*100,
         Trimestre        = quarter(Periodo)) %>% 
  select(Periodo, Anio = ANO4, Trimestre, Mes = sub, indice_real) 
remuneracion_real_anual <- remuneracion_real %>% 
  group_by(Anio) %>% 
  summarise(Promedio_Anual = mean(indice_real))

