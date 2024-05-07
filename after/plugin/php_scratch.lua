-- Credit: Alaird, https://github.com/alaird
local path = require('plenary.path')

local function file_exists(filepath)
  local path_obj = path:new(filepath)
  return path_obj:exists()
end

local function open_page_with_autoimport(filename)
  local scrapy_directory = "/www/sites/tony.dev-leasecalcs.com/app/.scraphp/"
  local fullpath = scrapy_directory .. filename
  if not file_exists(fullpath) then
    vim.cmd("!cp " .. scrapy_directory .. "start.php " .. fullpath)
  end
  vim.cmd("e " .. fullpath)
  print(fullpath)
end

local function php_open_today()
  local filename = os.date("%Y-%m-%d") .. ".php"
  open_page_with_autoimport(filename)
end

local function php_open_today_page(page)
  local filename = os.date("%Y-%m-%d") .. "_" .. page .. ".php"
  open_page_with_autoimport(filename)
end

local function php_open_tomorrow()
  local tomorrow = os.time() + (24 * 3600)
  local filename = os.date("%Y-%m-%d", tomorrow) .. ".php"
  open_page_with_autoimport(filename)
end

local function php_open_yesterday()
  local yesterday = os.time() - (24 * 3600)
  local filename = os.date("%Y-%m-%d", yesterday) .. ".php"
  open_page_with_autoimport(filename)
end

vim.keymap.set("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files({cwd=\"/www/sites/tony.dev-leasecalcs.com/app/.scraphp/\"})<cr>")
vim.keymap.set("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep({cwd=\"/www/sites/tony.dev-leasecalcs.com/app/.scraphp/\"})<cr>")
vim.keymap.set("n", "<leader>tt", php_open_today, { silent = true })
vim.keymap.set("n", "<leader>t1", function()
  php_open_today_page(1)
end)
vim.keymap.set("n", "<leader>t2", function()
  php_open_today_page(2)
end)
vim.keymap.set("n", "<leader>t3", function()
  php_open_today_page(3)
end)
vim.keymap.set("n", "<leader>t4", function()
  php_open_today_page(4)
end)
vim.keymap.set("n", "<leader>t5", function()
  php_open_today_page(5)
end)
vim.keymap.set("n", "<leader>ty", "php_open_yesterday()<cr>")
