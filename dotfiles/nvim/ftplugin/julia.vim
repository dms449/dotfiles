setlocal iskeyword+=!
setlocal iskeyword+=?

autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()
