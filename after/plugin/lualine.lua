-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local lualine_custom = require("lualine.themes.vscode")
lualine_custom.normal.c.bg = 'None'

-- configure lualine with modified theme
lualine.setup({
  options = {
    theme = lualine_custom,
  },
})

