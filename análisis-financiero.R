
##Cargar librerías necesarias
library(fBasics)
library(PerformanceAnalytics)
library(xts)
library(quantmod)
library(ggplot2)
library(tseries)
library(dygraphs)
options(warn = -1)

## con fechas de: 1ro-enero 2005 al 30 junio 2021 
## a partir de los precios de cierre

start <- format(as.Date("2024-01-01"), "%Y-%m-%d")
end <- format(as.Date("2024-12-31"), "%Y-%m-%d")

#Definir función personalizada rend()
#oma como argumentos un símbolo bursátil (por ejemplo, "AAPL") y las fechas de inicio y fin.
rend <- function(simbolo, start, end) {

#Baja datos históricos del activo financiero desde Yahoo Finance.
#auto.assign = FALSE: guarda los datos en la variable datos (sin crear un objeto por fuera).  
datos <- getSymbols(simbolo, src = "yahoo", auto.assign = FALSE)
#Eliminar valores faltantes
datos <- na.omit(datos)
#Selecciona la 4ta columna que, en la estructura de Yahoo Finance, es el precio de cierre ajustado
datos <- datos[, 4]
#Calcular rendimientos diarios
rend <- periodReturn(datos, period = "daily", subset = paste(c(start, end), "::", sep = ""), type = 'arithmetic')

#Crea un objeto en el entorno global que contiene los rendimientos calculados.
#Esto te permite usar directamente ese nombre para graficar, calcular media, varianza, etc.
assign(simbolo, rend, envir = .GlobalEnv)
}

## Visualizar rendimientos de AAPL & IBM

rend("AAPL", start, end)
str(AAPL)

rend("IBM", start, end)
str(IBM)

rends <- merge.xts(AAPL, IBM)

colnames(rends) <- c("AAPL", "IBM")

dygraph(rends, main = "AAPL & IBM Rendimientos") %>%
  dyAxis("y", label = "Rend %") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set1"))

####aquí analizas los momentos estadísticos de los rendimientos 
####para evaluar su comportamiento: media, varianza, sesgo, curtosis y pruebas de normalidad.

##Este codigo da un resumen completo: media, desviación estándar, mínimo, máximo, curtosis, sesgo, etc.

basicStats(AAPL)

##Media, varianza y desviación estándar

mean(AAPL)
var(AAPL)
stdev(AAPL)

#Prueba t de la media (H₀: media = 0)
#Prueba si el rendimiento promedio es estadísticamente diferente de 0.
#Si el p-valor es bajo (< 0.05), rechazas H₀: hay evidencia de que el retorno promedio no es cero.

t.test(AAPL)

##Cálculo del sesgo (asimetría)
#Positivo: cola más larga a la derecha (posibles ganancias extremas)
#Negativo: cola más larga a la izquierda (riesgo de pérdidas fuertes).

s3 = skewness(AAPL)
T = length(AAPL)
t3 = s3 / sqrt(6 / T)

##Prueba de hipótesis para sesgo
#Calcula el p-valor de la prueba t anterior.
#Si pp > 0.05: no se rechaza H₀ (el sesgo no es significativamente diferente de 0).

pp = 2 * pt(abs(t3), T - 1, lower = FALSE)

#Cálculo de curtosis (colas pesadas o ligeras)
s4 = kurtosis(AAPL)
t4 = s4 / sqrt(24 / T)

#Prueba de hipótesis para curtosis
#Si pv > 0.05: no hay evidencia significativa de exceso de curtosis (colas normales).
pv = 2 * (1 - pnorm(t4))

#Prueba de normalidad: Jarque-Bera
normalTest(FB, method = 'jb')

##HACEMOS EL MISMO PROCEDIMIENTO CON EL SEGUNDO ACTIVO

basicStats(IBM)

mean(IBM)     # rendimiento promedio diario
var(IBM)      # volatilidad al cuadrado
stdev(IBM)    # volatilidad (riesgo típico)

t.test(IBM)

s3 = skewness(IBM)
T = length(IBM)
t3 = s3 / sqrt(6 / T)
t3

pp = 2*(1 - pnorm(abs(t3)))
pp

s4 = kurtosis(IBM)
t4 = s4 / sqrt(24 / T)
t4

pv = 2 * (1 - pnorm(t4))
pv

normalTest(IBM, method = 'jb')


###visualiza la distribución de los rendimientos diarios de los activos mediante histogramas, 
###y los compara contra una distribución normal.

#Activas la librería PerformanceAnalytics.
library(PerformanceAnalytics)
par(mfrow=c(1,2))

#Primer gráfico: distribución de AAPL
chart.Histogram(AAPL, 
                methods = c("add.normal", "add.density"), 
                colorset = c("gray", "blue", "red"))
legend("topright", 
       legend = c("Hist-AAPL" ,"AAPL dist","dnorm AAPL"), 
       col=c("gray", "blue", "red"), lty=1, cex = 0.7)

#Segundo gráfico: distribución de IBM
chart.Histogram(IBM, 
                methods = c("add.normal", "add.density"), 
                colorset = c("gray", "blue", "red"))
legend("topright", 
       legend = c("Hist-IBM" ,"IBM dist","dnorm IBM"), 
       col=c("gray", "blue", "red"), lty=1, cex = 0.7)


