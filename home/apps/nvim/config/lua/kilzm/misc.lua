require('Comment').setup()
require('nvim-autopairs').setup()
require('headlines').setup()
require('goto-preview').setup({
    default_mappings = true,
})

vim.cmd [[ source $HOME/.cache/wal/colors-wal.vim ]]

require('neomodern').setup({
    style = "roseprime",
    transparent = true,

    ui = {
        plain_float = true,
        telescope = "bordered",
        lualine = {
            plain = true,
        },
    },

    colors = {
        bg = vim.g.background,
        fg = vim.g.foreground,
        keyword = vim.g.color1,
        preproc = vim.g.color1,
        hint = vim.g.color1,
        func = vim.g.color4,
        builtin = vim.g.color4,
        property = vim.g.foreground,
        type = "#82a4a5",
        operator = "#a09073",
        string = "#84a389",
        constant = "#846e83",
        delta = "#846e83",
    },
})

require('neomodern').load()
require('lualine').setup({
    options = {
        icons_enabled = false,

        theme = 'neomodern',
        component_separators = { left = '', right = '' },
        section_separators = '',
        always_divide_middle = false,
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    },
})

