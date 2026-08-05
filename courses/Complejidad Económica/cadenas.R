library(dplyr)
library(tidyr)

# 1. Filtro productos de interés

comercio_cadenas <- comercio_mundial %>%
  filter(producto %in% c(
    "120190","150710","150790","230400",
    "283691","282520","850760",
    "870323","870324","870332","870840","870850",
    "854231","854232","854233","854239",
    "840120","840130","840140",
    "880240","880260","880730"
  )) %>%
  
  # 2. Agrupo productos en cadenas
  mutate(
    cadena = case_when(
      producto %in% c("120190","150710","150790","230400") ~ "Soja",
      producto %in% c("283691","282520","850760") ~ "Litio",
      producto %in% c("870323","870324","870332","870840","870850") ~ "Autos",
      producto %in% c("854231","854232","854233","854239") ~ "Semiconductores",
      producto %in% c("840120","840130","840140") ~ "Nuclear",
      producto %in% c("880240","880260","880730") ~ "Espacial"
    )
  ) %>%
  
  # 3. Agrego expo por país y cadena
  group_by(pais, cadena) %>%
  summarise(valor = sum(valor_miles_usd, na.rm = TRUE), .groups = "drop") %>%
  
  # 4. Completo todas las combinaciones país × cadena
  complete(
    pais,
    cadena,
    fill = list(valor = 0)
  ) %>%
  
  # 5. Ordeno cadenas por nivel tecnológico
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
  ) %>%
  
  # 6. Ordeno base
  arrange(pais, cadena)

