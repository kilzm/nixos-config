local keymap = require('kilzm.keymap')
local nnoremap = keymap.nnoremap

local trouble = require('trouble')
trouble.setup()
nnoremap('<leader>tt', function () trouble.toggle() end, { desc = 'Toggle Trouble' })
nnoremap('<leader>tq', function () trouble.toggle("quickfix") end, { desc = 'Trouble Quickfixes' })
nnoremap('<leader>tw', function () trouble.toggle("workspace_diagnostics") end, { desc = 'Trouble Workspace Diagnostics' })
nnoremap('<leader>td', function () trouble.toggle("document_diagnostics") end, { desc = 'Trouble Document Diagnostics' })
nnoremap('<leader>tl', function () trouble.toggle("document_diagnostics") end, { desc = 'Trouble Loclist' })

