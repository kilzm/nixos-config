local Remap = require('config.keymap')
local nnoremap = Remap.nnoremap

local gs = require('gitsigns')
gs.setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    signs_staged_enable = false,
})

nnoremap('<leader>hp', gs.preview_hunk, { desc = 'Preview Hunk' })
nnoremap('<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })
nnoremap('<leader>hr', gs.stage_hunk, { desc = 'Reset Hunk' })

nnoremap('<leader>gt', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
