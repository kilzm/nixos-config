local function brighten(hex, factor)
    hex = hex:gsub("#", "")

    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)

    r = math.min(255, r * factor)
    g = math.min(255, g * factor)
    b = math.min(255, b * factor)

    local function toHex(value)
        return string.format("%02x", math.floor(value))
    end

    return "#" .. toHex(r) .. toHex(g) .. toHex(b)
end

local background = "#141414"
local foreground = "#f0f0f0"

local nightfox = require('nightfox')
nightfox.setup({
    options = {
        transparent = true,
    },
    palettes = {
        all = {
            bg0 = brighten(background, 0.9),
            bg1  = background,
            bg2 = brighten(background, 1.2),
            bg3 = brighten(background, 1.4),
            bg4 = brighten(background, 1.6),

            fg1 = foreground,

            sel0 = brighten(background, 3.0),
            sel1 = brighten(background, 3.2),
        },
    },
    groups = {
        all = {
            WinBar = { bg = "none", fg = "fg2" },
            WinBarNC = { bg = "none", fg = "fg2" },
            StatusLine = { bg = "bg2" },
            StatusLineNC = { bg = "bg2" },
            Pmenu = { bg = "bg4" },
            NormalFloat = { bg = "bg3", fg = "fg" },
            FloatTitle = { bg = "bg3" },
            FloatFooter = { bg = "bg3" },
            FloatBorder = { fg = "bg3", bg = "bg3" },
            LspFloatWinNormal = { bg = "bg4" },
            BlinkCmpDoc = { bg = "bg3", fg = "fg" },
            BlinkCmpDocBorder = { bg = "bg3", fg = "bg3" },
            BlinkCmpDocSeparator = { bg = "bg3", fg = "sel0" },
            MiniFilesBorderModified = { bg = "bg3", fg = "sel0" },
            MiniFilesTitle = { link = "NormalFloat" },
            MiniFilesTitleFocused = { link = "NormalFloat" },
            NonText = { fg = brighten(foreground, 0.6) },
            LspInlayHint = { bg = 'none', fg = "sel0" },
            LspReferenceText = { bg = 'bg4' },
            SnacksIndent = { fg = "bg4" },
            SnacksIndentScope = { fg = "sel1" },
        }
    }
})

vim.cmd("colorscheme nordfox")
