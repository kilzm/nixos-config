local Remap = require('config.keymap')
local nnoremap = Remap.nnoremap

local snacks = require('snacks')
snacks.setup({
    picker = {
        enabled = true,
        git = true,
        layout = {
            preset = "telescope",
        },
    },
    indent = {
        enabled = true,
        scope = {
            enabled = false,
        },
    },
})

nnoremap("<leader>gg", function() snacks.lazygit() end, { desc = "Lazygit" })
nnoremap("<leader>gl", function() snacks.lazygit.log() end, { desc = "Lazygit Logs" })

nnoremap("<leader>z", function() snacks.zen() end, { desc = "Toggle Zen Mode" })
nnoremap("<leader>Z", function() snacks.zen.zoom() end, { desc = "Toggle Zoom Zen Mode" })

nnoremap("<leader>ff", function() snacks.picker.files() end, { desc = "Find Files" })
nnoremap("<leader>fk", function() snacks.picker.keymaps() end, { desc = "Find Keymaps" })
nnoremap("<leader>fg", function() snacks.picker.grep() end, { desc = "Find by Grep" })
nnoremap("<leader>fw", function() snacks.picker.grep_word() end, { desc = "Find current Word" })
nnoremap("<leader>f<leader>", function() snacks.picker.buffers() end, { desc = "Find existing buffers" })
nnoremap("<leader>fa", function() snacks.picker.help() end, { desc = "Find Help" })
nnoremap("<leader>fd", function() snacks.picker.diagnostics() end, { desc = "Find Diagnostics" })
nnoremap("<leader>fh", function() snacks.picker.highlights() end, { desc = "Find Highlights" })
nnoremap("<leader>fc", function() snacks.picker.colorschemes() end, { desc = "Find Colorschemes" })
nnoremap("<leader>fr", function() snacks.picker.recent() end, { desc = "Find Recent Files" })
nnoremap("<leader>f:", function() snacks.picker.command_history() end, { desc = "Find in Command History" })

nnoremap("gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
nnoremap("gD", function() snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
nnoremap("gI", function() snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
nnoremap("gt", function() snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
nnoremap('<leader>ls', function() snacks.picker.lsp_symbols() end, { desc = "Lsp: Symbols" })
nnoremap('<leader>lw', function() snacks.picker.lsp_workspace_symbols() end, { desc = "Lsp: Workspace Symbols" })

nnoremap("<leader>gb", function() snacks.picker.git_branches() end, { desc = "Git Branches" })
nnoremap("<leader>gd", function() snacks.picker.git_diff() end, { desc = "Git Diff" })
nnoremap("<leader>gL", function() snacks.picker.git_log() end, { desc = "Git Log" })
nnoremap("<leader>gf", function() snacks.picker.git_log_file() end, { desc = "Git Log File" })
nnoremap("<leader>gs", function() snacks.picker.git_status() end, { desc = "Git Status" })
nnoremap("<leader>gS", function() snacks.picker.git_stash() end, { desc = "Git Stash" })
nnoremap("<leader>gB", function() snacks.gitbrowse() end, { desc = "Git Browse" })

nnoremap("<leader>nh", function() snacks.notifier.show_history() end, { desc = "Notification History" })
nnoremap("<leader>nd", function() snacks.notifier.hide() end, { desc = "Dismiss all Notifications" })
