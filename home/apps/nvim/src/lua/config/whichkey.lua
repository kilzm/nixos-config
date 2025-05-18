require('which-key').setup({
    notify = false,
    icons = {
        mappings = false,
    },
})

require('which-key').add({
    { "<leader>f", desc = "Find" },
    { "<leader>g", group = "Git" },
    -- { "<leader>j", group = "Jump with Flash" },
    { "<leader>l", group = "LSP" },
    { "<leader>d", group = "Debugging" },
    { "<leader>n", group = "Notifications" },
    { "<leader>P", hidden = true },
    { "<leader>Y", hidden = true },
    { "<leader>d", hidden = true },
    { "<leader>p", hidden = true },
    { "<leader>y", hidden = true },
})
