local nnoremap = require('config.keymap').nnoremap

require('aerial').setup()
nnoremap("{", '<cmd>AerialPrev<CR>', { desc = 'Aerial Previous' })
nnoremap("}", '<cmd>AerialNext<CR>', { desc = 'Aerial Next' })

require('outline').setup()
nnoremap('<leader>o', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
nnoremap('<leader>O', '<cmd>OutlineFocus<CR>', { desc = 'Toggle Outline Focus' })
