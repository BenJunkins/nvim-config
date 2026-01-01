-- Setup telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files in repo" })

-- Grep string
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Live Grep
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live Grep" })
