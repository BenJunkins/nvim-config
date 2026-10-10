require("fine-cmdline").setup({
	cmdline = {
		prompt = "> ",
	},
	popup = {
		position = {
			row = "50%",
			col = "50%",
		},
		border = {
			text = {
				top = "CmdLine",
				top_align = "center",
			},
		},
	},
})
