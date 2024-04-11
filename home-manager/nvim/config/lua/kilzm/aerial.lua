local nnoremap = require('kilzm.keymap').nnoremap

require('aerial').setup({
    on_attach = function(bufnr)
        nnoremap("{", '<cmd>AerialPrev<CR>', { desc = 'Aerial Previous' })
        nnoremap("}", '<cmd>AerialNext<CR>', { desc = 'Aerial Next' })

        nnoremap('<leader>a', '<cmd>AerialToggle<CR>', { desc = 'Toggle Aerial' })
    end
})
