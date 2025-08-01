-- terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- terminal buffer and window tracking
local terminal_buf = nil
local terminal_win = nil

vim.keymap.set("t", "<F2>", function()
  vim.api.nvim_win_close(terminal_win, false)
end)

vim.keymap.set("n", "<F2>", function()
  local current_win = vim.api.nvim_get_current_win()

  -- If we're currently in the terminal window, close it
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) and current_win == terminal_win then
    vim.api.nvim_win_close(terminal_win, false)
    terminal_win = nil
    return
  end

  -- Check if terminal buffer exists and is valid
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    -- Check if terminal is already open in a window
    local existing_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_buf then
        existing_win = win
        break
      end
    end

    if existing_win then
      -- Terminal is already open, focus it and enter terminal mode
      vim.api.nvim_set_current_win(existing_win)
      terminal_win = existing_win
      vim.cmd.startinsert()
    else
      -- Terminal buffer exists but not visible, open it in new window
      vim.cmd.vnew()
      vim.api.nvim_win_set_buf(0, terminal_buf)
      vim.cmd.wincmd("J")
      vim.api.nvim_win_set_height(0, 15)
      terminal_win = vim.api.nvim_get_current_win()
      vim.cmd.startinsert()
    end
  else
    -- Create new terminal buffer and window
    vim.cmd.vnew()
    vim.cmd.term()
    terminal_buf = vim.api.nvim_get_current_buf()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    terminal_win = vim.api.nvim_get_current_win()
    vim.cmd.startinsert()
  end
end)


vim.keymap.set("n", "<leader>lg", function()
  -- Create a new buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get editor dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- Calculate starting position
  local row = math.ceil(height / 2 - 1)
  local col = math.ceil(width / 2)

  -- Set popup window options
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  -- Set darker background for the popup
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e1e", fg = "#666666" })

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Start terminal in the buffer with lg command
  vim.fn.termopen("lazygit")

  -- Add buffer-local keymap to close window on 'q'
  -- vim.keymap.set('t', 'q', function()
  --   vim.api.nvim_win_close(win, true)
  -- end, { buffer = buf })

  vim.cmd.startinsert()
end)
