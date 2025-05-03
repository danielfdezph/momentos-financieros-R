# Archivo de instalación de librerías necesarias para el proyecto
# Autor: danielfdezph
# Fecha: 03-05-2025

paquetes <- c(
  "fBasics",
  "PerformanceAnalytics",
  "xts",
  "quantmod",
  "ggplot2",
  "tseries",
  "dygraphs"
)

# Instala solo los paquetes que no estén instalados aún
instalar <- paquetes[!(paquetes %in% installed.packages()[,"Package"])]

if(length(instalar)) install.packages(instalar)

# Carga las librerías
lapply(paquetes, library, character.only = TRUE)
