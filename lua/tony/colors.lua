-- local status, _ = pcall(vim.cmd, "colorscheme vscode")
local status, _ = pcall(vim.cmd, "colorscheme catppuccin")
if not status then
    print("Colorscheme not found.")
    return
end

function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

enable_transparency()

