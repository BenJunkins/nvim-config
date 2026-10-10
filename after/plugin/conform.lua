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
		python = { "black" },
	},

	-- Blocks the save until formatting is done
	format_on_save = {
		lsp_format = "fallback", -- If no formatter is listed for the filetype, try the LSP (safety net)
		timeout_ms = 1000, -- Give up if formatting takes longer than 1 second
	},
})

-- Manual format: same formatters as format-on-save, LSP only if none is configured
vim.keymap.set("n", "<leader>f", function()
	conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
