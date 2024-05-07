-- Credit: alaird, https://github.com/AndrewLaird
-- A journal plugin that helps notetaking proccess while in vim. 


local function open_today()
    local filename = os.date("%Y-%m-%d") .. ".txt"
    local directory = "~/.journaling/"
    vim.cmd("e " .. directory .. filename)
    vim.notify(directory .. filename)
end

local function open_tomorrow()
    local filename = os.date("%Y-%m-%d", os.time() + (24 * 3600)) .. ".txt"
    local directory = "~/.journaling/"
    vim.cmd("e " .. directory .. filename)
    vim.notify(directory .. filename)
end

local function open_yesterday()
    local filename = os.date("%Y-%m-%d", os.time() - (24 * 3600)) .. ".txt"
    local directory = "~/.journaling/"
    vim.cmd("e " .. directory .. filename)
    vim.notify(directory .. filename)
end

vim.keymap.set("n", "<leader>jf", "<cmd>lua require('telescope.builtin').find_files({cwd='~/.journaling/'})<cr>", { silent = true })
vim.keymap.set("n", "<leader>jg", "<cmd>lua require('telescope.builtin').live_grep({cwd='~/.journaling/'})<cr>", { silent = true })
vim.keymap.set("n", "<leader>jj", open_today, { silent = true })
vim.keymap.set("n", "<leader>jt", open_tomorrow, { silent = true })
vim.keymap.set("n", "<leader>jy", open_yesterday, { silent = true })


