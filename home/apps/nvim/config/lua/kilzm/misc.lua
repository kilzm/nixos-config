require('Comment').setup()
require('nvim-autopairs').setup()
require('headlines').setup()
require('goto-preview').setup({
    default_mappings = true,
})

require('pywal16').setup()
local colors = require('pywal16.core').get_colors()

vim.cmd.colorscheme('pywal16')
vim.api.nvim_set_hl(0, "NonText", { bg = "#202020", fg = colors.foreground })

require('lackluster').setup({
    tweak_background = {
        normal = "none",
        telescope = "none",
        popup = "none",
        menu = "none",
    },
})

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'pywal16-nvim',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})
