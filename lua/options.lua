vim.opt.number = true            
vim.opt.relativenumber = true    
vim.opt.splitbelow = true        
vim.opt.splitright = true        
vim.opt.wrap = false             
vim.opt.tabstop = 4              
vim.opt.shiftwidth = 4           
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999          
vim.opt.virtualedit = "block"    
vim.opt.ignorecase = true        
vim.opt.termguicolors = true     
vim.opt.shell = "/bin/zsh"
vim.keymap.set('n','<Esc>','<cmd>nohlsearch<CR>')

-- netrw
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
vim.g.netrw_indent = 3

-- Remaps
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = 'Return to [Ex]plorer' })
vim.keymap.set("n", "zj", vim.cmd.w, { desc = '[S]ave' })
vim.keymap.set("n", "zk", vim.cmd.q, { desc = '[Q]uits' })
vim.keymap.set("n", "<leader><CR>", "i<CR><C-c>", { desc = 'Adds a newline at cursor position' })

-- Remapping replacing in file
vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>", { desc = 'find and [R]eplace {x} under cursor' })
vim.keymap.set("x", "<leader>P", "\"_dP", { desc = '[P]aste over highlighted without replacing buffer' })

-- Remapping page jumps to center screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Center screen after half page jump' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Center screen after half page jump' })
vim.keymap.set("n", "{", "{zz", { desc = 'Center screen after code block jump' })
vim.keymap.set("n", "}", "}zz", { desc = 'Center screen after code block jump' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Center screen after [n]ext jump' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Center screen after [N]ext jump' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines up' })

-- Move to usual directories
vim.keymap.set("n", "<leader>t", ':tabnew<CR>', {desc = 'Opens new tab'})
vim.keymap.set("n", "<leader>c", ':terminal<CR>', {desc = 'Opens terminal'})

--Git
vim.keymap.set("n", '<leader>gc', ":Git commit<CR>", { desc = '[C]ommit changes' })
vim.keymap.set("n", '<leader>gl', ":Git log<CR>", { desc = 'Git [L]og' })
vim.keymap.set("n", '<leader>gt', ":Git log --graph --pretty=format:'%h -%d %s (%cr) <%an>' --abbrev-commit --date=relative --all<CR>", { desc = 'Git [L]og [T]ree Full' })
vim.keymap.set("n", '<leader>gs', ":Git status --ignored<CR>", { desc = 'Git [S]tatus' })
vim.keymap.set("n", '<leader>gi', ":Git init .<CR>", { desc = 'Git [I]nitialize' })
vim.keymap.set("n", '<leader>grv', ":Git remote -v<CR>", { desc = 'Git [R]emote -[V]' })
vim.keymap.set("n", '<leader>gp', ":Git push ", { desc = 'Git [P]ush' })
vim.keymap.set("n", '<leader>ga', ":Git add ", { desc = 'Git [A]dd' })
vim.keymap.set("n", '<leader>gb', ":Git branch<CR>:Git checkout ", { desc = 'Git [B]ranch' })

-- Tree sitter parser
vim.keymap.set("n", "<leader>`", vim.cmd.InspectTree, { desc = "Tree sitter parser pane" })

-- Harpoon keybinds
vim.keymap.set("n", "<leader-a>", function() harpoon:list():add() end, { desc = '[A]ppends the file to the harpoon list' })
vim.keymap.set("n", "<leader-q>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Opens the harpoon m[E]nu' })
vim.keymap.set("n", "<leader-s>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window in telescope [S]earch" })
-- Jumps
vim.keymap.set("n", "<leader-0>", function() harpoon:list():select(0) end, { desc = "Opens 0th(?) harpoon listing file" })
vim.keymap.set("n", "<leader-1>", function() harpoon:list():select(1) end, { desc = "Opens first harpoon listing file" })
vim.keymap.set("n", "<leader-2>", function() harpoon:list():select(2) end, { desc = "Opens second harpoon listing file" })
vim.keymap.set("n", "<leader-3>", function() harpoon:list():select(3) end, { desc = "Opens third harpoon listing file" })
vim.keymap.set("n", "<leader-4>", function() harpoon:list():select(4) end, { desc = "Opens fourt harpoon listing file" })
vim.keymap.set("n", "<leader-5>", function() harpoon:list():select(5) end, { desc = "Opens fifth harpoon listing file" })
vim.keymap.set("n", "<leader-6>", function() harpoon:list():select(6) end, { desc = "Opens sixth harpoon listing file" })
vim.keymap.set("n", "<leader-7>", function() harpoon:list():select(7) end, { desc = "Opens seventh harpoon listing file" })
vim.keymap.set("n", "<leader-8>", function() harpoon:list():select(8) end, { desc = "Opens eighth harpoon listing file" })
vim.keymap.set("n", "<leader-9>", function() harpoon:list():select(9) end, { desc = "Opens ninth harpoon listing file" })
-- And the best ones
vim.keymap.set("n", "<leader-n>", function() harpoon:list():next() end, {desc = "[N]ext harpoon listing" })
vim.keymap.set("n", "<leader-m>", function() harpoon:list():prev() end, {desc = "[P]revious harpoon listing" })
