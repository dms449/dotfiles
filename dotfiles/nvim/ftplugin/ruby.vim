setlocal iskeyword+=!
setlocal iskeyword+=?

let g:rspec_command = 'call VimuxRunCommand("bes {spec}\n")'
map <buffer> <Leader>rt :call RunCurrentSpecFile()<CR>
map <buffer> <Leader>rr :call RunNearestSpec()<CR>
map <buffer> <Leader>rl :call RunLastSpec()<CR>

" RSpec.vim mappings
if expand('%')[len(expand('%'))-4:len(expand('%'))] != 'slim'
  autocmd BufWritePre <buffer> call CocAction('format')
endif
