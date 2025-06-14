require('mini.surround').setup({
   mappings = {
     add = 'gss', -- Add surrounding in Normal and Visual modes
     delete = 'gsd', -- Delete surrounding
     find = 'gsf', -- Find surrounding (to the right)
     find_left = 'gsF', -- Find surrounding (to the left)
     highlight = 'gsh', -- Highlight surrounding
     replace = 'gsr', -- Replace surrounding
     update_n_lines = 'gsn', -- Update `n_line`
     sfix_last = 'l', -- Suffix to search with "prev" method
     suffix_next = 'n', -- Suffix to search with "next" method
  },
})
