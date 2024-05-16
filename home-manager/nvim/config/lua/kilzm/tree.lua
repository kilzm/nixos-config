local Remap    = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    view = {
        adaptive_size = false,
        side = "right",
        number = true,
        relativenumber = true,
        width = 40,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
})

nnoremap('<leader>e', vim.cmd.NvimTreeToggle, { desc = 'Toggle Nvim Tree' })
nnoremap('<leader>E', vim.cmd.NvimTreeFindFileToggle, { desc = 'Toggle Nvim Tree at current file' })
