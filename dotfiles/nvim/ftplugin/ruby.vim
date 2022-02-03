setlocal iskeyword+=!
setlocal iskeyword+=?

let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
nmap <buffer> <Leader>rt :call RunCurrentSpecFile()<CR>
nmap <buffer> <Leader>rr :call RunNearestSpec()<CR>
nmap <buffer> <Leader>rl :call RunLastSpec()<CR>
nmap <buffer> <leader>. :call RailsOpenAlt()<CR>

" RSpec.vim mappings
if expand('%')[len(expand('%'))-4:len(expand('%'))] != 'slim'
  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
endif
