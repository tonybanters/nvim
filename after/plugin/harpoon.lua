local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Go to next file
vim.keymap.set('n', '<C-n>', function()
	ui.nav_next();
end)

-- Go to previous file
vim.keymap.set('n', '<C-p>', function()
	ui.nav_prev();
end)

