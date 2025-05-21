local Remap = require('config.keymap')
local nnoremap = Remap.nnoremap

require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.operators').setup()
require('mini.splitjoin').setup()

require('mini.comment').setup()
require('mini.hipatterns').setup()
require('mini.bracketed').setup()
require('mini.cursorword').setup()
require('mini.files').setup()

MiniAi.setup({
    custom_textobjects = {
        m = MiniAi.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
    }
})

MiniCursorword.setup({ delay = 150 })

MiniHipatterns.setup({
    highlighters = {
        hex_color = MiniHipatterns.gen_highlighter.hex_color()
    },
})

nnoremap('<leader>E', MiniFiles.open, { desc = 'Open Mini Files (Project Root)' })
nnoremap('<leader>e', function() MiniFiles.open(vim.fn.expand('%:p:h')) end, { desc = 'Open Mini Files' })
