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
vim.keymap.set("n", "<leader>t", ":Tags<CR>")
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

-- folding
vim.keymap.set("n", "<leader>u", toggle_folds)

