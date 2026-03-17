highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au BufEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+$/ | endif
au InsertEnter * if &buftype != 'terminal' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
au InsertLeave * if &buftype != 'terminal' | match ExtraWhiteSpace /\s\+$/ | endif
au TermOpen * match none
