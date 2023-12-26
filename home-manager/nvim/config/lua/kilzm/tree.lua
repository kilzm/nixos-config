-- local HEIGHT_RATIO = 0.8
-- local WIDTH_RATIO = 0.5

-- vim.g.nvim_tree_respect_buf_cwd = 1

require('nvim-tree').setup({
    view = {
        number = true,
        relativenumber = true,
    },
})

local Remap  = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>e', vim.cmd.NvimTreeToggle)
nnoremap('<leader>E', vim.cmd.NvimTreeFindFileToggle)
