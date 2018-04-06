#listar todas as tabelas em um schema (siconfi)
dbGetQuery(con,
           "SELECT table_name FROM information_schema.tables
           WHERE table_schema='siconfi'")

#listar todas as tabelas
dbListTables(con)

#listar todos os schemas
dbGetQuery(con, "SELECT nspname FROM pg_catalog.pg_namespace")

#cria um novo subconjunto apenas com as colunas: instituicao, conta e valor
subbp2015 <- subset(bpsp, select = c(instituicao, conta, valor))

#Filtrar estado de São Paulo
bpsp <- filter(bp2015, uf == "SP")


#cria uma tabela mais enxuta
bp2015t <- tibble(bp2015$cod.ibge, bp2015$cod.conta, bp2015$conta, bp2015$valor)
names(bp2015t)[1] <- "cod.ibge"
names(bp2015t)[2] <- "cod.conta"
names(bp2015t)[3] <- "conta"
names(bp2015t)[4] <- "valor"

teste1 <- ifelse(grepl("[[:digit:]]", bp2015$conta) 
                 , bp2015$conta %>% substring(first = 19) %>% abbreviate(minlength = 3)
                 , bp2015$conta %>% abbreviate(minlength = 3)
)


bprp <- tibble(bprp$municipio, bprp$cod.ibge, bprp$conta.abr, bprp$valor)
names(bprp)[1] <- "municipio"
names(bprp)[2] <- "cod.ibge"
names(bprp)[3] <- "conta.abr"
names(bprp)[4] <- "valor"


bp2015$conta.abr <- abbreviate(bp2015$conta, minlength = 3)

