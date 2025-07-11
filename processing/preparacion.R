
pacman::p_load(tidyverse, dplyr, car, haven)

proc_data <- read_sav("input/ELSOC_Long_2016_2023.sav")
proc_data <- proc_data %>% select(just_educacion = d02_02,
                                              cercania_escuelas = t06_06,
                                              remuneracion_justa = m15,
                                               ingreso_hogar = m29,
                                               estatus_subj = d01_01,
                                                genero = m0_sexo,
                                                  ola) %>% filter(ola == 7)

## ingreso
proc_data$ingreso_hogar <-recode(proc_data$ingreso_hogar, "c(-777,-888,-999)=NA")

## ingreso justo
proc_data$remuneracion_justa <-recode(proc_data$remuneracion_justa, "c(-888,-999)=NA")


## estatus social subjetivo
proc_data$estatus_subj <-recode(proc_data$estatus_subj, "c(-666,-777,-888,-999)=NA")
proc_data$estatus_subj <- as.numeric(proc_data$estatus_subj)

## proximidad colegios
proc_data$cercania_escuelas <- as.factor(proc_data$cercania_escuelas)
proc_data$cercania_escuelas <- car::recode(proc_data$cercania_escuelas,
                               recodes = c("1 = ' Totalmente insatisfecho';
                                                       2 = 'Insatisfecho ';
                                                       3 = 'Ni satisfecho ni insatisfecho';
                                                       4 = 'Satisfecho ';
                                                       5 = 'Totalmente satisfecho';
                                                       -888 = NA; 
                                                       -999 = NA;
                                                      -777 = NA;
                                                      -666=NA"))



## dependiente

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
                                                      -666=NA"))


proc_data$genero <- as.factor(proc_data$genero)
proc_data$genero <- car::recode(proc_data$genero,
                                        recodes = c("1 = 'Hombre';
                                                       2 = 'Mujer'"))
# ---- 4. guardar datos procesados --------------------------------------------
save(proc_data,file = "output/proc_data.RData")


