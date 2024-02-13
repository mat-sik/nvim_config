-- set leader to space
vim.g.mapleader = " "
-- faster explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open build-in vim file explorer. This does not work because of nvim-tree.' })
-- move and search keeping cursor at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Move down and center.' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Mode up and center.' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'next and center.' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'previous and center.' })
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'I am not sure copied from primeagion' })
-- moving lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'select line and move it up' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'select line and move it down' })
-- switching tabs
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = 'I am not sure copied from primeagion' })
-- faster replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Fast rename.' })
