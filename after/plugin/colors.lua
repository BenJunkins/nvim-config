-- 'hard', 'medium', or 'soft'
vim.g.gruvbox_material_background = "hard"

-- 'material', 'mix', or 'original'
vim.g.gruvbox_material_foreground = "material"

vim.g.gruvbox_material_transparent_background = 0

vim.cmd.colorscheme("gruvbox-material")

-- Makes the floating window background transparent
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
})
