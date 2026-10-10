-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Define and install plugins
require("lazy").setup({
	-- Search
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Color and Animation
	{ "rebelot/kanagawa.nvim" },
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			legacy_computing_symbols_support = true,
			min_vertical_distance_smear = 2,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Formatting
	{ "stevearc/conform.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- Core Dependencies
	{ "nvim-lua/plenary.nvim" },

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},

	-- Editor Utilities
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "windwp/nvim-autopairs" },

	-- LSP
	{
		"mason-org/mason.nvim",
	},
	{ "neovim/nvim-lspconfig" },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
	},

	-- Autocompletion
	{ "rafamadriz/friendly-snippets" },
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Confg
		opts = {
			-- See :h blink-cmp-config-keymap for defining keymap
			keymap = { preset = "super-tab" },
		},
		opts_extend = { "sources.default" },
	},

	-- Command Line
	{ "MunifTanjim/nui.nvim" },
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
}, {
	rocks = { enabled = false },
})
