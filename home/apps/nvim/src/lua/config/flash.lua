local keymap = require('config.keymap')
local nnoremap = keymap.nnoremap
local xnoremap = keymap.xnoremap
local onoremap = keymap.onoremap
local cnoremap = keymap.cnoremap

local flash = require('flash')
flash.setup()

nnoremap('S', function() flash.jump() end, { desc = 'Flash Jump' })
xnoremap('S', function() flash.jump() end, { desc = 'Flash Jump' })
onoremap('S', function() flash.jump() end, { desc = 'Flash Jump' })

nnoremap('<A-s>', function() flash.treesitter() end, { desc = 'Flash Treesitter' })
xnoremap('<A-s>', function() flash.treesitter() end, { desc = 'Flash Treesitter' })
onoremap('<A-s>', function() flash.treesitter() end, { desc = 'Flash Treesitter' })

onoremap('r', function() flash.remote() end, { desc = 'Remote Flash' })

onoremap('R', function() flash.treesitter_search() end, { desc = 'Flash Treesitter Search' })
xnoremap('R', function() flash.treesitter_search() end, { desc = 'Flash Treesitter Search' })

cnoremap('<C-s>', function() flash.toggle() end, { desc = 'Toggle Flash' })
