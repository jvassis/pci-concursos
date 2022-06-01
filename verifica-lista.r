rm(list = ls())
library(rvest)

urls_concursos = readRDS('lista-urls-concursos.rds')

res = lapply(urls_concursos, \(urls_regiao) {
  lapply(urls_regiao, \(url) {
    page = read_html(url)
    verifica = page %>%
      html_text() %>%
      iconv(., to = 'ascii//translit') %>%
      tolower() %>%
      grepl('estatistico|estatistica', .)
    urls_pdfs = page %>%
      html_nodes('.pdf') %>%
      html_nodes('a') %>%
      (\(a) {
        a[a %>%
            html_text() %>%
            tolower() %>%
            iconv(., to = 'ascii//translit') %>%
            grepl('abertura|retificacao', .)]
      }) %>%
      html_attr('href')
    return(list(verifica = verifica, urls_pdfs = urls_pdfs))
  })
})

saveRDS(res, 'lista-verificacao-urls.rds')