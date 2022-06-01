rm(list = ls())

if (!require(rvest)) install.packages(rvest)
library(rvest)

url = 'https://www.pciconcursos.com.br/concursos/nacional/'
urls_regioes = url %>%
  read_html() %>%
  html_nodes('.regioes') %>%
  html_nodes('a') %>%
  html_attr('href')

res = sapply(urls_regioes, \(url) {
  url %>%
    read_html() %>%
    html_nodes('.ca') %>%
    html_nodes('[rel="bookmark"]') %>%
    html_attr('href')
})

saveRDS(res, file.path('results', 'lista-urls-concursos.rds'))