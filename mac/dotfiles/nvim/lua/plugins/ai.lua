return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    enabled = false,
    config = function()
      require("codeium").setup({

        enable_cmp_source = false,
        virtual_text = {
          enabled = false,

          -- These are the defaults

          -- Set to true if you never want completions to be shown automatically.
          manual = false,
          -- A mapping of filetype to true or false, to enable virtual text.
          filetypes = {},
          -- Whether to enable virtual text of not for filetypes not specifically listed above.
          default_filetype_enabled = true,
          -- How long to wait (in ms) before requesting completions after typing stops.
          idle_delay = 75,
          -- Priority of the virtual text. This usually ensures that the completions appear on top of
          -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
          -- desired.
          virtual_text_priority = 65535,
          -- Set to false to disable all key bindings for managing completions.
          map_keys = true,
          -- The key to press when hitting the accept keybinding but no completion is showing.
          -- Defaults to \t normally or <c-n> when a popup is showing.
          accept_fallback = nil,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
            -- Accept the current completion.
            accept = "<Tab>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<M-]>",
            -- Cycle to the previous completion.
            prev = "<M-[>",
          }
        }
      })
    end
  },
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = {  -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
        { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "Scroll opencode down" })

      -- Telescope picker for opencode servers
      vim.api.nvim_create_user_command("OCS", function()
        require("opencode.cli.server").get_all()
            :next(function(servers)
              local pickers = require("telescope.pickers")
              local finders = require("telescope.finders")
              local conf = require("telescope.config").values
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              -- Sort servers by common prefix with cwd
              local nvim_cwd = vim.fn.getcwd()
              table.sort(servers, function(a, b)
                local function common_prefix_score(path1, path2)
                  local function split(path)
                    local out = {}
                    for seg in string.gmatch(path, "[^/]+") do
                      table.insert(out, seg)
                    end
                    return out
                  end
                  local segments1 = split(path1)
                  local segments2 = split(path2)
                  local score = 0
                  for i = 1, math.min(#segments1, #segments2) do
                    if segments1[i] == segments2[i] then
                      score = score + 1
                    else
                      break
                    end
                  end
                  return score
                end

                local score_a = common_prefix_score(nvim_cwd, a.cwd)
                local score_b = common_prefix_score(nvim_cwd, b.cwd)
                if score_a == score_b then
                  return a.cwd < b.cwd
                end
                return score_a > score_b
              end)

              pickers.new({}, {
                prompt_title = "OpenCode Servers",
                finder = finders.new_table({
                  results = servers,
                  entry_maker = function(server)
                    local display = string.format("%s | %s | %d", server.title or "<No sessions>", server.cwd,
                      server.port)
                    return {
                      value = server,
                      display = display,
                      ordinal = display,
                    }
                  end,
                }),
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                  actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if selection then
                      require("opencode.events").connect(selection.value)
                      vim.notify("Connected to opencode server: " .. selection.value.cwd, vim.log.levels.INFO)
                    end
                  end)
                  return true
                end,
              }):find()
            end)
            :catch(function(err)
              if err then
                vim.notify(err, vim.log.levels.ERROR, { title = "opencode" })
              end
            end)
      end, { desc = "Select opencode server with Telescope" })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  }
}
