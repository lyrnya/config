-- nvim-tree.lua
vim.api.nvim_set_keymap("n", "<F2>", ":NvimTreeToggle<CR>", {silent = true, noremap = true})

-- Ctrl C Ctrl V
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('n', '<C-v>', '"+p')
vim.keymap.set('i', '<C-v>', '<Esc>"+pa')
