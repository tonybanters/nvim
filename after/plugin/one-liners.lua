require("lualine").setup({ options = { theme = "tokyonight" } })
require("nvim-highlight-colors").setup({})
require("orgmode").setup({
    org_agenda_files = "~/orgfiles/**/*",
    org_default_notes_file = "~/orgfiles/refile.org",
})
