setlocal iskeyword+=!
setlocal iskeyword+=?

# format on save
autocmd BufWritePre <buffer> call LanguageClient_textDocument_formatting_sync()

# run
map <buffer> <leader>rt :call VimuxRunCommand("pytest ". expand('%') ." \n")<CR>
map <buffer> <leader>rf :call VimuxRunCommand("python ". expand('%') ." \n")<CR>
