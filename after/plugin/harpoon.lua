local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values

local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({ results = file_paths }),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

-- Main ui interface bindings
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

-- Set whales to harpoon
vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
-- (not <C-[>: terminals send that as <Esc>)
vim.keymap.set("n", "[h", function()
	harpoon:list():prev()
end, { desc = "Prev harpoon file" })
vim.keymap.set("n", "]h", function()
	harpoon:list():next()
end, { desc = "Next harpoon file" })

-- clear the list
vim.keymap.set("n", "<leader>hc", function()
	harpoon:list():clear()
end, { desc = "Clear harpoon list" })
