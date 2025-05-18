local Remap = require('config.keymap')
local nnoremap = Remap.nnoremap

require('nvim-treesitter.configs').setup {
    ensure_installed = { },
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-]>",
            node_incremental = "C-]>",
            scope_incremental = false,
            node_decremental = "<C-[>",
        },
    },
}
