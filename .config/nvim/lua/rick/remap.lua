
vim.g.mapleader = " "

-- (f)ile -> (n)avigate
--vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.xa)

vim.keymap.set("n", "<leader>d", vim.cmd.bd)
vim.keymap.set("n", "<leader>n", vim.cmd.bn)
vim.keymap.set("n", "<leader>p", vim.cmd.bp)

--map <leader>n :bn<cr>
--map <leader>p :bp<cr>
--map <leader>d :bd<cr>

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

--abc adsfjkl ajlksdfjldsf
