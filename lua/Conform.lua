require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = {"yapf"},
    -- You can customize some of the format options for the filetype (:help conform.format)
	latex = { "tex-fmt", "latexindent" }
  },
})
