local harpoon = require("harpoon")

harpoon:setup(
    {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    }
)

local conf = require("telescope.config").values

local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()   
end     
       
-- List edits         
vim.keymap.set("n", "<leader>ma", function() harpoon:list():add() end, { desc = '[A]ppends the file to the harpoon list' })
vim.keymap.set("n", "<leader>mu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Opens the harpoon m[E]nu' })
vim.keymap.set("n", "<leader>mt", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window in telescope [S]earch" })
-- Jumps         
vim.keymap.set("n", "<leader>0", function() harpoon:list():select(0) end, { desc = "Opens 0th(?) harpoon listing file" })
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Opens first harpoon listing file" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Opens second harpoon listing file" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Opens third harpoon listing file" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Opens fourt harpoon listing file" })
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Opens fifth harpoon listing file" })
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Opens sixth harpoon listing file" })
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "Opens seventh harpoon listing file" })
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "Opens eighth harpoon listing file" })
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, { desc = "Opens ninth harpoon listing file" })
-- And the best ones  
vim.keymap.set("n", "<leader>mn", function() harpoon:list():next() end, {desc = "[N]ext harpoon listing" })
vim.keymap.set("n", "<leader>mp", function() harpoon:list():prev() end, {desc = "[P]revious harpoon listing" })
