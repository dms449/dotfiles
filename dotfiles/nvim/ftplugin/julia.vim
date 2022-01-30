setlocal iskeyword+=!
setlocal iskeyword+=?

"autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()

" map <buffer> <leader>rt :call VimuxRunCommand("julia ". expand('%') ." \n")<CR>
map <buffer> <leader>rf :call VimuxRunCommand("julia ". expand('%') ." \n")<CR>
