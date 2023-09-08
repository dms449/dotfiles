return {
  { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  {
    "junegunn/fzf.vim",
    config = function()
      vim.api.nvim_command [[command! -bang PFiles call fzf#vim#files(split(system('git rev-parse --show-toplevel'),'\n')[0], fzf#vim#with_preview(),<bang>0)]]
      vim.api.nvim_command [[command! -bang -nargs=* Find call fzf#vim#grep('rg --column --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.fzf#shellescape(<q-args>), 1, fzf#vim#with_preview(),<bang>0)]]
    end
  },
}
