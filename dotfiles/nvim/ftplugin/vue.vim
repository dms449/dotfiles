setlocal iskeyword+=!
setlocal iskeyword+=?
setlocal isfname-=.
set foldmethod=indent
set foldlevel=4
" autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()

autocmd BufWritePre <buffer> EslintFixAll
