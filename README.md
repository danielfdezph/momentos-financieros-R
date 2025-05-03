# momentos-financieros-R
Aplicaré  los conocimientos de los momentos estadísticos para realizar un ejercicio práctico que caracterice y compare dos series financieras de rendimientos en R.
# 📊 Análisis de las acciones de AAPL & IBM durante el año 2024

Este proyecto tiene como objetivo analizar los rendimientos de las acciones de APPLE (AAPL) y IBM (IBM), obteniendo momentos estadísticos: media, varianza, sesgo, curtosis, realizando pruebas de normalidad: t-test y Jarque-Bera, visualizar la distribución de rendimientos y comparar con la distribución normal

---

## 🔍 Objetivos

- Obténer los rendimientos simples de los activos: AAPL e IBM con fechas de: 1ro-enero 2024 al 31 de Diciembre 2024 a partir de los precios de cierre.
- Generar un resumen estadístico de los rendimientos de los activos.
- Aplica la prueba de t-simple, para determinar si la media de los rendimientos es igual o diferente de cero en los activos.
- Determinar el valor del sesgo de los activos
- Determinar el estadístico de prueba t para el valor del sesgo
- Determinar el p-valor del estadístico de prueba de sesgo
- Interpretar el resultado del p-valor de la prueba de sesgo
- Determinar el valor de la curtosis de los activos
- Determinar el p-valor del estadístico de prueba de la curtosis de los activos
- Interpretar el resultado del p-valor de la prueba de curtosis de los activos
- Aplicar la prueba Jarque-Bera y Shapiro a la serie de rendimientos de los activos e interpretar

---

## 🧰 Tecnologías utilizadas

- R 4.5.0 (para macOS ARM64)
- RStudio
- Librerías utilizadas:
  - `fBasics`
  - `PerformanceAnalytics`
  - `xts`
  - `quantmod`
  - `ggplot2`
  - `tseries`
  - `dygraphs`
---

## 🧪 Estructura del proyecto

📄 análisis-financiero.R   → Script principal con análisis estadístico en R
📄 requirements.R          → Script para instalar y cargar las librerías necesarias
📄 README.md               → Explicación general del proyecto (este archivo)
📄 LICENSE                 → Licencia de uso (MIT)
📄 .gitignore              → Archivos excluidos del control de versiones



## 📊 Resultados

📉 **AAPL** (Apple Inc.)
  - Rendimiento promedio diario: **−0.0109%**
  - Volatilidad (desviación estándar): **2.15%**
  - **p-valor (prueba t): 0.9172**, por lo tanto **no hay evidencia estadística** de que el rendimiento promedio difiera de cero.
  - **Sesgo (skewness): 1.07**, indicando asimetría positiva (más probabilidad de ganancias extremas).
  - **Curtosis: 13.34**, sugiere colas pesadas (alta probabilidad de eventos extremos).
  - **Prueba de normalidad Jarque-Bera:** p < 2.2e−16 → **se rechaza la hipótesis de normalidad**.

📈 **IBM**
  - Rendimiento promedio diario: **+0.1408%**
  - Volatilidad (desviación estándar): **1.90%**
  - **p-valor (prueba t): 0.1302**, no es estadísticamente significativo; no se rechaza la hipótesis de media igual a cero.
  - **Sesgo (skewness): 1.21**, también muestra asimetría positiva.
  - **Curtosis: 12.51**, indica colas pesadas.
  - **Prueba de normalidad Jarque-Bera:** p < 2.2e−16 → **los rendimientos no siguen una distribución normal**.

## Visualización de rendimientos

Se utilizó un gráfico interactivo con `dygraphs` para visualizar los rendimientos diarios de **AAPL** (rojo) e **IBM** (azul) entre enero de 2024 y marzo de 2025.

- Se observa una **mayor volatilidad en AAPL**, con picos positivos y negativos más pronunciados.
- IBM muestra una evolución más contenida y estable, aunque también presenta variabilidad.
- El comportamiento sugiere que AAPL conlleva **más riesgo y mayor potencial de ganancias/pérdidas extremas** que IBM en este periodo.

> Este tipo de visualización es útil para observar la evolución conjunta de los activos y detectar episodios de alta volatilidad en tiempo real.
