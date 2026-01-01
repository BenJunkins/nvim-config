-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Search
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Color
  use {
	  'sainnhe/gruvbox-material',
	  config = function()
		  -- 'hard', 'medium', or 'soft'
		  vim.g.gruvbox_material_background = 'hard'

		  -- 'material', 'mix', or 'original'
		  vim.g.gruvbox_material_foreground = 'material'

		  vim.g.gruvbox_material_transparent_background = 0

  		  vim.cmd.colorscheme 'gruvbox-material'

		  end
  }

  -- Links with Prettier for formatting
  use {
      "stevearc/conform.nvim"
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,
  }

  use {
	  "nvim-lua/plenary.nvim"
  }

  use {
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use {
	  "mbbill/undotree"
  }

  -- Git integation
  use {
	  "tpope/vim-fugitive"
  }

  -- Autopairing paraenthesis
  use {
      "windwp/nvim-autopairs"
  }

  -- LSP and Autocompletion Plugins
  use {
    'neovim/nvim-lspconfig', -- Core LSP configuration plugin
    'williamboman/mason.nvim', -- Installs LSPs
    'williamboman/mason-lspconfig.nvim', -- Bridge between mason and lspconfig

    -- Autocompletion Engine
    'hrsh7th/nvim-cmp', -- The completion engine
    'hrsh7th/cmp-nvim-lsp', -- LSP completion source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer completion source
    'hrsh7th/cmp-path', -- Path completion source

    -- Snippets
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- Snippet completion source for nvim-cmp
  }

end)
