vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Define the path strictly
local undodir = vim.fn.stdpath("data") .. "/undo"

-- Force Neovim to create the directory if it fails to do so automatically
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- Set the directory and turn on the feature
vim.opt.undodir = undodir
vim.opt.undofile = true
