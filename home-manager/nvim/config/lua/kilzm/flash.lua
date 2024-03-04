local keymap = require('kilzm.keymap')
local nnoremap = keymap.nnoremap

local flash = require('flash')
flash.setup()
nnoremap('<leader>jj', function () flash.jump() end, { desc  = 'Flash Jump' } )
nnoremap('<leader>jt', function () flash.treesitter() end, { desc = 'Flash Treesitter' })
nnoremap('<leader>js', function () flash.treesitter_search() end, { desc = 'Flash Treesitter Search' })
