-- searching
map("n", "<leader>o", ":PFiles<CR>")
map("n", "<leader>ff", ":Find <C-r><C-w><CR>")
map("n", "<leader>F", ":Find ")
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
map("n", "<leader>s", "/<C-r><C-w><CR>")

-- switch panes
map("n", "<leader>h", ":wincmd h<CR>")
map("n", "<leader>j", ":wincmd j<CR>")
map("n", "<leader>k", ":wincmd k<CR>")
map("n", "<leader>l", ":wincmd l<CR>")
