require('FTerm').setup({
    border = 'rounded',
    dimensions = {
        height = 0.9,
        widht = 0.9,
    },
})

local Remap = require('kilzm.keymap')
local nnoremap = Remap.nnoremap
local tnoremap = Remap.tnoremap

nnoremap('<A-t>', function() require('FTerm').toggle() end)
tnoremap('<A-t>', function() require('FTerm').toggle() end)
