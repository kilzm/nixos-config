require('Comment').setup()
require('nvim-autopairs').setup()
require('headlines').setup()
require("barbecue").setup()
require("barbecue.ui").toggle(true)

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

vim.cmd [[ source $HOME/.cache/wal/colors-wal.vim ]]

require('neomodern').setup({
    style = "roseprime",
    transparent = true,
    plain_float = true,

    ui = {
        plain_float = true,
    },
    plugin = {
        lualine = {
            plain = false,
        },
    },
    colors = {
        bg = vim.g.background,
        bg1 = brighten(vim.g.background, 1.3),
        bg2 = brighten(vim.g.background, 1.5),
        line = brighten(vim.g.background, 1.7),
        visual = brighten(vim.g.background, 3.0),
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
    highlights = {
        ["TelescopePromptNormal"] = { bg = "$line", fg = "$fg" },
        ["TelescopePromptBorder"] = { fg = "$line", bg = "$line" },
        ["TelescopeResultsNormal"] = { bg = "$bg2", fg = "$fg" },
        ["TelescopeResultsBorder"] = { fg = "$bg2", bg = "$bg2" },
        ["TelescopePreviewNormal"] = { bg = "$bg1", fg = "$fg" },
        ["TelescopePreviewBorder"] = { fg = "$bg1", bg = "$bg1" },
        ["TelescopeSelection"] = { bg = "$visual", fg = "$fg" },
        ["Pmenu"] = { bg = "$line" },
        ["PmenuSel"] = { bg = "$visual", fg = "$fg" },
        ["NormalFloat"] = { bg = "$line" },
        ["FloatTitle"] = { bg = "$line" },
        ["FloatFooter"] = { bg = "$line" },
        ["FloatBorder"] = { fg = "$line", bg = "$line" },
        ["LazyGitFloat"] = { bg = "$bg2" },
        ["LazyGitBorder"] = { fg = "$bg2", bg = "$bg2" },
        ["ModeMsg"] = { fg = "$fg" },
        ["WinBar"] = { bg = "NONE" },
        ["WinBarNC"] = { bg = "NONE" },
    }
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

local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end
