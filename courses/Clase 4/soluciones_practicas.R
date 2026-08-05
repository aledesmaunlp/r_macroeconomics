#Ejericio 3

#Instalamos readxl

library(readxl)
un_vector <- c(5,99,7)
un_vector[2] #solicito elemento en segunda posicon
otro_vector <- c(49:98)
otro_vector [23]
gapminder_2000 <- read.csv("C:/Users/avech/Desktop/Clase 2/bases/gapminder_2000.csv")
head(gapminder_2000)
names(gapminder_2000)
gapminder_2000$Country
pob_promedio <- mean(gapminder_2000$population)
min(gapminder_2000$life)

#Prctica 2
#Ejercicio 1
 
adam_smith <- read.csv("C:/Users/avech/Desktop/Clase 3/bases/adam_smith.csv") 
print(adam_smith)
View(adam_smith)
library(tidyverse)

adam_smith <- adam_smith %>%
  filter(dias_trabajo == 1 )

adam_smith <- adam_smith %>%
  rename(trabajadoras=trabajadores)

adam_smith <- adam_smith %>% 
  mutate(productividad = alfileres_producidos/trabajadoras)

adam_smith$prod_pc <- adam_smith$alfileres_producidos/adam_smith %>%
  select(organizacion_trabajo, prod_pc)
#no anda buscar error

#clase 4

library(tidyverse)
library(readxl)
base_sipa <- read.csv("C:/Users/avech/Desktop/Clase 4/bases/base_sipa.csv")
base_ipc <- read.xlsx ("C:/Users/avech/Desktop/Clase 4/bases/ipc_ceped_data.xlsx")
head(base_sipa)
tail(base_ipc)

base_sipa <- base_sipa %>%
  filter(Variabe == "Remuneracion promedio -\r\n con estacionalidad")
  
base_ipc <- base_ipc %<% rename(ipc = valor)

datos_unidos <- base_sipa %>%
  
  
#COMPLETAR 
  
#EJERCICIO 3 MEDIDAS DE RESUMEN
  
%>% 
  <- 
  
  