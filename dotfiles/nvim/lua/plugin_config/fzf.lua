-- :PFiles (Project Files) is almost identical to GitFiles except it includes
--   files that have not been checked in to git
vim.api.nvim_command [[command! -bang PFiles call fzf#vim#files(split(system('git rev-parse --show-toplevel'),'\n')[0], fzf#vim#with_preview(),<bang>0)]]


-- define Find: functionality
vim.api.nvim_command [[command! -bang -nargs=* Find call fzf#vim#grep('rg --column --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(),<bang>0)]]
