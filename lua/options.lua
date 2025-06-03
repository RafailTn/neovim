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

-- split
vim.keymap.set("n", "<leader>sv", ":split<CR>", { desc = "split vertically" })
vim.keymap.set("n", "<leader>sh", ":vsplit<CR>", { desc = "split horizontally" })

-- netrw
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
vim.g.netrw_indent = 3

-- Remaps
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
