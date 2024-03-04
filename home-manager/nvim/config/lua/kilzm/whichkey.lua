require('which-key').setup({})
require('which-key').register({
    ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
    ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
    ['<leader>j'] = { name = 'Jump with Flash', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = 'Trouble', _ = 'which_key_ignore' },
    ['g'] = { name = 'Goto', _ = 'which_key_ignore' },
    ["<leader>d"] = "which_key_ignore",
    ["<leader>y"] = "which_key_ignore",
    ["<leader>Y"] = "which_key_ignore",
    ["<leader>p"] = "which_key_ignore",
    ["<leader>P"] = "which_key_ignore",
})
