
####################################################
# TALLER INDICADORES DE COMERCIO INTERNACIONAL
# PROF. VANESSA RAMÍREZ QUINTANA
#
#DIPLOMATURA: PROGRAMACIÓN EN R APLICADA A LA ECONOMÍA
#
####################################################

#(descomentar para instalar)

# install.packages('readxl')
# install.packages('readr')




#carga de librerías:
library(tidyverse)
library(readr)
library(readxl)

options(scipen = 999)

#carga base BACI 2024 versión 202601 → con tab abro las bases
  ##crea un objeto llamado comercio_mundial el cual contenga la base BACI HS22 para 2024. 
comercio_mundial <- read_csv("BACI/BACI_HS22_Y2024_V202601.csv")

# Products in Harmonized System 6-digit nomenclature.
# Values in thousand USD and quantities in metric tons.

#diccionario de países
  ##crea un objeto llamado paises_baci el cual contenga el diccionario de países de la base BACI
paises_baci <- read_csv("BACI/country_codes_V202601.csv")

#1. Acomodando la base ####

  ##modifica comercio mundial de manera tal que contenga al exportador, importador, producto y valor. 
  ##suma los valores para cada país exportador. 


comercio_mundial <- comercio_mundial %>%
  select(i,j,k,v) %>%
  group_by(i,k) %>%
  summarise(v=sum(v)) %>%
  ungroup()
# Pegando código de país
  ##pegale a comercio_mundial los codigos nombres y codigos iso a 3 digitos y renombra las variables (pais, producto y valor_miles_usd)


comercio_mundial <- comercio_mundial  %>%
  left_join(paises_baci %>% 
             select(country_code, country_name, country_iso3),
            by=c("i"="country_code")) %>%
  ungroup()%>%
  rename(pais=country_name,
         producto = k,
         valor_miles_usd = v) %>%
  select(pais, country_iso3, producto, valor_miles_usd)

#cadenas de productos 
    ##llama a las cadenas de productos seleccionadas corriendo el siguiente comando. 
source("cadenas.R")

#2. Cálculo VCR

# #VCR= expo producto i pais x/ expo totales del país
#       --------------------------------------------
#       expo producto i del mundo / expo totales mundo

# total de exportaciones del país
##crea una variable dentro de comercio_mundial que se llame expo_totales_pais y que esta sea la suma de las exportaciones totales de cada país. 

comercio_mundial <- comercio_mundial %>%
  group_by(pais) %>% 
  mutate(expo_totales_pais=sum(valor_miles_usd))
  ungroup()
# total de exportaciones del mundo
    ##crea una variable dentro de comercio_mundial que se llame expo_totales y que esta sea la suma de todas las exportaciones del mundo. 
comercio_mundial <- comercio_mundial %>%
  mutate(expo_totales= sum(valor_miles_usd)) %>%
  ungroup()

    ##ahora selecciona todas las variables menos producto y valor_mmiles_usd y quédate con una fila por país. 


#pego valores totales a las cadenas de comercio 

    ##a comercio_cadenas pegale el país, el codigo iso de 3 digitos y las exportaciones totales de cada pais y del mundo que calculaste en comercio_mundial


# total por producto (mundo)
    ##ahora calcula el total de exportaciones por producto en una variable llamada expo_producto


# VCR
  ##calcula las vcr en una variable que se llame vcr


# VCR normalizadas
    ##normaliza las vcr con una variable que se llame IVCRnorm


#tabla para países seleccionados

    ##crea un vector llamado paises_seleccionados y elige un máximo de 6 países. Dentro del vector coloca los codigos iso a 3 digitos de esos países. 
      #si no recuerdas el codigo iso puedes buscarlo con el siguiente código: 

          #paises_baci[paises_baci$country_name=="Nombre del país a buscar",]

    ##luego, crea el objeto vcr_seleccion y filtra comercio_cadenas por esos países elegidos.
    ##selecciona las variables pais, country_iso3,cadena,y IVCRNorm



#Acomodando tabla

    #para obtener una tabla presentable hay que pivotear el dataframe. 
    ##crea un objeto vcr_seleccion_tabla en el que pivotees el dataframe usando como nombres los codigos iso y como valores las vcr normalizadas


