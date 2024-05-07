local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<C-g>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fxg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>fg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Find instance of set_view(current_file)
vim.keymap.set('n', '<leader>fc', function()
  local filename_without_extension = vim.fn.expand('%:t:r')
  builtin.grep_string({ search = filename_without_extension })
end, {desc = "Find current file: "})

-- Grep current string (for when gd doesn't work)
vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({})
end, {desc = "Find current string: "})


-- Laird tips and tricks:
-- find files in vim config
vim.keymap.set('n', '<leader>fi', function()
    builtin.find_files({cwd="~/.config/nvim/"});
end)
