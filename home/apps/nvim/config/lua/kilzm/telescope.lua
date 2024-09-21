require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "🔭 ",
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
            n = {
                ["q"] = require("telescope.actions").close,
            },
        },
    },

    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
        "themes"
    },
}

pcall(require('telescope').load_extension('fzf'))
pcall(require('telescope').load_extension('ui-select'))

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find by Grep' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current Word' })
vim.keymap.set('n', '<leader>f<leader>', builtin.buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>fa', builtin.help_tags, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Find Select Telescope' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>fc', builtin.highlights, { desc = 'Find Highlights' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find Recent Files' })
