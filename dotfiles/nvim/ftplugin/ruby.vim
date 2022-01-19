setlocal iskeyword+=!
setlocal iskeyword+=?


" RSpec.vim mappings
if expand('%')[len(expand('%'))-4:len(expand('%'))] != 'slim'
  autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()
endif
