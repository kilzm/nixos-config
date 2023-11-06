local Remap = require('settings.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<TAB>', vim.cmd.BufferNext, { silent = true, })
nnoremap('<A-TAB>', vim.cmd.BufferPrevious, { silent = true, })

nnoremap('<A-x>', vim.cmd.BufferClose, { silent = true, })
nnoremap('<A-z>', vim.cmd.BufferRestore, { silent = true, })
