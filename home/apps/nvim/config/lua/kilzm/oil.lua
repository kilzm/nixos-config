local keymap = require('kilzm.keymap')
local nnoremap = keymap.nnoremap


require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

nnoremap("-", "<CMD>Oil<CR>", { desc = "Open Oil" })
nnoremap("<leader>-", require("oil").toggle_float, { desc = "Toggle floating Oil" })
