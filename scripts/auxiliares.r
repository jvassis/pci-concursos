library(stringr)

barraStatus = function(percent, n = 15) {
  k = trunc(n * (1 - percent))
  return(paste0(c('[', rep('#', n - k), rep(' ', k), '%]'), collapse = ''))
}

printStatus = function(text, percent, n = 50) {
  if (str_length(text) > n) text = paste0(substr(text, 1, n), ' ...')
  cat('\t', barraStatus(percent), text, '\n')
}