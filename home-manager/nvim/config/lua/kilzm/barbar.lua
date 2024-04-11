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
    default_hl = {
        fg = function(buffer)
            local hlgroups = require("cokeline.hlgroups")
                return hlgroups.get_hl_attr("ColumnColor", "bg")
        end,
        bg = function(buffer)
            local hlgroups = require("cokeline.hlgroups")
                return hlgroups.get_hl_attr("ColumnColor", "fg")
        end,

        sp = nil,
        bold = function(buffer) return buffer.is_focused end,
        italic = nil,
        underline = function(buffer) return buffer.is_focused end,
        undercurl = nil,
        strikethrough = nil,
    },
})

local mappings = require('cokeline.mappings')

nnoremap('<TAB>', '<Plug>(cokeline-focus-next)', { silent = true, })
nnoremap('<A-TAB>', '<Plug>(cokeline-focus-prev)', { silent = true, })
nnoremap('<A-x>', vim.cmd.bdelete, { silent = true, })

