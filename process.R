if(!require('dplyr')) 
  install.packages('dplyr');

library('dplyr')

files <- list.files("download", pattern = "\\.csv$")

if(length(files) == 0)
  stop("Files not founded in 'download' dir")

print(paste("Lendo download/", files[1], sep = ""))

transferencias <- read.csv2(paste("download/", files[1], sep = "")) %>% 
  mutate(ANO = substr(ANO...MÊS, 1, 4), MES = substr(ANO...MÊS, 5, 6)) %>% 
  select(-ANO...MÊS, -NOME.MUNICÍPIO)

for(file in tail(files, -1)) {
  print(paste("Lendo download/", file, sep = ""))
  
  aux <- read.csv2(paste("download/", file, sep = "")) %>% 
    mutate(ANO = substr(ANO...MÊS, 1, 4), MES = substr(ANO...MÊS, 5, 6)) %>% 
    select(-ANO...MÊS, -NOME.MUNICÍPIO)
  
  aux <- aux %>% filter(!is.na(CÓDIGO.MUNICÍPIO.SIAFI))
  transferencias <- rbind(aux, transferencias) 
}

print("Processando arquivo final...")
transferencias <- transferencias %>% select(ANO, MES, CÓDIGO.MUNICÍPIO.SIAFI, TIPO.TRANSFERÊNCIA, TIPO.FAVORECIDO, NOME.FUNÇÃO, NOME.PROGRAMA, VALOR.TRANSFERIDO)
transferencias <- setNames(transferencias, c("ano", "mes", "codigo_siafi", "tipo_transferencia", "tipo_favorecido", "nome_funcao", "nome_programa",  "valor_transferido"))
transferencias$valor_transferido <- sub(",",".",transferencias$valor_transferido)
transferencias <- transferencias %>% mutate(tipo_transferencia = case_when(
  tipo_transferencia == 'Legais, Voluntárias e Específicas' ~ 1,
  tipo_transferencia == 'Constitucionais e Royalties' ~ 2
))

print("Salvando csv...")
write.csv2(transferencias, "output/transferencias.csv", row.names = FALSE, na = "")
