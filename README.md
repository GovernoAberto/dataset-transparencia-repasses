# O que é?

Script que realiza o tratamento dos dados de repasses disponíveis no Portal da Transparência do Governo Federal e permite exportar para um banco de dados

Fonte original: http://transparencia.gov.br/download-de-dados/transferencias

# Como executar

1) Executar o comando "python extract.py" para extrair os arquivos zipados da pasta /download
2) Executar o comando "Rscript process.R" para gerar um único arquivo em /output
3) Renomear .env.example para .env e preencher as variáveis 
4) Executar o comando "python save.py" para salvar o arquivo em uma tabela
