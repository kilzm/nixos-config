require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '│', right = '│' },
        section_separators = '',
        always_divide_middle = false,
        sections = {
            lualine_a = { 'mode', color = "ModeMsg" },
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
