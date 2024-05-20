local nnoremap = require('kilzm.keymap').nnoremap
local vnoremap = require('kilzm.keymap').vnoremap

require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        nnoremap(']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { desc  = 'Next hunk', expr = true })

        nnoremap('[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { desc  = 'Previous hunk', expr = true })

        nnoremap('<leader>gs', gs.stage_hunk, { desc = "Stage Hunk" })
        nnoremap('<leader>gr', gs.reset_hunk, { desc = "Reset Hunk" })
        vnoremap('<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Hunk" })
        vnoremap('<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Hunk" })
        nnoremap('<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        nnoremap('<leader>gS', gs.stage_buffer, { desc = "Stage Buffer" })
        nnoremap('<leader>gR', gs.reset_buffer, { desc = "Reset Buffer" })
        nnoremap('<leader>gp', gs.preview_hunk, { desc = "Preview Hunk" })
        nnoremap('<leader>gb', function() gs.blame_line{full = true} end, { desc = "Blame Line" })
        nnoremap('<leader>gB', gs.toggle_current_line_blame, { desc = "Toggle Blame Line" })
        nnoremap('<leader>gd', gs.diffthis, { desc = "Diff This" })
        nnoremap('<leader>gD', function() gs.diffthis('~') end, { desc = "Diff This Root" })
        nnoremap('<leader>gx', gs.toggle_deleted, { desc = "Toggle Deleted" })
    end
})
