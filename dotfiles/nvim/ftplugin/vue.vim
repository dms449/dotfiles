setlocal iskeyword+=!
setlocal iskeyword+=?
setlocal isfname-=.
" autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()

autocmd BufWritePre <buffer> EslintFixAll
