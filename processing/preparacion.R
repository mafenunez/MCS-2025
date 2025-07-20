# 0. PREPARACIÓN DATOS OLA 2023
# María Fernanda Núñez y Tomás Urzúa

# ---- 1. cargar librerias ----------------------------------------------------
pacman::p_load(tidyverse, dplyr, car)

# ---- 2. cargar datos --------------------------------------------------------
load("input/elsoc_2023.RData")

# ---- 3. seleccionar ---------------------------------------------------------
proc_data <- elsoc_2023 %>% select(just_educacion = d02_02,
                                   ingreso_hogar = m29,
                                   estatus_subj = d01_01,
                                   genero = m0_sexo,
                                   esfuerzo = c18_09,
                                   talento = c18_10) 

# ---- 4. procesamiento -------------------------------------------------------

## ingreso:
proc_data$ingreso_hogar <-recode(proc_data$ingreso_hogar, "c(-777,-888,-999)=NA")


## estatus social subjetivo:
proc_data$estatus_subj <-recode(proc_data$estatus_subj, "c(-666,-777,-888,-999)=NA")
proc_data$estatus_subj <- as.numeric(proc_data$estatus_subj)

                            
## esfuerzo
proc_data$esfuerzo <- as.factor(proc_data$esfuerzo)
proc_data$esfuerzo <- car::recode(proc_data$esfuerzo,
                                        recodes = c("1 = 'Totalmente en desacuerdo';
                                                       2 = 'En desacuerdo';
                                                       3 = 'Ni de acuerdo ni en desacuerdo';
                                                       4 = 'De acuerdo';
                                                       5 = 'Totalmente de acuerdo';
                                                       -888 = NA; 
                                                       -999 = NA;
                                                      -777 = NA;
                                                      -666=NA"),
                                  levels = c("Totalmente en desacuerdo",
                                             "En desacuerdo",
                                             "Ni de acuerdo ni en desacuerdo",
                                             "De acuerdo",
                                             "Totalmente de acuerdo"))

## talento 
proc_data$talento <- as.factor(proc_data$talento)
proc_data$talento <- car::recode(proc_data$talento,
                                        recodes = c("1 = 'Totalmente en desacuerdo';
                                                       2 = 'En desacuerdo';
                                                       3 = 'Ni de acuerdo ni en desacuerdo';
                                                       4 = 'De acuerdo';
                                                       5 = 'Totalmente de acuerdo';
                                                       -888 = NA; 
                                                       -999 = NA;
                                                      -777 = NA;
                                                      -666=NA"),
                                 levels = c("Totalmente en desacuerdo",
                                            "En desacuerdo",
                                            "Ni de acuerdo ni en desacuerdo",
                                            "De acuerdo",
                                            "Totalmente de acuerdo"))

## género

proc_data$genero <- as.factor(proc_data$genero)
proc_data$genero <- car::recode(proc_data$genero,
                                recodes = c("1 = 'Hombre';
                                                       2 = 'Mujer'"))

## justicia de mercado en la educación

proc_data$just_educacion <- as.factor(proc_data$just_educacion)
proc_data$just_educacion <- car::recode(proc_data$just_educacion,
                               recodes = c("1 = 'Totalmente en desacuerdo';
                                                       2 = 'En desacuerdo';
                                                       3 = 'Ni de acuerdo ni en desacuerdo';
                                                       4 = 'De acuerdo';
                                                       5 = 'Totalmente de acuerdo';
                                                       -888 = NA; 
                                                       -999 = NA;
                                                      -777 = NA;
                                                      -666=NA"),
                               levels = c("Totalmente en desacuerdo",
                                          "En desacuerdo",
                                          "Ni de acuerdo ni en desacuerdo",
                                          "De acuerdo",
                                          "Totalmente de acuerdo"))


## tratamiento casos perdidos:
proc_data <- proc_data %>% na.omit() # se omiten 260 casos, un 9,53% de la muestra

# ---- 5. guardar datos procesados --------------------------------------------
save(proc_data,file = "output/proc_data.RData")


