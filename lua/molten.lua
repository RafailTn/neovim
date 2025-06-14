-- Autocmd to initialize Molten and set keymaps after it's ready
vim.api.nvim_create_autocmd("User", {
  pattern = "MoltenInitPost",
  once = true,
  callback = function()
    -- Set keymaps after Molten is initialized
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = "Molten" }

    map("n", "<leader>mi", "<cmd>MoltenInit<cr>", { desc = "Initialize Molten" })
    map("n", "<leader>le", "<cmd>MoltenEvaluateOperator<cr>", { desc = "Molten: Evaluate operator" })
    map("n", "<leader>ll", "<cmd>MoltenEvaluateLine<cr>", { desc = "Molten: Evaluate line" })
	map("v", "<leader>ls", ":<C-u>MoltenEvaluateVisual<cr>", { desc = "Molten: Evaluate Visual Selection" })
    map("n", "<leader>ld", "<cmd>MoltenDelete<cr>", { desc = "Molten: Delete cell output" })
	map("n", "<leader>li", "<cmd>MoltenInterrupt<cr>", { desc = "Molten Interrupt Running Cell"})
    map("n", "<leader>lh", "<cmd>MoltenHideOutput<cr>", { desc = "Molten: Hide output" })
    map("n", "<leader>lo", "<cmd>MoltenShowOutput<cr>", { desc = "Molten: Show output" })
	map("n", "<leader>lq", "<cmd>MoltenDeinit<cr>", { desc = "Quit molten"})
  end,
})

-- Automatically initialize Molten for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "julia", "r" },
  callback = function()
    vim.cmd("MoltenInit")
  end,
})

vim.g.molten_cell_delimiter = "# %%"
