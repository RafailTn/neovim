-- Set keymaps immediately for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "julia", "r" },
  callback = function()
    -- Set keymaps immediately when file is opened
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, desc = "Molten" }

    map("n", "<leader>mi", "<cmd>MoltenInit<cr>", { desc = "Initialize Molten", buffer = true })
    map("n", "<leader>le", "<cmd>MoltenEvaluateOperator<cr>", { desc = "Molten: Evaluate operator", buffer = true })
    map("n", "<leader>ll", "<cmd>MoltenEvaluateLine<cr>", { desc = "Molten: Evaluate line", buffer = true })
    map("v", "<leader>ls", ":<C-u>MoltenEvaluateVisual<cr>", { desc = "Molten: Evaluate Visual Selection", buffer = true })
    map("n", "<leader>ld", "<cmd>MoltenDelete<cr>", { desc = "Molten: Delete cell output", buffer = true })
    map("n", "<leader>li", "<cmd>MoltenInterrupt<cr>", { desc = "Molten Interrupt Running Cell", buffer = true })
    map("n", "<leader>lh", "<cmd>MoltenHideOutput<cr>", { desc = "Molten: Hide output", buffer = true })
    map("n", "<leader>lo", "<cmd>MoltenShowOutput<cr>", { desc = "Molten: Show output", buffer = true })
    map("n", "<leader>lq", "<cmd>MoltenDeinit<cr>", { desc = "Quit molten", buffer = true })
  end,
})
