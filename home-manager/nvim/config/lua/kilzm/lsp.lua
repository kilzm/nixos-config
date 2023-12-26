local on_attach = function(client, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

	bufmap('<leader>lr', vim.lsp.buf.rename)
	bufmap('<leader>la', vim.lsp.buf.code_action)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('gt', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>ls', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('<leader>lh', vim.lsp.buf.hover)
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
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
		},
	},
}

local servers = { 'pyright', 'nil_ls', 'clangd', 'texlab', 'bashls', 'typst_lsp', 'ols' }
for _,server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
