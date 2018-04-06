library(RPostgreSQL)
library(tidyverse)

#Cria conexão com o banco e aplica a codificação correta
source("conexao.R")
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'")
#A variável con foi criada do script conexao.R por questões de segurança, 
#pois contem dados de conexão a um banco de dados.

#grava a tabela dos balancos patrimoniais 
bp2015 <- dbReadTable(con, c("siconfi", "balanco_patrimonial_2015"))

#Cria uma coluna apenas com o código das contas
bp2015$cod.conta <- ifelse(grepl("[[:digit:]]", bp2015$conta) 
                 , bp2015$conta %>% substring(first = 1, last = 15)
                 , bp2015$conta)
#Algumas contas não contém códigos. Caso não possua, o nome da conta será replicado.

#Isola o nome da conta na coluna
bp2015$conta.nome <- ifelse(grepl("[[:digit:]]", bp2015$conta) 
                 , bp2015$conta %>% substring(first = 19)
                 , bp2015$conta)
#Algumas contas não contém códigos. Caso não possua, o nome da conta será mantido.

#Cria abreviações para o nome das contas
bp2015$conta.abr <- abbreviate(bp2015$conta, minlength = 3)

#Cria uma tabela com as contas e as respectivas abreviações e códigos
tabelacontas <- tibble(bp2015$conta, bp2015$cod.conta, bp2015$conta.nome, bp2015$conta.abr)
tabelacontas <- unique(tabelacontas)
names(tabelacontas)[1] <- "cod.conta"
names(tabelacontas)[2] <- "conta"
names(tabelacontas)[3] <- "conta.nome"
names(tabelacontas)[4] <- "conta.abr"

#importa tabela de códigos e nomes de municípios
municipios <- read.csv2("municipio-brasil.csv", header = TRUE)

#Unifica os dados
bp2015 <- full_join(bp2015, municipios, by = "cod.ibge")

#reordena as colunas e apaga algumas colunas (deixa apenas nome, apaga código contas)
bp2015 <- bp2015[c(13, 2, 3, 12, 11, 4, 5, 10, 7)]

#Filtro a microrregiao de Ribeirão Preto
bprp2015<- filter(bp2015, microrregiao == "Ribeirão Preto")

#Rearranja para que apenas um município ocupe uma linha
bprp2015s <- spread(bprp2015, conta.abr, valor)


head(teste)
###################

 