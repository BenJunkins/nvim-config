-- Setup nvim-autopairs

local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

-- Enable TreeSitter integration

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "string" },
		java = false,
	},
	fast_wrap = {},
})
