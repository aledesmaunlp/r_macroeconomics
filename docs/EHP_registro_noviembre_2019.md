<!--https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_2t19.pdf-->

# Diseño de registro de los microdatos de la EPH-INDEC

# EPH — Diseño de Registro y Estructura, Bases Preliminares Hogar y Personas
**INDEC — Dirección de Encuesta Permanente de Hogares. Buenos Aires, noviembre de 2019.**

Fuente: [EPH_registro_2t19.pdf](https://www.indec.gob.ar/ftp/cuadros/menusuperior/eph/EPH_registro_2t19.pdf)
Licencia: Creative Commons (se permite reproducción con atribución de la fuente).

## Nota sobre la estructura de las bases

- `usu_hogar.txt`: un registro por hogar. Clave: `CODUSU` + `NRO_HOGAR`.
- `usu_individual.txt`: un registro por persona. Clave: `CODUSU` + `NRO_HOGAR` + `COMPONENTE`.
- `CODUSU` identifica la vivienda y habilita el seguimiento panel a lo largo de los 4 trimestres en que participa.
- Se recomienda usar este diseño de registro junto con los cuestionarios de la EPH y los documentos metodológicos "La nueva EPH de Argentina, 2003" y "EPH, cambios metodológicos" (indec.gob.ar).

---

# I. BASE HOGAR (usu_hogar.txt)

## I.1. Identificación

| Campo | Tipo (Long.) | Descripción |
|---|---|---|
| CODUSU | C(29) | Código para distinguir viviendas; permite aparearlas con Hogares y Personas y hacer seguimiento a través de los trimestres |
| NRO_HOGAR | N(1) | Código para distinguir hogares; permite aparearlos con Personas |
| REALIZADA | N(1) | Entrevista realizada: Sí / No (hogar no respuesta) |
| ANO4 | N(4) | Año de relevamiento (4 dígitos) |
| TRIMESTRE | N(1) | Ventana de observación: 1=1er trim., 2=2do trim., 3=3er trim., 4=4to trim. |
| REGION | N(2) | 01=Gran Buenos Aires, 40=NOA, 41=NEA, 42=Cuyo, 43=Pampeana, 44=Patagonia |
| MAS_500 | C(1) | Aglomerados según tamaño: N=conjunto de aglomerados <500.000 hab.; S=conjunto de aglomerados ≥500.000 hab. |
| AGLOMERADO | N(2) | 02=Gran La Plata, 03=Bahía Blanca-Cerri, 04=Gran Rosario, 05=Gran Santa Fe, 06=Gran Paraná, 07=Posadas, 08=Gran Resistencia, 09=Cdro. Rivadavia-R.Tilly, 10=Gran Mendoza, 12=Corrientes, 13=Gran Córdoba, 14=Concordia, 15=Formosa, 17=Neuquén-Plottier, 18=S.del Estero-La Banda, 19=Jujuy-Palpalá, 20=Río Gallegos, 22=Gran Catamarca, 23=Salta, 25=La Rioja, 26=San Luis-El Chorrillo, 27=Gran San Juan, 29=Gran Tucumán-T.Viejo, 30=Santa Rosa-Toay, 31=Ushuaia-Río Grande, 32=Ciudad de Bs.As., 33=Partidos del GBA, 34=Mar del Plata-Batán, 36=Río Cuarto, 38=San Nicolás-Villa Constitución, 91=Rawson-Trelew, 93=Viedma-Carmen de Patagones |
| PONDERA | N(6) | Ponderación |

## I.2. Características de la vivienda

| Campo | Tipo | Descripción |
|---|---|---|
| IV1 | N(1) | Tipo de vivienda (por observación): 1=Casa, 2=Departamento, 3=Pieza de inquilinato, 4=Pieza en hotel/pensión, 5=Local no construido para habitación, 6=Otros (ver IV1_Esp) |
| IV1_Esp | C(45) | Especificación de "Otros" (IV1) |
| IV2 | N(2) | Cantidad de ambientes/habitaciones en total (sin baño, cocina, pasillos, lavadero, garage) |
| IV3 | N(1) | Piso interior predominante: 1=Mosaico/baldosa/madera/cerámica/alfombra, 2=Cemento/ladrillo fijo, 3=Ladrillo suelto/tierra, 4=Otros (ver IV3_Esp) |
| IV3_Esp | C(45) | Especificación de "Otros" (IV3) |
| IV4 | N(2) | Cubierta exterior del techo: 1=Membrana/cubierta asfáltica, 2=Baldosa/losa sin cubierta, 3=Pizarra/teja, 4=Chapa de metal sin cubierta, 5=Chapa de fibrocemento/plástico, 6=Chapa de cartón, 7=Caña/tabla/paja con barro o sola, 9=Ns./Depto. en propiedad horizontal |
| IV5 | N(1) | Techo con cielorraso/revestimiento interior: 1=Sí, 2=No |
| IV6 | N(1) | Procedencia del agua: 1=Por cañería dentro de la vivienda, 2=Fuera de la vivienda pero dentro del terreno, 3=Fuera del terreno |
| IV7 | N(1) | Origen del agua: 1=Red pública, 2=Perforación con bomba a motor, 3=Perforación con bomba manual, 4=Otra fuente (ver IV7_Esp) |
| IV7_Esp | C(45) | Especificación de otra fuente de agua |
| IV8 | N(1) | Tiene baño/letrina: 1=Sí, 2=No |
| IV9 | N(1) | Ubicación del baño: 1=Dentro de la vivienda, 2=Fuera de la vivienda pero dentro del terreno, 3=Fuera del terreno |
| IV10 | N(1) | Tipo de baño: 1=Inodoro con botón/mochila/cadena y arrastre de agua, 2=Inodoro sin botón/cadena con arrastre a balde, 3=Letrina (sin arrastre de agua) |
| IV11 | N(1) | Desagüe del baño: 1=A red pública (cloaca), 2=A cámara séptica y pozo ciego, 3=Sólo a pozo ciego, 4=A hoyo/excavación en la tierra |
| IV12_1 | N(1) | Cerca de basural/es (≤3 cuadras): 1=Sí, 2=No |
| IV12_2 | N(1) | En zona inundable (últimos 12 meses): 1=Sí, 2=No |
| IV12_3 | N(1) | En villa de emergencia (por observación): 1=Sí, 2=No |

## I.3. Características habitacionales del hogar

| Campo | Tipo | Descripción |
|---|---|---|
| II1 | N(2) | Ambientes/habitaciones de uso exclusivo del hogar |
| II2 | N(2) | De esos, cuántos se usan habitualmente para dormir |
| II3 | N(1) | Usa alguno exclusivamente como lugar de trabajo (consultorio/estudio/taller/negocio): 1=Sí, 2=No |
| II3_1 | N(1) | Si II3=Sí, cuántos |
| II4_1 | N(1) | Tiene además cuarto de cocina: 1=Sí, 2=No |
| II4_2 | N(1) | Tiene además lavadero: 1=Sí, 2=No |
| II4_3 | N(1) | Tiene además garage: 1=Sí, 2=No |
| II5 | N(1) | De los ambientes de II4, usa alguno para dormir: 1=Sí, 2=No |
| II5_1 | N(2) | Si II5=Sí, cuántos |
| II6 | N(1) | De los ambientes de II4, usa alguno exclusivamente como lugar de trabajo: 1=Sí, 2=No |
| II6_1 | N(2) | Si II6=Sí, cuántos |
| II7 | N(2) | Régimen de tenencia: 01=Propietario vivienda y terreno, 02=Propietario solo vivienda, 03=Inquilino/arrendatario, 04=Ocupante por pago de impuestos/expensas, 05=Ocupante en relación de dependencia, 06=Ocupante gratuito (con permiso), 07=Ocupante de hecho (sin permiso), 08=En sucesión, 09=Otra situación (ver II7_Esp) |
| II7_Esp | C(45) | Especificación de otra situación de tenencia |
| II8 | N(1) | Combustible para cocinar: 01=Gas de red, 02=Gas de tubo/garrafa, 03=Kerosene/leña/carbón, 04=Otro (ver II8_Esp) |
| II8_Esp | C(45) | Especificación de otro combustible |
| II9 | N(1) | Baño (tenencia y uso): 01=Uso exclusivo del hogar, 02=Compartido con otro/s hogar/es de la misma vivienda, 03=Compartido con otra/s vivienda/s, 04=No tiene baño |

## I.4. Estrategias del hogar (últimos 3 meses)

| Campo | Tipo | Descripción (1=Sí, 2=No salvo indicación) |
|---|---|---|
| V1 | N(1) | Vivió de lo que ganan en el trabajo |
| V2 | N(1) | Vivió de alguna jubilación o pensión |
| V21 | N(1) | Aguinaldo de jubilación/pensión cobrado el mes anterior |
| V22 | N(1) | Retroactivo de jubilación/pensión cobrado el mes anterior |
| V3 | N(2) | Vivió de indemnización por despido |
| V4 | N(1) | Vivió de seguro de desempleo |
| V5 | N(1) | Vivió de subsidio/ayuda social en dinero (gobierno, iglesias, etc.) |
| V6 | N(1) | Vivió con mercaderías/ropa/alimentos del gobierno, iglesias, escuelas, etc. |
| V7 | N(1) | Vivió con mercaderías/ropa/alimentos de familiares/vecinos ajenos al hogar |
| V8 | N(1) | Vivió de algún alquiler de su propiedad |
| V9 | N(1) | Vivió de ganancias de un negocio en el que no trabajan |
| V10 | N(1) | Vivió de intereses o rentas por plazos fijos/inversiones |
| V11 | N(1) | Vivió de una beca de estudio |
| V12 | N(1) | Vivió de cuotas de alimentos/ayuda de personas ajenas al hogar |
| V13 | N(1) | Gastó lo que tenían ahorrado |
| V14 | N(1) | Pidió préstamos a familiares/amigos |
| V15 | N(1) | Pidió préstamos a bancos/financieras |
| V16 | N(1) | Compra en cuotas o al fiado con tarjeta de crédito o libreta |
| V17 | N(1) | Vendió alguna de sus pertenencias |
| V18 | N(1) | Otros ingresos en efectivo (limosnas, juegos de azar, etc.) |
| V19_A | N(1) | Menores de 10 años ayudan con dinero trabajando |
| V19_B | N(1) | Menores de 10 años ayudan con dinero pidiendo |

## I.5. Resumen del hogar

| Campo | Tipo | Descripción |
|---|---|---|
| IX_Tot | N(2) | Cantidad de miembros del hogar |
| IX_Men10 | N(2) | Cantidad de miembros menores de 10 años |
| IX_Mayeq10 | N(2) | Cantidad de miembros de 10 y más años |

## I.6. Ingreso total familiar

| Campo | Tipo | Descripción |
|---|---|---|
| ITF | N(12) | Monto de ingreso total familiar (ver Anexo I) |
| DECIFR | C(2) | Decil de ITF — TOTAL EPH |
| IDECIFR | C(2) | Decil de ITF — INTERIOR |
| RDECIFR | C(2) | Decil de ITF — REGIÓN |
| GDECIFR | C(2) | Decil de ITF — aglomerados ≥500 mil hab. |
| PDECIFR | C(2) | Decil de ITF — aglomerados <500 mil hab. |
| ADECIFR | C(2) | Decil de ITF — AGLOMERADO |

## I.7. Ingreso per cápita familiar

| Campo | Tipo | Descripción |
|---|---|---|
| IPCF | N(12) | Monto de ingreso per cápita familiar (ver Anexo I) |
| DECCFR | C(2) | Decil de IPCF — TOTAL EPH |
| IDECCFR | C(2) | Decil de IPCF — INTERIOR |
| RDECCFR | C(2) | Decil de IPCF — REGIÓN |
| GDECCFR | C(2) | Decil de IPCF — aglomerados ≥500 mil hab. |
| PDECCFR | C(2) | Decil de IPCF — aglomerados <500 mil hab. |
| ADECCFR | C(2) | Decil de IPCF — AGLOMERADO |
| PONDIH | C(6) | Ponderador del ITF y del IPCF (ver Anexo I) |

## I.8. Organización del hogar

| Campo | Tipo | Descripción |
|---|---|---|
| VII1_1 | N(2) | Realización de tareas de la casa — Nº de componente (96=Servicio doméstico, 97=Otra persona que no vive en el hogar) |
| VII1_2 | N(2) | Ídem VII1_1 (segunda mención) |
| VII2_1 | N(2) | Otras personas que ayudan en tareas de la casa — Nº de componente (96=Servicio doméstico, 97=Otra persona ajena al hogar, 98=Ninguna) |
| VII2_2 | N(2) | Ídem VII2_1 |
| VII2_3 | N(2) | Ídem VII2_1 |
| VII2_4 | N(2) | Ídem VII2_1 |

---

# II. BASE PERSONAS (usu_individual.txt)

## II.1. Identificación

| Campo | Tipo | Descripción |
|---|---|---|
| CODUSU | C(29) | Igual que en Base Hogar |
| NRO_HOGAR | N(2) | Código para distinguir hogares |
| COMPONENTE | N(2) | Nº de orden asignado a cada persona del hogar. Casos especiales: 51=Servicio doméstico en hogares, 71=Pensionistas en hogares |
| H15 | N(1) | Entrevista individual realizada: 1=Sí, 2=No |
| ANO4 | N(4) | Año de relevamiento |
| TRIMESTRE | N(1) | Ídem Base Hogar |
| REGION | N(2) | Ídem Base Hogar |
| MAS_500 | C(1) | Ídem Base Hogar |
| AGLOMERADO | N(2) | Ídem Base Hogar |
| PONDERA | N(6) | Ponderación |

## II.2. Características de los miembros del hogar (cuestionario del hogar)

| Campo | Tipo | Descripción |
|---|---|---|
| CH03 | N(2) | Relación de parentesco: 01=Jefe/a, 02=Cónyuge/Pareja, 03=Hijo/Hijastro/a, 04=Yerno/Nuera, 05=Nieto/a, 06=Madre/Padre, 07=Suegro/a, 08=Hermano/a, 09=Otros familiares, 10=No familiares |
| CH04 | N(1) | Sexo: 1=Varón, 2=Mujer |
| CH05 | date | Fecha de nacimiento (día, mes, año) |
| CH06 | N(2) | Edad en años cumplidos |
| CH07 | N(1) | Estado civil: 1=Unido/a, 2=Casado/a, 3=Separado/a o divorciado/a, 4=Viudo/a, 5=Soltero/a |
| CH08 | N(3) | Cobertura médica: 1=Obra social (incl. PAMI), 2=Mutual/Prepaga/Emergencia, 3=Planes y seguros públicos, 4=No paga ni le descuentan, 9=Ns./Nr., 12=Obra social+mutual/prepaga/emergencia, 13=Obra social+planes/seguros públicos, 23=Mutual/prepaga/emergencia+planes/seguros públicos, 123=Las tres anteriores combinadas |
| CH09 | N(1) | Sabe leer y escribir: 1=Sí, 2=No, 3=Menor de 2 años |
| CH10 | N(1) | Asiste/asistió a establecimiento educativo: 1=Sí asiste, 2=No asiste pero asistió, 3=Nunca asistió |
| CH11 | N(1) | El establecimiento es: 1=Público, 2=Privado, 9=Ns./Nr. |
| CH12 | N(2) | Nivel más alto que cursa/cursó: 1=Jardín/Preescolar, 2=Primario, 3=EGB, 4=Secundario, 5=Polimodal, 6=Terciario, 7=Universitario, 8=Posgrado universitario, 9=Educación especial (discapacitado) |
| CH13 | N(1) | Finalizó ese nivel: 1=Sí, 2=No, 9=Ns./Nr. |
| CH14 | C(2) | Último año aprobado: 00=Ninguno, 01–09=Primero a Noveno, 98=Educación especial, 99=Ns./Nr. |
| CH15 | N(1) | Lugar de nacimiento: 1=En esta localidad de esta provincia, 2=En otra localidad, 3=En otra provincia (ver CH15_Cod), 4=En país limítrofe —Brasil, Bolivia, Chile, Paraguay, Uruguay— (ver CH15_Cod), 5=En otro país (ver CH15_Cod), 9=Ns./Nr. |
| CH15_Cod | C(3) | Código de provincia/país (según CH15=3, 4 o 5) |
| CH16 | N(1) | Lugar de residencia hace 5 años: 1=En esta localidad de esta provincia, 2=En otra localidad, 3=En otra provincia (ver CH16_Cod), 4=En país limítrofe (ver CH16_Cod), 5=En otro país (ver CH16_Cod), 6=No había nacido, 9=Ns./Nr. |
| CH16_Cod | C(3) | Código de provincia/país (según CH16=3, 4 o 5) |
| NIVEL_ED | N(1) | Nivel educativo: 1=Primaria incompleta (incl. educación especial), 2=Primaria completa, 3=Secundaria incompleta, 4=Secundaria completa, 5=Superior universitaria incompleta, 6=Superior universitaria completa, 7=Sin instrucción, 9=Ns./Nr. |
| ESTADO | N(1) | Condición de actividad: 0=Entrevista individual no realizada, 1=Ocupado, 2=Desocupado, 3=Inactivo, 4=Menor de 10 años |
| CAT_OCUP | N(1) | Categoría ocupacional: 1=Patrón, 2=Cuenta propia, 3=Obrero o empleado, 4=Trabajador familiar sin remuneración, 9=Ns./Nr. |
| CAT_INAC | N(1) | Categoría de inactividad: 1=Jubilado/Pensionado, 2=Rentista, 3=Estudiante, 4=Ama de casa, 5=Menor de 6 años, 6=Discapacitado, 7=Otros |
| IMPUTA | N(1) | Indica los casos imputados |

## II.3. Búsqueda de trabajo

| Campo | Tipo | Descripción |
|---|---|---|
| PP02C1 | N(1) | Hizo contactos, entrevistas |
| PP02C2 | N(1) | Mandó currículum, puso/contestó avisos (diarios, internet) |
| PP02C3 | N(1) | Se presentó en establecimientos |
| PP02C4 | N(1) | Hizo algo para ponerse por su cuenta |
| PP02C5 | N(1) | Puso carteles en negocios, preguntó en el barrio |
| PP02C6 | N(1) | Consultó a parientes, amigos |
| PP02C7 | N(1) | Se anotó en bolsas/listas/planes de empleo/agencias/contratistas, o alguien le busca trabajo |
| PP02C8 | N(1) | De otra forma activa |
| PP02E | N(1) | Motivo por el que no buscó trabajo en esos 30 días: 1=Está suspendido, 2=Ya tiene trabajo asegurado, 3=Se cansó de buscar, 4=Poco trabajo en esta época del año, 5=Otras razones |
| PP02H | N(1) | Buscó trabajo en algún momento en los últimos 12 meses: 1=Sí, 2=No |
| PP02I | N(1) | Trabajó en algún momento en los últimos 12 meses: 1=Sí, 2=No |

## II.4. Ocupados que trabajaron en la semana de referencia

| Campo | Tipo | Descripción |
|---|---|---|
| PP03C | N(1) | La semana pasada tenía: 1=Un sólo empleo/ocupación/actividad, 2=Más de uno |
| PP03D | N(1) | Cantidad de ocupaciones |
| PP3E_TOT | N(5,1) | Horas trabajadas en la semana, ocupación principal |
| PP3F_TOT | N(5,1) | Horas trabajadas en la semana, otras ocupaciones |
| PP03G | N(1) | Quería trabajar más horas: 1=Sí, 2=No |
| PP03H | N(1) | Si hubiera conseguido más horas: 1=Podía trabajarlas esa semana, 2=Podía empezar en dos semanas a más tardar, 3=No podía trabajar más horas, 9=Ns./Nr. |

## II.5. Para todos los ocupados

| Campo | Tipo | Descripción |
|---|---|---|
| PP03I | N(1) | Buscó trabajar más horas en últimos 30 días: 1=Sí, 2=No, 9=Ns./Nr. |
| PP03J | N(1) | Aparte de este/os trabajo/s, buscó otro empleo: 1=Sí, 2=No, 9=Ns./Nr. |
| INTENSI | N(1) | Intensidad de la ocupación: 1=Subocupado por insuficiencia horaria, 2=Ocupado pleno, 3=Sobreocupado, 4=Ocupado que no trabajó en la semana, 9=Ns./Nr. |

## II.6. Ocupación principal

| Campo | Tipo | Descripción |
|---|---|---|
| PP04A | N(1) | Tipo de negocio/empresa (el de más horas): 1=Estatal, 2=Privada, 3=De otro tipo (especificar) |
| PP04B_COD | N(5) | Rama de actividad (Clasificador CAES-Mercosur) |
| PP04B1 | N(1) | Servicio doméstico en hogares particulares: 1=Casa de familia |
| PP04B2 | N(1) | Cantidad de casas en que trabaja |
| PP04B3_MES/AÑO/DÍA | N(2) c/u | Antigüedad en el trabajo (casa de más horas) |
| PP04C | N(2) | Personas que trabajan allí en total: 1–12 (tramos desde 1 persona hasta más de 500), 99=Ns./Nr. |
| PP04C99 | N(1) | Tramo simplificado (si PP04C=99): 1=Hasta 5, 2=De 6 a 40, 3=Más de 40, 9=Ns./Nr. |
| PP04D_COD | C(5) | Código de ocupación (CNO, versión 2001) |
| PP04G | N(2) | Lugar donde realiza sus tareas: 1=Local/oficina/establecimiento/negocio/taller/chacra/finca, 2=Puesto o kiosco fijo callejero, 3=Vehículos (bicicleta/moto/autos/barcos/botes, no transporte), 4=Vehículo de transporte de personas/mercaderías, 5=Obras en construcción/infraestructura/minería, 6=En esta vivienda (sin lugar exclusivo), 7=En vivienda del socio o patrón, 8=Domicilio/local de los clientes, 9=Calle/espacios públicos/ambulante/de casa en casa, 10=Otro lugar (especificar) |

## II.7. Ocupación principal — trabajadores independientes

| Campo | Tipo | Descripción |
|---|---|---|
| PP05B2_MES/AÑO/DÍA | N(2) c/u | Antigüedad continua en el empleo |
| PP05C_1 | N(1) | Maquinarias/equipos: 1=Propio del negocio, 2=Prestado/alquilado, 3=No tiene |
| PP05C_2 | N(1) | Local (incl. kiosco/puesto fijo): 1=Propio, 2=Prestado/alquilado, 3=No tiene |
| PP05C_3 | N(1) | Vehículo: 1=Propio, 2=Prestado/alquilado, 3=No tiene |
| PP05E | N(1) | Gastó en materias primas/servicios en últimos 3 meses: 1=Sí, 2=No |
| PP05F | N(1) | El negocio trabaja habitualmente para: 6=Un sólo cliente, 7=Distintos clientes (incl. público en general) |
| PP05H | N(1) | Antigüedad continua en el empleo: 1=Menos de 1 mes, 2=De 1 a 3 meses, 3=Más de 3 a 6 meses, 4=Más de 6 meses a 1 año, 5=Más de 1 a 5 años, 6=Más de 5 años, 9=Ns./Nr. |

## II.8. Ingresos — ocupación principal, trabajadores independientes

| Campo | Tipo | Descripción |
|---|---|---|
| PP06A | N(1) | Tiene socios/familiares asociados: 1=Sí, 2=No |
| PP06C | N(10) | Monto de ingreso, patrones y cuenta propia sin socios |
| PP06D | N(10) | Monto de ingreso, patrones y cuenta propia con socios |
| PP06E | N(1) | Forma legal del negocio: 1=Sociedad jurídicamente constituida (SA, SRL, etc.), 2=Sociedad de otra forma legal, 3=Sociedad convenida de palabra |
| PP06H | N(1) | Es actividad familiar (sólo PP06E=2 o 3): 1=Sí, 2=No |

## II.9. Ocupación principal — asalariados (excepto servicio doméstico)

| Campo | Tipo | Descripción |
|---|---|---|
| PP07A | N(1) | Antigüedad continua en el empleo: 1=Menos de 1 mes, 2=1 a 3 meses, 3=Más de 3 a 6 meses, 4=Más de 6 a 12 meses, 5=Más de 1 a 5 años, 6=Más de 5 años, 9=Ns./Nr. |
| PP07C | N(1) | El empleo tiene tiempo de finalización: 1=Sí (changa, transitorio, tarea/obra, suplencia), 2=No (permanente/fijo/estable/de planta), 9=Ns./Nr. |
| PP07D | N(1) | Duración del trabajo (si PP07C=1): 1=Sólo esa vez/cuando lo llaman, 2=Hasta 3 meses, 3=Más de 3 a 6 meses, 4=Más de 6 a 12 meses, 5=Más de 1 año, 9=Ns./Nr. |
| PP07E | N(1) | El trabajo es: 1=Plan de empleo, 2=Período de prueba, 3=Beca/pasantía/aprendizaje, 4=Ninguno de éstos |

## II.10. Ocupación principal — asalariados (incluido servicio doméstico)

| Campo | Tipo | Descripción |
|---|---|---|
| PP07F1 | N(1) | Le dan de comer gratis en el lugar de trabajo: 1=Sí, 2=No |
| PP07F2 | N(1) | Le dan vivienda: 1=Sí, 2=No |
| PP07F3 | N(1) | Le dan producto o mercadería: 1=Sí, 2=No |
| PP07F4 | N(1) | Le dan otro beneficio (auto, celular, pasajes, etc.): 1=Sí, 2=No |
| PP07F5 | N(1) | No recibe ninguno: 1=Sí |
| PP07G1 | N(1) | Tiene vacaciones pagas: 1=Sí, 2=No |
| PP07G2 | N(1) | Tiene aguinaldo: 1=Sí, 2=No |
| PP07G3 | N(1) | Tiene días pagos por enfermedad: 1=Sí, 2=No |
| PP07G4 | N(1) | Tiene obra social: 1=Sí, 2=No |
| PP07G_59 | N(1) | No tiene ninguno: 5=Sí |
| PP07H | N(1) | Tiene descuento jubilatorio: 1=Sí, 2=No |
| PP07I | N(1) | Aporta por sí mismo a algún sistema jubilatorio: 1=Sí, 2=No |
| PP07J | N(1) | Turno habitual: 1=De día (mañana/tarde), 2=De noche, 3=De otro tipo (rotativo, día y noche, guardias con franco) |
| PP07K | N(1) | Al cobrar: 1=Recibo con sello/membrete/firma del empleador, 2=Papel/recibo sin nada, 3=Entrega una factura, 4=No le dan ni entrega nada, 5=No cobra, trabajador sin pago/ad-honorem |

## II.11. Ingresos — ocupación principal de los asalariados

| Campo | Tipo | Descripción |
|---|---|---|
| PP08D1 | N(10) | Monto total sueldos/jornales, salario familiar, horas extras, bonificaciones habituales y tickets/vales |
| PP08D4 | N(10) | Monto percibido en tickets |
| PP08F1 | N(10) | Monto por comisión por venta/producción |
| PP08F2 | N(10) | Monto por propinas |
| PP08J1 | N(6) | Monto de aguinaldo |
| PP08J2 | N(6) | Monto de otras bonificaciones no habituales |
| PP08J3 | N(6) | Monto de retroactivos |

## II.12. Movimientos interurbanos (sólo ocupados)

| Campo | Tipo | Descripción |
|---|---|---|
| PP09A | N(1) | [Sólo Cdad. de Bs. As. – Partidos del GBA] Trabaja en: 1=Ciudad de Buenos Aires, 2=Partidos del GBA, 3=Ambos, 4=En otro lugar |
| PP09A_ESP | C(90) | Especificación de otro lugar |
| PP09B | N(1) | [Sólo Posadas, Formosa, Corrientes, Resistencia, Santa Fe, Paraná, Neuquén] Trabaja en esta ciudad: 1=Sí, 2=No |
| PP09C | N(1) | Dónde trabaja: 1=En otro lugar de esta provincia, 2=En otra provincia, 3=En otro país |
| PP09C_ESP | C(90) | Descripción de otro lugar |

## II.13. Desocupados

| Campo | Tipo | Descripción |
|---|---|---|
| PP10A | N(1) | Tiempo buscando trabajo: 1=Menos de 1 mes, 2=De 1 a 3 meses, 3=Más de 3 a 6 meses, 4=Más de 6 a 12 meses, 5=Más de 1 año |
| PP10C | N(1) | Hizo algún trabajo/changa durante ese tiempo: 1=Sí, 2=No |
| PP10D | N(1) | Ha trabajado alguna vez: 1=Sí, 2=No |
| PP10E | N(1) | Tiempo desde que terminó su último trabajo/changa: 1=Menos de 1 mes, 2=De 1 a 3 meses, 3=Más de 3 a 6 meses, 4=Más de 6 a 12 meses, 5=Más de 1 a 3 años, 6=Más de 3 años |

## II.14. Desocupados con empleo anterior (última ocupación/changa, finalizada hace ≤3 años)

| Campo | Tipo | Descripción |
|---|---|---|
| PP11A | N(1) | Tipo de negocio/empresa: 1=Estatal, 2=Privada, 3=De otro tipo |
| PP11B_COD | N(5) | Rama de actividad (CAES-Mercosur) |
| PP11B1 | N(1) | Servicio doméstico en hogares particulares: 1=Casa de familia |
| PP11B2_MES/AÑO/DÍA | N(2) c/u | Tiempo trabajado allí |
| PP11C | N(2) | Personas que trabajaban allí en total (tramos, misma estructura que PP04C), 99=Ns./Nr. |
| PP11C99 | N(1) | Tramo simplificado (si PP11C=99): 1=Hasta 5, 2=De 6 a 40, 3=Más de 40, 9=Ns./Nr. |
| PP11D_COD | C(5) | Código de ocupación (CNO, versión 2001) |
| PP11G_AÑO/MES/DÍA | N(2) c/u | Tiempo seguido trabajando en ese lugar |
| PP11L | N(1) | Razón principal por la que dejó esa actividad: 1=Falta de clientes/clientes que no pagan, 2=Falta de capital/equipamiento, 3=Trabajo estacional, 4=Gastos demasiado altos, 5=Otras causas laborales (especificar), 6=Jubilación/retiro, 7=Causas personales (matrimonio, embarazo, cuidado de hijos/familiar, estudio, enfermedad) |
| PP11L1 | N(1) | Tipo de trabajo: 1=Changa/transitorio/por tarea u obra/suplencia, 2=Permanente/fijo/estable/de planta, 3=Ns./Nr. |
| PP11M | N(1) | El trabajo era: 1=Plan de empleo, 2=Período de prueba, 3=Otro tipo de trabajo |
| PP11N | N(1) | Le hacían descuento jubilatorio: 1=Sí, 2=No, 9=Ns./Nr. |
| PP11O | N(2) | Razón principal por la que dejó ese trabajo: 1=Despido/cierre (quiebra/venta/traslado/reestructuración/recorte de personal/falta de ventas o clientes), 2=Retiro voluntario del sector público, 3=Jubilación, 4=Fin de trabajo temporario/estacional, 5=Le pagaban poco/no le pagaban, 6=Malas relaciones/condiciones laborales, 7=Renuncia obligada/pactada, 8=Otras causas laborales (especificar), 9=Razones personales (matrimonio, embarazo, cuidado de hijos/familia, estudio, enfermedad) |
| PP11P | N(1) | Cerró la empresa (si PP11O=1): 1=Sí, 2=No, 9=Ns./Nr. |
| PP11Q | N(1) | Fue la única persona que quedó sin trabajo: 1=Sí, 2=No, 9=Ns./Nr. |
| PP11R | N(1) | Le enviaron telegrama: 1=Sí, 2=No |
| PP11S | N(1) | Le pagaron indemnización: 1=Sí, 2=No |
| PP11T | N(1) | Está cobrando seguro de desempleo: 1=Sí, 2=No, 9=Ns./Nr. |

## II.15. Ingresos de la ocupación principal

| Campo | Tipo | Descripción |
|---|---|---|
| P21 | N(10) | Monto de ingreso de la ocupación principal |
| DECOCUR | C(2) | Decil de ingreso de ocupación principal — TOTAL EPH |
| IDECOCUR | C(2) | Ídem — INTERIOR |
| RDECOCUR | C(2) | Ídem — REGIÓN |
| GDECOCUR | C(2) | Ídem — aglomerados ≥500 mil hab. |
| PDECOCUR | C(2) | Ídem — aglomerados <500 mil hab. |
| ADECOCUR | C(2) | Ídem — AGLOMERADO |
| PONDIIO | N(6) | Ponderador del ingreso de la ocupación principal |

## II.16. Ingreso de otras ocupaciones

| Campo | Tipo | Descripción |
|---|---|---|
| Tot_p12 | N(12) | Monto de ingreso de otras ocupaciones (secundaria, previa a la semana de referencia, deudas/retroactivos de ocupaciones anteriores al mes de referencia, etc.) |

## II.17. Ingreso total individual

| Campo | Tipo | Descripción |
|---|---|---|
| P47T | N(10) | Monto de ingreso total individual (suma de ingresos laborales y no laborales) |
| DECINDR | C(2) | Decil de ingreso total individual — TOTAL EPH |
| IDECINDR | C(2) | Ídem — INTERIOR |
| RDECINDR | C(2) | Ídem — REGIÓN |
| GDECINDR | C(2) | Ídem — aglomerados ≥500 mil hab. |
| PDECINDR | C(2) | Ídem — aglomerados <500 mil hab. |
| ADECINDR | C(2) | Ídem — AGLOMERADO |
| PONDII | N(6) | Ponderador del ingreso total individual |

## II.18. Ingresos no laborales

| Campo | Tipo | Descripción |
|---|---|---|
| V2_M | N(6) | Monto por jubilación o pensión |
| V3_M | N(6) | Monto por indemnización por despido |
| V4_M | N(6) | Monto por seguro de desempleo |
| V5_M | N(6) | Monto por subsidio/ayuda social (gobierno, iglesias, etc.) |
| V8_M | N(6) | Monto por alquiler de su propiedad |
| V9_M | N(6) | Monto por ganancias de negocio en el que no trabajó |
| V10_M | N(6) | Monto por intereses/rentas de plazos fijos/inversiones |
| V11_M | N(6) | Monto por beca de estudio |
| V12_M | N(6) | Monto por cuotas de alimentos/ayuda de personas ajenas al hogar |
| V18_M | N(6) | Monto por otros ingresos en efectivo (limosnas, juegos de azar, etc.) |
| V19_AM | N(6) | Monto por trabajo de menores de 10 años |
| V21_M | N(6) | Monto por aguinaldo |
| T_Vi | N(12,4) | Monto total de ingresos no laborales |

## II.19. Ingreso total familiar

| Campo | Tipo | Descripción |
|---|---|---|
| ITF | N(12,2) | Monto del ingreso total familiar |
| DECIFR | C(2) | Decil de ITF — TOTAL EPH |
| IDECIFR | C(2) | Ídem — INTERIOR |
| RDECIFR | C(2) | Ídem — REGIÓN |
| GDECIFR | C(2) | Ídem — aglomerados ≥500 mil hab. |
| PDECIFR | C(2) | Ídem — aglomerados <500 mil hab. |
| ADECIFR | C(2) | Ídem — AGLOMERADO |

## II.20. Ingreso per cápita familiar

| Campo | Tipo | Descripción |
|---|---|---|
| IPCF | N(12,2) | Monto del ingreso per cápita familiar |
| DECCFR | C(2) | Decil de IPCF — TOTAL EPH |
| IDECCFR | C(2) | Ídem — INTERIOR |
| RDECCFR | C(2) | Ídem — REGIÓN |
| GDECCFR | C(2) | Ídem — aglomerados ≥500 mil hab. |
| PDECCFR | C(2) | Ídem — aglomerados <500 mil hab. |
| ADECCFR | C(2) | Ídem — AGLOMERADO |
| PONDIH | N(6) | Ponderador del ITF y del IPCF, para hogares |

---

# III. Anexo I — Recomendaciones técnicas para el uso de la información de ingresos

**Montos de ingreso.** Se incluyen montos captados directamente en los cuestionarios y variables construidas por sumatoria de distintas fuentes:
- `P21`: total de ingresos habituales de la ocupación principal del individuo.
- `P47T`: sumatoria de ingresos laborales y no laborales del individuo.
- `ITF`: sumatoria de los ingresos individuales totales de todos los componentes del hogar.
- `IPCF`: ITF dividido la cantidad de miembros del hogar.

**Escalas decílicas.** Se calculan seis variantes territoriales para cada tipo de ingreso:

| Tipo de ingreso | TOTAL aglom. | AGLOMERADO | Región | Aglom. <500 mil hab. | Aglom. ≥500 mil hab. | Interior |
|---|---|---|---|---|---|---|
| Ingreso total individual | DECINDR | ADECINDR | RDECINDR | PDECINDR | GDECINDR | IDECINDR |
| Ingreso ocupación principal | DECOCUR | ADECOCUR | RDECOCUR | PDECOCUR | GDECOCUR | IDECOCUR |
| Ingreso total familiar | DECIFR | ADECIFR | RDECIFR | PDECIFR | GDECIFR | IDECIFR |
| Ingreso per cápita familiar | DECCFR | ADECCFR | RDECCFR | PDECCFR | GDECCFR | IDECCFR |

**Categorías de las variables de decil:**
00=Sin ingresos; 1–10=Decil 1 a 10; 12=No respuesta de ingresos; 13=Entrevista individual no realizada.

**Factores de expansión.** Para minimizar el efecto de la no respuesta de ingresos, se asignó a los no respondentes el comportamiento de los respondentes por estrato de la muestra. Existen dos tipos de ponderadores:

1. `PONDERA` — sin corrección; se usa para el resto de las variables.
2. Con corrección por no respuesta:
   - `PONDII` — ingreso total individual (P47T, DECINDR, ADECINDR, RDECINDR, PDECINDR, GDECINDR, IDECINDR).
   - `PONDIIO` — ingreso de la ocupación principal (P21, PP06C, PP06D, PP08D1, PP08D4, PP08F1, PP08F2, PP08J1, PP08J2, PP08J3, DECOCUR, ADECOCUR, RDECOCUR, PDECOCUR, GDECOCUR, IDECOCUR).
   - `PONDIH` — ingreso total familiar e ingreso per cápita familiar (ITF, DECIFR, ADECIFR, RDECIFR, PDECIFR, GDECIFR, IDECIFR; IPCF, DECCFR, ADECCFR, RDECCFR, PDECCFR, GDECCFR, IDECCFR).

Los campos de decil se presentan calculados con ponderadores corregidos por no respuesta; el usuario puede recalcular los deciles sin corrección usando `PONDERA`.

**Comentarios generales:**
- Los códigos 9, 99, 999, 9999 corresponden, salvo indicación en contrario, a "Ns./Nr.".
- Excepción: en los montos de ingreso, la no respuesta se identifica con el código **-9**.
- Los montos captados en `PP06C` y `PP06D` presentan además los códigos **-7** ("No tenía esa ocupación en el mes de referencia") y **-8** ("No tuvo ingresos por el mes de referencia").
- El código **0** identifica los casos a los que no corresponde la secuencia analizada.

---

**Créditos institucionales:** Responsable de la edición: Lic. Jorge Todesca. Director técnico: Mag. Pedro Lines. Directora de la publicación: Mag. Silvina Viazzi.


Una observación de contenido: en BASE PERSONAS reordené los códigos especiales (51/71) bajo COMPONENTE únicamente —en el PDF original aparecen listados también debajo de NRO_HOGAR, lo que es casi con certeza un artefacto de extracción del documento, ya que esos valores (servicio doméstico/pensionistas) corresponden semánticamente al número de componente, no al número de hogar.
