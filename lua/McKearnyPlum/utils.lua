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
