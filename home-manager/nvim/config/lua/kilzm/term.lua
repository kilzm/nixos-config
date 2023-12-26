require('toggleterm').setup({
    direction = 'float',
    size = 20,
    float_opts = {
        border = 'curved'
    },
})

local Remap = require('kilzm.keymap')
local nnoremap = Remap.nnoremap
local tnoremap = Remap.tnoremap

nnoremap('<A-t>', vim.cmd.ToggleTerm)
tnoremap('<A-t>', vim.cmd.ToggleTerm)
