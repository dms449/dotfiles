-- searching
map("n", "<leader>P", ":PFiles<CR>")
map("n", "<leader>p", ":GitFiles<CR>")
map("n", "<leader>og", ":GitFiles?<CR>")
map("n", "<leader>fw", ":Find <C-r><C-w><CR>")
map("n", "<leader>ff", ":Find <C-r><C-w>")
map("n", "<leader>b", ":Buffers<CR>")
map("n", "<leader>t", ":Tags<CR>")
map("n", "<leader>-", ":split | :Files<CR>")
map("n", "<leader>\\", ":vsplit | :Files<CR>")
map("n", "<leader>fy", ":Find <c-R>\"<CR>")
map("n", "<leader>lf", ":FileManager<CR>")

-- moving
map("n", "<M-k>", ":m-2<CR>")
map("n", "<M-j>", ":m+<CR>")

map("n", "<leader>rr", ":%s/\\C<C-r><C-w>/")

-- switch panes
map("n", "<CR>", "<CR>:noh<CR>")
map("n", "<C-h>", ":TmuxNavigateLeft<CR>")
map("n", "<C-j>", ":TmuxNavigateDown<CR>")
map("n", "<C-k>", ":TmuxNavigateUp<CR>")
map("n", "<C-l>", ":TmuxNavigateRight<CR>")

