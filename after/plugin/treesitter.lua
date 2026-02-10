vim.filetype.add({ extension = { goon = "goon" } })

-- Register custom goon parser with treesitter (old API)
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.goon = {
    install_info = {
        url = "/home/tony/repos/tree-sitter-goon",
        files = { "src/parser.c" },
    },
    filetype = "goon",
}

-- Configure nvim-treesitter with ensure_installed
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "json", "python", "ron", "javascript", "haskell", "d", "query",
        "typescript", "tsx", "rust", "zig", "php", "yaml", "html", "css",
        "markdown", "markdown_inline", "bash", "lua", "vim", "vimdoc", "c",
        "dockerfile", "gitignore", "astro", "go", "templ"
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
    },
})

vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)

require("treesitter-context").setup({})
