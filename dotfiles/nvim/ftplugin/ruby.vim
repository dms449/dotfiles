setlocal iskeyword+=!
setlocal iskeyword+=?

if expand('%')[len(expand('%'))-4:len(expand('%'))] != 'slim'
  autocmd BufWritePre <buffer> call LangaugeClient_textDocument_formatting()
endif
