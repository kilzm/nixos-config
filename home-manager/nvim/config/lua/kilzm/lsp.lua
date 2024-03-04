local on_attach = function(client, bufnr)
    local bufmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, })
    end

    bufmap('<leader>lr', vim.lsp.buf.rename, "Rename Identifier")
    bufmap('<leader>la', vim.lsp.buf.code_action, "Code Action")
    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(0, true)
        bufmap('<leader>li', function() vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0)) end,
            "Toggle Inlay Hints")
    end
    bufmap('<leader>lf', function() vim.lsp.buf.format() end, "Format Code")

    bufmap('gd', vim.lsp.buf.definition, "Goto Definition")
    bufmap('gD', vim.lsp.buf.declaration, "Goto Declaration")
    bufmap('gI', vim.lsp.buf.implementation, "Goto Implementation")
    bufmap('gt', vim.lsp.buf.type_definition, "Goto Definition")

    bufmap('gr', require('telescope.builtin').lsp_references, "Goto References")
    bufmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, "Document Symbols")
    bufmap('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, "Dynamic Workspace Symbols")
    bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('format_on_save', {clear = true}),
    --     callback = function(opts)
    --         if vim.bo[opts.buf].filetype == 'odin' then
    --             vim.lsp.buf.format()
    --         end
    --     end,
    -- })
end

local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            completion = { callSnippet = 'Replace', },
            hint = { enable = true, },
        },
    },
}

local servers = { 'pyright', 'nil_ls', 'clangd', 'texlab', 'bashls', 'typst_lsp', 'ols', 'marksman' }
for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
