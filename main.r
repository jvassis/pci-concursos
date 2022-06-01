rm(list = ls())

## obtencao da lista de concursos:
# source(file.path('scripts', 'obtem-lista-concursos.r'))

## verificacao nas paginas da lista de concursos se existe a palavra
## estatistico e obtencao dos pdfs
# source(file.path('scripts', 'verifica-lista.r'))

urls_concursos = readRDS(file.path('results', 'lista-verificacao-urls.rds'))

res = lapply(urls_concursos, \(concursos_regiao) {
  lapply(concursos_regiao, \(concurso) concurso[concurso$verifica]) %>%
    Filter(\(item) length(item) > 0, .)
})

res = lapply(res, \(concursos_regiao) {
  lapply(concursos_regiao, \(concurso) concurso$url)
}) %>%
  unlist() %>%
  as.vector()

res %>%
  .[!grepl('fatec|docente|etec|estagio|professor', .)] %>%
  gsub('https://www.pciconcursos.com.br/noticias/', '', .)
