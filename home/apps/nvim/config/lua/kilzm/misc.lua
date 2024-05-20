require('Comment').setup()
require('nvim-autopairs').setup()
require('headlines').setup()
require('alpha').setup(require('alpha.themes.startify').config)

require('kanagawa').setup({
    colors = {
        theme = {
            wave = {
                ui = {
                    bg_gutter = "none",
                },
            },
        },
    },
    overrides = function(colors)
        local theme = colors.theme
        local palette = colors.palette
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- NvimTree
            NvimTreeWinSeparator = { fg = palette.sumiInk4 },
            NvimTreeNormal = { bg = palette.sumiInk3 },

            LazyGitBorder = { fg = palette.sumiInk4 },
        }
    end
})

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'kanagawa',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
})

local KittyGroup = vim.api.nvim_create_augroup("KittyGroup", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        vim.cmd("silent !kitty @ set-spacing padding=0 margin=0")
    end,
    group = KittyGroup,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.cmd("silent !kitty @ set-spacing padding=10 margin=5")
    end,
    group = KittyGroup,
})
