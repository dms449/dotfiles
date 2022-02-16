setlocal iskeyword+=!
setlocal iskeyword+=?

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

" map <buffer> <leader>rt :call VimuxRunCommand("julia ". expand('%') ." \n")<CR>
map <buffer> <leader>rf :call VimuxRunCommand("julia ". expand('%') ." \n")<CR>
