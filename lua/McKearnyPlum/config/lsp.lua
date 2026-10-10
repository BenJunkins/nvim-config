require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"jsonls",
		"stylua",
		"prettier",
		"black",
		"pyright",
		"isort",
		"tree-sitter-cli",
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
})

require("McKearnyPlum.config.lsp_settings.lua_ls")

vim.lsp.enable({
	"lua_ls",
	"jsonls",
	"pyright",
})

vim.diagnostic.config({
	float = {
		focus = false,
		scope = "cursor",
		close_events = { "InsertEnter", "CursorMoved" },
		border = "rounded",
	},
	jump = { on_jump = vim.diagnostic.open_float },
	signs = {
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		},
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.WARN] = "",
		},
	},
	update_in_insert = true,
	virtual_text = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "<leader>gr", vim.lsp.buf.references, "References")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
	end,
})
