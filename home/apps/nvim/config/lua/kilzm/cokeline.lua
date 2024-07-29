local Remap = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

local get_hex = require('cokeline.hlgroups').get_hl_attr

local cokeline = require('cokeline')
cokeline.setup({
    sidebar = {
        filetype = "NvimTree",
        components = {
            {
                text = function(buf)
                    return buf.filetype
                end,
                fg = vim.g.terminal_color_3,
                bg = function() return get_hex('NvimTreeNormal', 'bg') end,
                bold = true,
            },
        }
    },
    components = {
        {
            text = " ",
            fg = function(buffer) return buffer.is_focused and get_hex("CursorLine", "bg") or get_hex("ColorColumn", "bg") end,
        },
        {
            text = function(buffer) return ' ' .. buffer.devicon.icon end,
            fg = function(buffer) return buffer.devicon.color end,
            bg = function(buffer) return buffer.is_focused and get_hex("Normal", "bg") or get_hex("Normal", "bg") end,
        },
        {
            text = " ",
            bg = function(buffer) return buffer.is_focused and get_hex("Normal", "bg") or get_hex("Normal", "bg") end,
        },
        {
            text = function(buffer) return buffer.unique_prefix end,
            fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
            bg = function(buffer) return buffer.is_focused and get_hex("Normal", "bg") or get_hex("Normal", "bg") end,
            italic = true
        },
        {
            text = function(buffer) return buffer.filename .. ' ' end,
            fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
            bg = function(buffer) return buffer.is_focused and get_hex("Normal", "bg") or get_hex("Normal", "bg") end,
        },
    },
    fill_hl = 'Normal',
    default_hl = {
        fg = function(buffer)
            local hlgroups = require("cokeline.hlgroups")
            return hlgroups.get_hl_attr("ColorColumn", "bg")
        end,
        bg = function(buffer)
            local hlgroups = require("cokeline.hlgroups")
            return hlgroups.get_hl_attr("ColorColumn", "fg")
        end,

        sp = nil,
        bold = function(buffer) return buffer.is_focused end,
        italic = nil,
        underline = nil,
        undercurl = nil,
        strikethrough = nil,
    },
})

nnoremap('<TAB>', '<Plug>(cokeline-focus-next)', { silent = true, })
nnoremap('<A-TAB>', '<Plug>(cokeline-focus-prev)', { silent = true, })
nnoremap('<A-x>', vim.cmd.bdelete, { silent = true, })
