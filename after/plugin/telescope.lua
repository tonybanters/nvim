-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- import telescope builtin safely
local builtin_setup, builtin = pcall(require, "telescope.builtin")
if not builtin_setup then
  return
end

-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
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

-- find files in vim config
vim.keymap.set('n', '<leader>fi', function()
    builtin.find_files({cwd="~/.config/nvim/"});
end)

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})


