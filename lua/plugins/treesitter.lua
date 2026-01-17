return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            vim.filetype.add({ extension = { goon = "goon" } })

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            parser_config.goon = {
                install_info = {
                    url = "/home/tony/repos/tree-sitter-goon",
                    files = { "src/parser.c" },
                },
                filetype = "goon",
            }

            local configs = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                },
                -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "goon",
                    "json",
                    "python",
                    "ron",
                    "javascript",
                    "haskell",
                    -- "c3c",
                    "d",
                    "query",
                    "typescript",
                    "tsx",
                    "rust",
                    "zig",
                    "php",
                    "yaml",
                    "html",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "vimdoc",
                    "c",
                    "dockerfile",
                    "gitignore",
                    "astro",
                },
                -- auto install above language parsers
                auto_install = false,
            })
        end
    }
}
