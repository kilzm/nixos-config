local keymap = require('kilzm.keymap')
local nnoremap = keymap.nnoremap;

require('Comment').setup()
require('nvim-autopairs').setup()
-- require('startup').setup()
require("headlines").setup()

local trouble = require('trouble')
trouble.setup()
nnoremap('<leader>tt', function () trouble.toggle() end);

require('kanagawa').setup({
    colors = {
        theme = {
            wave = {
                ui = {
                    bg_gutter = "none";
                },
            },
        },
    },
})

local flash = require('flash')
flash.setup()
nnoremap('<leader>jj', function () flash.jump() end )
nnoremap('<leader>jt', function () flash.treesitter() end)
nnoremap('<leader>js', function () flash.treesitter_search() end)

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
