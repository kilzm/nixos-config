local Remap  = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

require('nvim-tree').setup({
    view = {
        number = true,
        relativenumber = true,
        width = 40,
    },
})

nnoremap('<leader>e', vim.cmd.NvimTreeToggle, { desc = 'Toggle Nvim Tree' })
nnoremap('<leader>E', vim.cmd.NvimTreeFindFileToggle, { desc = 'Toggle Nvim Tree at current file' })
