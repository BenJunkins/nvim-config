-- High level quality of life
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore files" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape out of insert" })
vim.keymap.set("n", "Q", "<nop>", { desc = "No operation of Ex mode" })

-- Moving blocks of code
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted down" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted up" })

-- Cursor management
vim.keymap.set("n", "J", "mzJ`z", { desc = "Line join without moving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center cursor in next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center cursor in prev search" })

-- Putting
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Put without overwriting reg" })
vim.keymap.set("n", "<leader>p", '"0p', { desc = "Put last yank" })

-- Yanking
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank motion into clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line into clipboard" })
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Yank highlight into clipboard" })

-- Deleting
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete avoid register" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete avoid register" })

-- Quickfix window
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next in Quickfix" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Prev in Quickfix" })

-- Terminal
vim.keymap.set("n", "<leader>t", function()
	vim.cmd.vsplit() -- Opens new window
	vim.cmd.term() -- Opens terminal
	vim.cmd.startinsert() -- Immediately start typing
end, { desc = "Opens terminal in new window" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
