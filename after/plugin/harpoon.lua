local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = 'Add to harpoon.' })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = 'Open harpoon quick menu.' })

vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, { desc = 'Open first harpoon.' })
vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, { desc = 'Open second harpoon.' })
vim.keymap.set("n", "<C-h>", function() ui.nav_file(3) end, { desc = 'Open third harpoon.' })
vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end, { desc = 'Open fourth harpoon.' })
