vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'QQ', ':q!<CR>', { noremap = true, silent = true })
vim.wo.number = true          -- Mostra números de linha absolutos
