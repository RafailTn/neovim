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
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('onedark').setup {
				style = 'darker',
				transparent = true,
				colors = {
					blue = "#61afef",
					deep_blue = "#0077cc",
					orange = "#d19a66",
					pink = "#ff00ff",
					bright_orange = "#ff8800",
					deep_red = "#be5046"
				},
				highlights = {
					["@variable"] = {fg="$orange"},
					["@type"] = {fg="$orange"},
					["@lsp.type.namespace.python"] = {fg = "$deep_red"},
					["@lsp.type.class.python"] = {fg = "$deep_red"},
					["@number"] = {fg="$blue"},
					["@number.float.python"] = {fg="$blue"},
					["@lsp.type.method.python"] = {fg = "$deep_blue"},
					["@function.method"] = { fg = "$deep_blue" },
					["@lsp.type.function.python"] = {fg="$deep_blue"}
				}
			}
			-- Enable theme
			require('onedark').load()
			vim.api.nvim_set_hl(0, '@lsp.type.variable', {})
		end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			local ensure = { "c", "lua", "python", "vim", "vimdoc", "query", "latex", "bibtex" }
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				once = true,
				callback = function()
					local installed = require("nvim-treesitter.config").get_installed()
					local to_install = vim.tbl_filter(function(p)
						return not vim.tbl_contains(installed, p)
					end, ensure)
					if #to_install > 0 then
						require("nvim-treesitter").install(to_install)
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move   = require("nvim-treesitter-textobjects.move")
			local swap   = require("nvim-treesitter-textobjects.swap")

			-- '@parameter.inner' -> 'Swap next parameter (inner)', so which-key has a label
			local function desc(action, query)
				local obj, part = query:match("^@(.-)%.(.+)$")
				return ("%s %s (%s)"):format(action, obj:gsub("_", " "), part)
			end

			-- SELECT
			local sel_maps = {
				['ai'] = '@assignment.inner',  ['al'] = '@assignment.lhs',
				['ao'] = '@assignment.outer',  ['ar'] = '@assignment.rhs',
				['bi'] = '@block.inner',       ['bo'] = '@block.outer',
				['cli'] = '@call.inner',       ['clo'] = '@call.outer',
				['hi'] = '@comment.inner',     ['ho'] = '@comment.outer',
				['ni'] = '@number.inner',
				['ri'] = '@return.inner',      ['ro'] = '@return.outer',
				['so'] = '@statement.outer',
				['po'] = '@parameter.outer',   ['pi'] = '@parameter.inner',
				['fo'] = '@function.outer',    ['fi'] = '@function.inner',
				['co'] = '@class.outer',       ['ci'] = '@class.inner',
				['lo'] = '@loop.outer',        ['li'] = '@loop.inner',
				['io'] = '@conditional.outer', ['ii'] = '@conditional.inner',
			}
			for key, query in pairs(sel_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					select.select_textobject(query, "textobjects")
				end, { desc = desc("Select", query) })
			end

			-- @local.scope lives in the `locals` query group, not `textobjects`
			vim.keymap.set({ "x", "o" }, 'as', function()
				select.select_textobject('@local.scope', "locals")
			end, { desc = "Select local scope" })

			-- MOVE: goto_next_start
			local gns = {
				['gje'] = '@assignment.outer', ['gjb'] = '@block.outer',
				['gjk'] = '@call.outer',       ['gjo'] = '@comment.outer',
				['gjr'] = '@return.outer',     ['gjs'] = '@statement.outer',
				['gjp'] = '@parameter.outer',  ['gjf'] = '@function.outer',
				['gjc'] = '@class.outer',      ['gjl'] = '@loop.outer',
				['gji'] = '@conditional.outer',
			}
			for key, query in pairs(gns) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_next_start(query, "textobjects")
				end, { desc = desc("Next start of", query) })
			end

			-- MOVE: goto_next_end
			local gne = {
				['gJe'] = '@assignment.outer', ['gJb'] = '@block.outer',
				['gJk'] = '@call.outer',       ['gJo'] = '@comment.outer',
				['gJr'] = '@return.outer',     ['gJs'] = '@statement.outer',
				['gJp'] = '@parameter.outer',  ['gJf'] = '@function.outer',
				['gJc'] = '@class.outer',      ['gJl'] = '@loop.outer',
				['gJi'] = '@conditional.outer',
			}
			for key, query in pairs(gne) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_next_end(query, "textobjects")
				end, { desc = desc("Next end of", query) })
			end

			-- MOVE: goto_previous_start
			local gps = {
				['gke'] = '@assignment.outer', ['gkb'] = '@block.outer',
				['gkk'] = '@call.outer',       ['gko'] = '@comment.outer',
				['gkr'] = '@return.outer',     ['gks'] = '@statement.outer',
				['gkp'] = '@parameter.outer',  ['gkf'] = '@function.outer',
				['gkc'] = '@class.outer',      ['gkl'] = '@loop.outer',
				['gki'] = '@conditional.outer',
			}
			for key, query in pairs(gps) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_previous_start(query, "textobjects")
				end, { desc = desc("Prev start of", query) })
			end

			-- MOVE: goto_previous_end
			local gpe = {
				['gKe'] = '@assignment.outer', ['gKb'] = '@block.outer',
				['gKk'] = '@call.outer',       ['gKo'] = '@comment.outer',
				['gKr'] = '@return.outer',     ['gKs'] = '@statement.outer',
				['gKp'] = '@parameter.outer',  ['gKf'] = '@function.outer',
				['gKc'] = '@class.outer',      ['gKl'] = '@loop.outer',
				['gKi'] = '@conditional.outer',
			}
			for key, query in pairs(gpe) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					move.goto_previous_end(query, "textobjects")
				end, { desc = desc("Prev end of", query) })
			end

			-- SWAP next
			local sn = {
				['<leader>je'] = '@assignment.inner', ['<leader>jb'] = '@block.inner',
				['<leader>jk'] = '@call.inner',       ['<leader>jo'] = '@comment.inner',
				['<leader>jr'] = '@return.inner',     ['<leader>jp'] = '@parameter.inner',
				['<leader>jf'] = '@function.outer',   ['<leader>jc'] = '@class.outer',
				['<leader>jl'] = '@loop.outer',       ['<leader>ji'] = '@conditional.outer',
			}
			for key, query in pairs(sn) do
				vim.keymap.set("n", key, function()
					swap.swap_next(query)
				end, { desc = desc("Swap next", query) })
			end

			-- SWAP previous
			local sp = {
				['<leader>ke'] = '@assignment.inner', ['<leader>kb'] = '@block.inner',
				['<leader>kk'] = '@call.inner',       ['<leader>ko'] = '@comment.inner',
				['<leader>kr'] = '@return.inner',     ['<leader>kp'] = '@parameter.inner',
				['<leader>kf'] = '@function.outer',   ['<leader>kc'] = '@class.outer',
				['<leader>kl'] = '@loop.outer',       ['<leader>ki'] = '@conditional.outer',
			}
			for key, query in pairs(sp) do
				vim.keymap.set("n", key, function()
					swap.swap_previous(query)
				end, { desc = desc("Swap prev", query) })
			end
		end,
	},

	{
		"folke/which-key.nvim",
		opts = {},
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
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
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
		'echasnovski/mini.comment', version = '*' 
	},

	{
		'echasnovski/mini.surround', version = '*' 
	},

	{
		'echasnovski/mini.icons', version = '*' 
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},

	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	dependencies = {
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 		"rcarriga/nvim-dap-ui",
	-- 		"nvim-neotest/nvim-nio",
	-- 		"williamboman/mason.nvim",
	-- 		"mfussenegger/nvim-dap-python"
	-- 	},

	-- 	config = function()
	-- 		local dap = require("dap")
	-- 		local dapui = require("dapui")
	-- 		require("nvim-dap-virtual-text").setup()
	-- 		dapui.setup()
	-- 		dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited["dapui_config"] = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.adapters.python = {
	-- 			type = 'executable',
	-- 			command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
	-- 			args = { '-m', 'debugpy.adapter', },
	-- 		}
	-- 		dap.configurations.python = {
	-- 			{
	-- 				type = 'python';
	-- 				name = "Launch file";
	-- 				request = 'launch';
	-- 				program = "${file}";
	-- 				console = "integratedTerminal",
	-- 				pythonPath = function()
	-- 					return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
	-- 				end;
	-- 			},
	-- 		}
	-- 		vim.fn.sign_define('DapBreakpoint', { text = '󰨰', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
	-- 		vim.keymap.set("n", "<leader>pt", function() dap.toggle_breakpoint() end, { desc = '[T]oggle [B]reak point' })
	-- 		vim.keymap.set('n', '<Leader>pb', function() dap.set_breakpoint() end, { desc = '[S]et [B]reak point' })
	-- 		vim.keymap.set('n', '<Leader>ps', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = '[S]et [B]reak point (with message)' })
	-- 		vim.keymap.set("n", "<leader>pc", function() dap.continue() end, { desc = '[C]ontinue' })
	-- 		vim.keymap.set("n", "<leader>pov", function() dap.step_over() end, { desc = 'Step [Ov]er' })
	-- 		vim.keymap.set('n', '<leader>pot', function() dap.step_out() end, { desc = 'Step [O]ut' })
	-- 		vim.keymap.set("n", "<leader>pi", function() dap.step_into() end, { desc = 'Step [I]nto' })
	-- 		vim.keymap.set("n", "<leader>pr", function() dap.repl.open() end, { desc = 'Inspect state' })
	-- 		vim.keymap.set("n", "<leader>pe", function() 
	-- 			dap.terminate()
	-- 		end, { desc = '[E]nd session' })
	-- 		-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
	-- 		vim.keymap.set({'n', 'v'}, '<Leader>pwh', function()
	-- 			require('dap.ui.widgets').hover()
	-- 		end, {desc = '[W]idget [H]over'})
	-- 		vim.keymap.set({'n', 'v'}, '<Leader>pwp', function()
	-- 			require('dap.ui.widgets').preview()
	-- 		end, {desc = '[W]idget [P]review'})
	-- 		vim.keymap.set('n', '<Leader>pwc', function()
	-- 			local widgets = require('dap.ui.widgets')
	-- 			widgets.centered_float(widgets.frames)
	-- 		end, {desc = '[W]idget [F]loat'})
	-- 		vim.keymap.set('n', '<Leader>pws', function()
	-- 			local widgets = require('dap.ui.widgets')
	-- 			widgets.centered_float(widgets.scopes)
	-- 		end, {desc = '[W]idget [S]copes'})
	-- 	end
	-- },
	

	{
		"nvim-telescope/telescope.nvim",
		-- branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"folke/flash.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			local function flash(prompt_bufnr)
				require("flash").jump({
					pattern = "^",
					label = { after = { 0, 0 } },
					search = {
						mode = "search",
						exclude = {
							function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
							end,
						},
					},
					action = function(match)
						local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						picker:set_selection(match.pos[1] - 1)
					end,
				})
			end

			require("telescope").setup({
				defaults = {
					mappings = {n = {["s"] = flash,}, i = {["<C-s>"] = flash,},},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden", "--glob=!.git/" }
						end,
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[?] Find recently opened files" })
			vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>bf", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ theme = "dropdown" }))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>bt", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>bh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>bg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>bd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>br", builtin.resume, { desc = "[S]earch [R]esume" })
		end
	},

	-- {
	-- 	"ThePrimeagen/harpoon",
	-- 	branch = "harpoon2",
	-- 	commit = "e76cb03",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },

	 {
		 "benlubas/molten-nvim",
		 version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		 dependencies = { "3rd/image.nvim" },
		 build = ":UpdateRemotePlugins",
		 init = function()
			 -- these are examples, not defaults. Please see the readme
			 vim.g.molten_image_provider = "image.nvim"
			 vim.g.molten_output_win_max_height = 70
		 vim.g.molten_output_show_more = true
		 end,
	 },

			 {
			     -- see the image.nvim readme for more information about configuring this plugin
			"3rd/image.nvim",
			commit = "4206c48",
			build = false,
			   opts = {
			   	backend = "kitty", -- whatever backend you would like to use
				max_width =150,
				max_height = 70,
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
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			-- Set header
			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}
			vim.cmd([[highlight AlphaHeader guifg=#9a6cd1]])
			dashboard.section.header.opts.hl = "AlphaHeader"
			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
				dashboard.button("SPC e", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
				dashboard.button("SPC fr", "󰱼  > Find Recent File", require("telescope.builtin").oldfiles),
				dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("SPC wr", "  > Restore Session", "<cmd>AutoSession search<CR>"),
				dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
			}
			-- Send config to alpha
			alpha.setup(dashboard.opts)
			-- Disable folding on alpha buffer
			vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		end,
	},

	{
		"christoomey/vim-tmux-navigator"
	},

	-- {
	-- 	"folke/trouble.nvim",
	-- 	opts = {}, -- for default options, refer to the configuration section for custom setup.
	-- 	cmd = "Trouble",
	-- 	keys = {
	-- 		{
	-- 			"<leader>xx",
	-- 			"<cmd>Trouble diagnostics toggle<cr>",
	-- 			desc = "Diagnostics (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xX",
	-- 			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	-- 			desc = "Buffer Diagnostics (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xs",
	-- 			"<cmd>Trouble symbols toggle focus=false<cr>",
	-- 			desc = "Symbols (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xl",
	-- 			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	-- 			desc = "LSP Definitions / references / ... (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xL",
	-- 			"<cmd>Trouble loclist toggle<cr>",
	-- 			desc = "Location List (Trouble)",
	-- 		},
	-- 		{
	-- 			"<leader>xQ",
	-- 			"<cmd>Trouble qflist toggle<cr>",
	-- 			desc = "Quickfix List (Trouble)",
	-- 		},
	-- 	},
	-- },

--	{
--		"supermaven-inc/supermaven-nvim",
--		config = function()
--			require("supermaven-nvim").setup({})
--		end,
--	},

	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		-- lazy=false,
	},

	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{ "<leader>d", function() require("notebook-navigator").move_cell "d" end },
			{ "<leader>u", function() require("notebook-navigator").move_cell "u" end },
			{ "<leader>Z", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
			{ "<leader>z", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
			{ "<leader>ra", "<cmd>lua require('notebook-navigator').run_all_cells()<cr>", desc = "Run all cells" },
			{ "<leader>rb", "<cmd>lua require('notebook-navigator').run_cells_below()<cr>", desc = "Run current and cells below" },
			{ "<leader>ab", "<cmd>lua require('notebook-navigator').add_cell_below()<cr>", desc = "Add cell below" },
			{ "<leader>aa", "<cmd>lua require('notebook-navigator').add_cell_above()<cr>", desc = "Add cell above" },
			{ "<leader>sn", "<cmd>lua require('notebook-navigator').split_cell()<cr>", desc = "Split cell at cursor" },
		},
		dependencies = {
			"echasnovski/mini.comment",
			"benlubas/molten-nvim", -- alternative repl provider
		},
		event = "VeryLazy",
	},

	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require "notebook-navigator"
			local opts = { custom_textobjects = { h = nn.miniai_spec } }
			return opts
		end,
	},

	-- {
	-- 	"mbbill/undotree",
	-- 	keys = {
	-- 		{ "<leader>h", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
	-- 	},
	-- },

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			labels = "abcdefghijklmnopqrstuvwxyz",
			modes = {
				char = {
					jump_labels = true
				}
			},
			search = {
				mode = "search"
			}
		},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	{
		'stevearc/aerial.nvim',
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
	},

	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },

	-- {
	-- 	'stevearc/conform.nvim',
	-- 	opts = {},
	-- },

	{
		'MeanderingProgrammer/markdown.nvim',
		main = "render-markdown",
		opts = {},
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	},

	-- {
	-- 	'rmagatti/auto-session',
	-- 	lazy = false,
	-- 	keys = {
	-- 		-- Will use Telescope if installed or a vim.ui.select picker otherwise
	-- 		{ '<leader>wr', '<cmd>AutoSession search<CR>', desc = 'Session search' },
	-- 		{ '<leader>ws', '<cmd>AutoSession save<CR>', desc = 'Save session' },
	-- 		{ '<leader>wa', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
	-- 	},
	-- 	---enables autocomplete for opts
	-- 	---@module "auto-session"
	-- 	---@type AutoSession.Config
	-- 	opts = {
	-- 		suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
	-- 		-- log_level = 'debug',
	-- 	}
	-- },

	{
		"HiPhish/rainbow-delimiters.nvim"
	},

	{
		'lervag/vimtex',
		lazy = false,
		config = function()
			vim.g.vimtex_view_method = 'zathura' 
			vim.g.vimtex_compiler_method = 'latexmk'
		end
	}

})
