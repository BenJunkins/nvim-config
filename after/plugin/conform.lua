-- Setup conform
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
	},

	format_on_save = {
		lsp_fallback = true, -- If Prettier isn't available, try the LSP (safety net)
		async = false, -- false = blocks the save until format is done (safer)
		timeout_ms = 500, -- Give up if formatting takes longer than 0.5 seconds
	},
})
