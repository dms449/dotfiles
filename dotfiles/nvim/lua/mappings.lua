local function toggle_folds()
  local get_opt = vim.api.nvim_win_get_option
  local set_opt = vim.api.nvim_win_set_option

  if get_opt(0, "foldlevel") >= 20 then
    set_opt(0, "foldlevel", 4)
  else
    set_opt(0, "foldlevel", 20)
  end
end

-- searching
vim.keymap.set("n", "<leader>P", ":PFiles<CR>")
vim.keymap.set("n", "<leader>p", ":GitFiles<CR>")
vim.keymap.set("n", "<leader>og", ":GitFiles?<CR>")
vim.keymap.set("n", "<leader>fw", ":Find <C-r><C-w><CR>")
vim.keymap.set("n", "<leader>ff", ":Find <C-r> ")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
vim.keymap.set("n", "<leader>-", ":split | :Files<CR>")
vim.keymap.set("n", "<leader>\\", ":vsplit | :Files<CR>")
vim.keymap.set("n", "<leader>fy", ":Find <c-R>\"<CR>")
vim.keymap.set("n", "<leader>lf", ":FileManager<CR>")

-- moving
vim.keymap.set("n", "<M-k>", ":m-2<CR>")
vim.keymap.set("n", "<M-j>", ":m+<CR>")

vim.keymap.set("n", "<leader>rr", ":%s/\\C<C-r><C-w>/")

-- switch panes
vim.keymap.set("n", "<CR>", "<CR>:noh<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- folding
vim.keymap.set("n", "<leader>u", toggle_folds)


vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})
-- terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- terminal buffer tracking
local terminal_buf = nil

vim.keymap.set("n", "<leader>t", function()
  -- Check if terminal buffer exists and is valid
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    -- Find if terminal is already open in a window
    local terminal_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_buf then
        terminal_win = win
        break
      end
    end
    
    if terminal_win then
      -- Terminal is already open, just focus it and enter terminal mode
      vim.api.nvim_set_current_win(terminal_win)
      vim.cmd.startinsert()
    else
      -- Terminal buffer exists but not visible, open it in new window
      vim.cmd.vnew()
      vim.api.nvim_win_set_buf(0, terminal_buf)
      vim.cmd.wincmd("J")
      vim.api.nvim_win_set_height(0, 15)
      vim.cmd.startinsert()
    end
  else
    -- Create new terminal buffer
    vim.cmd.vnew()
    vim.cmd.term()
    terminal_buf = vim.api.nvim_get_current_buf()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    vim.cmd.startinsert()
  end
end)
