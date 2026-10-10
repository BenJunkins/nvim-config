vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" }, -- the Lua that Neovim runs
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				-- Teach lua_ls the Neovim API so `vim.` completes and K shows docs
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})
