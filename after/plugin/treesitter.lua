-- nvim-treesitter (main branch): the plugin only installs parsers and queries,
-- highlighting itself is built into Neovim and started per buffer below.
local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

-- Parsers that should always be installed
local ensure_installed = { "javascript", "markdown", "markdown_inline", "lua", "python", "query", "vim", "vimdoc" }

-- Building parsers needs the `tree-sitter` CLI, which Mason installs (see config/lsp.lua).
-- Mason's bin directory is only on PATH once init.lua has finished, so check lazily.
local function has_cli()
	return vim.fn.executable("tree-sitter") == 1
end

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if has_cli() then
			ts.install(ensure_installed) -- no-op for parsers that are already installed
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if not lang then
			return
		end

		if vim.treesitter.language.add(lang) then
			-- A parser exists for this filetype: highlight with treesitter
			vim.treesitter.start(args.buf, lang)
		elseif has_cli() and vim.list_contains(ts.get_available(), lang) then
			-- Automatically install the missing parser, then highlight
			ts.install(lang):await(function()
				if vim.api.nvim_buf_is_valid(args.buf) and vim.treesitter.language.add(lang) then
					vim.treesitter.start(args.buf, lang)
				end
			end)
		end
	end,
})
