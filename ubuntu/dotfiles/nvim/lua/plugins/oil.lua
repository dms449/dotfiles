-- Track the original buffer for Oil
local oil_original_win = nil

-- Custom select action that opens files in the original buffer
local function custom_select()
  local oil = require('oil')
  local entry = oil.get_cursor_entry()

  if not entry then
    return
  end

  if entry.type == 'file' then
    local filepath = oil.get_current_dir() .. entry.name

    -- If we have a tracked original window and it's valid, use it
    if oil_original_win and vim.api.nvim_win_is_valid(oil_original_win) then
      -- Open the file in the original window without switching focus
      vim.api.nvim_win_call(oil_original_win, function()
        vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
      end)
    else
      -- No tracked window or invalid, use default behavior
      vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
    end
  else
    -- For directories, use default select behavior
    oil.select()
  end
end

return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      use_default_keymaps = false,
      skip_confirm_for_simple_edits = false,
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = custom_select,
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        -- ["<C-p>"] = "actions.preview",
        ["q"] = { "actions.close", mode = "n" },
        -- ["<C-l>"] = "actions.refresh",
        ["<C-p>"] = { "actions.parent", mode = "n" }, -- Alternative: try <C-p> or <BS> if this doesn't work
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
    },
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    init = function()
      vim.keymap.set("n", "-", function()
        -- Check if Oil is already open in a vertical split
        local oil_winid = nil
        for _, winid in ipairs(vim.api.nvim_list_wins()) do
          local bufnr = vim.api.nvim_win_get_buf(winid)
          local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
          if filetype == 'oil' then
            oil_winid = winid
            break
          end
        end

        if oil_winid then
          -- Close the Oil window if it exists
          vim.api.nvim_win_close(oil_winid, false)
        else
          oil_original_win = vim.api.nvim_get_current_win()

          -- Open Oil in a vertical split
          vim.cmd('leftabove :50vsplit')
          require('oil').open()
        end
      end, { desc = "Toggle Oil in vertical split" })
    end
  }
}
