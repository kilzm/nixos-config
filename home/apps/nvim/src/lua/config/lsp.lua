local capabilities = require('blink.cmp').get_lsp_capabilities({})
local servers = { 'texlab', 'bashls', 'ols', 'marksman', 'jdtls', 'glsl_analyzer', 'ts_ls', 'lua_ls',
    'clangd', 'nixd', 'gdscript', 'qmlls', 'rust_analyzer' }
for _, server in ipairs(servers) do
    vim.lsp.enable(server)
    vim.lsp.config(server, {
        capabilities = capabilities,
    })
end

vim.lsp.enable('basedpyright')
vim.lsp.config('basedpyright', {
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "workspace",
            },
        },
    },
})

vim.lsp.enable('nixd')
vim.lsp.config('nixd', {
    capabilities = capabilities,
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "nix fmt" },
            },
            options = {
                nixos = {
                    expr =
                    '(builtins.getFlake ("/home/kilianm/nixos-config")).nixosConfigurations.albrecht.options',
                },
                home_manager = {
                    expr =
                    '(builtins.getFlake ("/home/kilianm/nixos-config")).homeConfigurations."kilianm@albrecht".options',
                },
            },
        },
    },
})

require('lazydev').setup()

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'Lsp: ' .. desc })
        end

        if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, {})
            map('<leader>li', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
                "Toggle Inlay Hints")
        end
        map('<leader>lf', function() vim.lsp.buf.format() end, "Format Code")
        map('<leader>lr', function() vim.lsp.buf.rename() end, "Rename")
        map('<leader>lR', function() vim.lsp.buf.references() end, "References")
        map('<leader>la', function() vim.lsp.buf.code_action() end, "Code Action")
    end,
})

vim.diagnostic.config({ virtual_lines = { current_line = true } })
