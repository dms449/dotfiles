-- searching
map("n", "<leader>p", ":PFiles<CR>")
map("n", "<leader>og", ":GitFiles?<CR>")
map("n", "<leader>s", ":Find <C-r><C-w><CR>")
map("n", "<leader>f", ":Find <C-r><C-w>")
map("n", "<leader>b", ":Buffers<CR>")
map("n", "<leader>t", ":Tags<CR>")
map("n", "<leader>-", ":split | :Files<CR>")
map("n", "<leader>\\", ":vsplit | :Files<CR>")


-- moving
map("n", "<leader>J", "<PageDown>")
map("n", "<leader>K", "<PageUp>")
map("n", "<C-k>", ":m-2<CR>")
map("n", "<C-j>", ":m+<CR>")


map("n", "<leader>rr", ":%s/\\C<C-r><C-w>/")

-- switch panes
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>l", ":wincmd l<CR>")
map("n", "<CR>", "<CR>:noh<CR>")
