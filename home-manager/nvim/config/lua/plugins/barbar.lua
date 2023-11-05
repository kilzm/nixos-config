local Remap = require('settings.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

vim.keymap.set('n', '<TAB>', vim.cmd.BufferNext, { silent = true, })
vim.keymap.set('n', '<A-TAB>', vim.cmd.BufferPrevious, { silent = true, })

vim.keymap.set('n', '<A-x>', vim.cmd.BufferClose, { silent = true, })
vim.keymap.set('n', '<A-z>', vim.cmd.BufferRestore, { silent = true, })
