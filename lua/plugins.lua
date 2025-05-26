-- set up lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{	
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {"c","lua", "python", "vim", "vimdoc", "query"},
				auto_install = true,
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<Leader>ss",
						node_incremental = "<Leader>si", 
						scope_incremental = "<Leader>sc", 
						node_decremental = "<Leader>sd", 
					},
				},
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
							['iee'] = '@assignment.inner',
							['iel'] = '@assignment.lhs',
							['ae'] = '@assignment.outer',
							['ier'] = '@assignment.rhs',
							['ia'] = '@attribute.inner',
							['aa'] = '@attribute.outer',
							['ib'] = '@block.inner',
							['ab'] = '@block.outer',
							['ik'] = '@call.inner',
							['ak'] = '@call.outer',
							['io'] = '@comment.inner',
							['ao'] = '@comment.outer',
							['im'] = '@frame.inner',
							['am'] = '@frame.outer',
							['in'] = '@number.inner',
							['ix'] = '@regex.inner',
							['ax'] = '@regex.outer',
							['ir'] = '@return.inner',
							['ar'] = '@return.outer',
							['is'] = '@scopename.inner',
							['as'] = '@statement.outer',
							['av'] = '@parameter.outer',
							['iv'] = '@parameter.inner',
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
							['al'] = '@loop.outer',
							['il'] = '@loop.inner',
							['ai'] = '@conditional.outer',
							['ii'] = '@conditional.inner',
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							['@parameter.outer'] = 'v', -- charwise
							['@function.outer'] = 'V', -- linewise
							['@class.outer'] = '<c-v>', -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"folke/which-key.nvim",
		opts = {},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},

	{
		"tpope/vim-fugitive",
		"tpope/vim-rhubarb",
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {}
	},

	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets', "L3MON4D3/LuaSnip" },
		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { 
				preset = 'none',
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<Tab>'] = { 'select_and_accept' },
			},
			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},
			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},

	{
		"mason-org/mason.nvim",
		opts = {}
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{"mason-org/mason.nvim", opts = {}},
			"neovim/nvim-lspconfig",
		},
	},
	{
		'echasnovski/mini.nvim',
		version = '*',
	},
	{
		'echasnovski/mini.jump2d',
		version = '*',
	},
})


