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
vim.keymap.set("n", "<leader>d", ':edit /Volumes/Mac/Users/rafailadam/Downloads/<CR>', { desc = 'Returns to Downloads directory' })
vim.keymap.set("n", "<leader>t", ':tabnew<CR>', {desc = 'Opens new tab'})
vim.keymap.set("n", "<leader>c", ':terminal<CR>', {desc = 'Opens terminal'})
