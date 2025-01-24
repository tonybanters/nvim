-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', -- tag = '0.1.2',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
	  use 'Mofiqul/vscode.nvim',
	  as = 'vscode',
	  config = function()
		  vim.cmd('colorscheme vscode')
	  end
  })
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
      'kkoomen/vim-doge',
      run = ':call doge#install()'
  }
  use("numToStr/Comment.nvim")
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/nvim-treesitter-context')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('captbaritone/better-indent-support-for-php-with-html')
  use('neovim/nvim-lspconfig')
  use('ojroques/vim-oscyank')

  -- use {
  --   'saghen/blink.cmp',
  --   requires = { 'rafamadriz/friendly-snippets' }, -- Add dependency
  --   version = '*',
  --   config = function()
  --     require('blink.cmp').setup({
  --       keymap = { preset = 'default' },
  --       appearance = {
  --         use_nvim_cmp_as_default = true,
  --         nerd_font_variant = 'mono'
  --       },
  --       signature = { enabled = true },
  --     })
  --   end,
  -- }
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')

  
end)
