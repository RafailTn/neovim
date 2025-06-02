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
			require("kanagawa").setup({
				transparent = true,
			})
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
							['ai'] = '@assignment.inner',
							['al'] = '@assignment.lhs',
							['ao'] = '@assignment.outer',
							['ar'] = '@assignment.rhs',
							['ati'] = '@attribute.inner',
							['ata'] = '@attribute.outer',
							['bi'] = '@block.inner',
							['bo'] = '@block.outer',
							['cli'] = '@call.inner',
							['clo'] = '@call.outer',
							['hi'] = '@comment.inner',
							['ho'] = '@comment.outer',
							['fri'] = '@frame.inner',
							['fro'] = '@frame.outer',
							['ni'] = '@number.inner',
							['ix'] = '@regex.inner',
							['ax'] = '@regex.outer',
							['ri'] = '@return.inner',
							['ro'] = '@return.outer',
							['is'] = '@scopename.inner',
							['so'] = '@statement.outer',
							['po'] = '@parameter.outer',
							['pi'] = '@parameter.inner',
							['fo'] = '@function.outer',
							['fi'] = '@function.inner',
							['ca'] = '@class.outer',
							['co'] = '@class.inner',
							['lo'] = '@loop.outer',
							['li'] = '@loop.inner',
							['co'] = '@conditional.outer',
							['ci'] = '@conditional.inner',
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
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							['gje'] = '@assignment.outer',
							['gja'] = '@attribute.outer',
							['gjb'] = '@block.outer',
							['gjk'] = '@call.outer',
							['gjo'] = '@comment.outer',
							['gjm'] = '@frame.outer',
							['gjx'] = '@regex.outer',
							['gjr'] = '@return.outer',
							['gjs'] = '@statement.outer',
							['gjp'] = '@parameter.outer',
							['gjf'] = '@function.outer',
							['gjc'] = '@class.outer',
							['gjl'] = '@loop.outer',
							['gji'] = '@conditional.outer',
						},
						goto_next_end = {
							['gJe'] = '@assignment.outer',
							['gJa'] = '@attribute.outer',
							['gJb'] = '@block.outer',
							['gJk'] = '@call.outer',
							['gJo'] = '@comment.outer',
							['gJm'] = '@frame.outer',
							['gJx'] = '@regex.outer',
							['gJr'] = '@return.outer',
							['gJs'] = '@statement.outer',
							['gJp'] = '@parameter.outer',
							['gJf'] = '@function.outer',
							['gJc'] = '@class.outer',
							['gJl'] = '@loop.outer',
							['gJi'] = '@conditional.outer',
						},
						goto_previous_start = {
							['gke'] = '@assignment.outer',
							['gka'] = '@attribute.outer',
							['gkb'] = '@block.outer',
							['gkk'] = '@call.outer',
							['gko'] = '@comment.outer',
							['gkm'] = '@frame.outer',
							['gkx'] = '@regex.outer',
							['gkr'] = '@return.outer',
							['gks'] = '@statement.outer',
							['gkp'] = '@parameter.outer',
							['gkf'] = '@function.outer',
							['gkc'] = '@class.outer',
							['gkl'] = '@loop.outer',
							['gki'] = '@conditional.outer',
						},
						goto_previous_end = {
							['gKe'] = '@assignment.outer',
							['gKa'] = '@attribute.outer',
							['gKb'] = '@block.outer',
							['gKk'] = '@call.outer',
							['gKo'] = '@comment.outer',
							['gKm'] = '@frame.outer',
							['gKx'] = '@regex.outer',
							['gKr'] = '@return.outer',
							['gKs'] = '@statement.outer',
							['gKp'] = '@parameter.outer',
							['gKf'] = '@function.outer',
							['gKc'] = '@class.outer',
							['gKl'] = '@loop.outer',
							['gKi'] = '@conditional.outer',
						},
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>je'] = '@assignment.inner',
							['<leader>ja'] = '@attribute.inner',
							['<leader>jb'] = '@block.inner',
							['<leader>jk'] = '@call.inner',
							['<leader>jo'] = '@comment.inner',
							['<leader>jm'] = '@frame.inner',
							['<leader>jx'] = '@regex.inner',
							['<leader>jr'] = '@return.inner',
							['<leader>js'] = '@statement.inner',
							['<leader>jp'] = '@parameter.inner',
							['<leader>jf'] = '@function.inner',
							['<leader>jc'] = '@class.inner',
							['<leader>jl'] = '@loop.inner',
							['<leader>ji'] = '@conditional.inner',
						},
						swap_previous = {
							['<leader>ke'] = '@assignment.inner',
							['<leader>ka'] = '@attribute.inner',
							['<leader>kb'] = '@block.inner',
							['<leader>kk'] = '@call.inner',
							['<leader>ko'] = '@comment.inner',
							['<leader>km'] = '@frame.inner',
							['<leader>kx'] = '@regex.inner',
							['<leader>kr'] = '@return.inner',
							['<leader>ks'] = '@statement.inner',
							['<leader>kp'] = '@parameter.inner',
							['<leader>kf'] = '@function.inner',
							['<leader>kc'] = '@class.inner',
							['<leader>kl'] = '@loop.inner',
							['<leader>ki'] = '@conditional.inner',
						},
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
		opts = {},
	},

	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets', "L3MON4D3/LuaSnip" },
		version = '1.*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { 
				preset = 'none',
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<Tab>'] = { 'select_and_accept', 'fallback'},
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' }
			},
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
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

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap-python"
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			dap.adapters.python = {
				type = 'executable',
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { '-m', 'debugpy.adapter', },
			}
			dap.configurations.python = {
				{
					type = 'python';
					name = "Launch file";
					request = 'launch';
					program = "${file}";
					console = "integratedTerminal",
					pythonPath = function()
						return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
					end;
				},
			}
			vim.fn.sign_define('DapBreakpoint', { text = '󰨰', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
			vim.keymap.set("n", "<leader>pt", function() dap.toggle_breakpoint() end, { desc = '[T]oggle [B]reak point' })
			vim.keymap.set('n', '<Leader>pb', function() dap.set_breakpoint() end, { desc = '[S]et [B]reak point' })
			vim.keymap.set('n', '<Leader>ps', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = '[S]et [B]reak point (with message)' })
			vim.keymap.set("n", "<leader>pc", function() dap.continue() end, { desc = '[C]ontinue' })
			vim.keymap.set("n", "<leader>pov", function() dap.step_over() end, { desc = 'Step [Ov]er' })
			vim.keymap.set('n', '<leader>pot', function() dap.step_out() end, { desc = 'Step [O]ut' })
			vim.keymap.set("n", "<leader>pi", function() dap.step_into() end, { desc = 'Step [I]nto' })
			vim.keymap.set("n", "<leader>pr", function() dap.repl.open() end, { desc = 'Inspect state' })
			vim.keymap.set("n", "<leader>pe", function() 
				dap.terminate()
			end, { desc = '[E]nd session' })
			-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
			vim.keymap.set({'n', 'v'}, '<Leader>pwh', function()
				require('dap.ui.widgets').hover()
			end, {desc = '[W]idget [H]over'})
			vim.keymap.set({'n', 'v'}, '<Leader>pwp', function()
				require('dap.ui.widgets').preview()
			end, {desc = '[W]idget [P]review'})
			vim.keymap.set('n', '<Leader>pwc', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end, {desc = '[W]idget [F]loat'})
			vim.keymap.set('n', '<Leader>pws', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end, {desc = '[W]idget [S]copes'})
		end
	},
	
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function ()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
			vim.keymap.set("n", "<leader>bb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>bf", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					theme = "dropdown",
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>bt", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>bh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>bg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>bd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>br", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })		
		end 
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})
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
			-- Keymaps (can also be placed in a separate file if you prefer clean separation)
			vim.keymap.set("n", "<leader>ma", function() harpoon:list():add() end, { desc = '[A]ppends file to harpoon list' })
			vim.keymap.set("n", "<leader>mu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Toggle harpoon menu' })
			vim.keymap.set("n", "<leader>mt", function() toggle_telescope(harpoon:list()) end, { desc = "Telescope Harpoon files" })
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
			-- go to next hook
			vim.keymap.set("n", "<leader>mn", function() harpoon:list():next() end, { desc = "Harpoon next" })
			vim.keymap.set("n", "<leader>mp", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
		end
	},

	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		build = ":UpdateRemotePlugins",
		dependencies = { "3rd/image.nvim" },
		init = function()
			-- this is an example, not a default. Please see the readme for more configuration options
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
	},

	{
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local nvimtree = require("nvim-tree")

			-- recommended settings from nvim-tree documentation
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			nvimtree.setup({
				view = {
					width = 35,
					relativenumber = true,
				},
				-- change folder arrow icons
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						glyphs = {
							folder = {
								arrow_closed = "", -- arrow when folder is closed
								arrow_open = "", -- arrow when folder is open
							},
						},
					},
				},
				-- disable window_picker for
				-- explorer to work well with
				-- window splits
				actions = {
					open_file = {
						window_picker = {
							enable = false,
						},
					},
				},
				filters = {
					custom = { ".DS_Store" },
				},
				git = {
					ignore = false,
				},
			})

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
			keymap.set("n", "<leader>xf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
			keymap.set("n", "<leader>xc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
			keymap.set("n", "<leader>xr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		end
	},

	{
		"mg979/vim-visual-multi"
	},

	{
		"goolord/alpha-nvim",
		-- dependencies = { 'echasnovski/mini.icons' },
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"
			require("alpha").setup(
				startify.config
			)
		end,
	},
})
