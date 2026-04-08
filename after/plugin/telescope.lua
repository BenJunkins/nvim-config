local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Ts find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Ts find git files" })

-- Grep
vim.keymap.set("n", "<leader>gl", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>gs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep string" })
