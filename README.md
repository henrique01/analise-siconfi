## analise-siconfi

# Análise de Indicadores Financeiros com Dados do Siconfi

O objetivo desse projeto é possibilitar a análise financeira e o cálculo de indicadores financeiros dos municípios brasileiros.

## Manipulação dos dados

Para tornar possível o cálculo dos indicadores, os dados precisaram ser manipulados para assumir um formato mais conveniente ao cálculo - o formato **tidy**, do pacote `tidyverse`. Além disso, foram criadas siglas para as contas, utilizando a função `abbreviate()`.

### Formato dos dados: antes e depois
##### Antes da manipulação:
![Antes da manipulação](extras/antes.JPG)
##### Depois da manipulação:
![Depois da manipulação](extras/depois.JPG)

