-- function DiffDev()
--   :Gvdiffsplit :Gvdiffsplit develop:{vim.api.nvim_buf_get_name(0)}
-- end

map("n", "<leader>gd", ":Gvdiffsplit<CR>")
-- map("n", "<leader>dev", "v:lua.DiffDev()")
