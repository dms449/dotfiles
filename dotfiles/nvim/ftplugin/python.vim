setlocal iskeyword+=!
setlocal iskeyword+=?

" run
map <buffer> <leader>rt :call VimuxRunCommand("pytest ". expand('%') ." \n")<CR>
map <buffer> <leader>rf :call VimuxRunCommand("python ". expand('%') ." \n")<CR>
