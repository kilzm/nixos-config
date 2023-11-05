require('Comment').setup()
require('nvim-autopairs').setup()
require('startup').setup()
-- require('error-lens').setup()
-- require('trouble').setup()

require('nord').setup({
    tranparent = true,
    errors = { mode = 'none' },
    styles = {
        comments = { italic = true },
    },
    terminal_colors = true,
})
vim.cmd.colorscheme("nord")

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'nord',
    },
})

require("headlines").setup()
