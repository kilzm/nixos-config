local cmp = require('cmp')
local luasnip = require('luasnip')

require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
})
require('copilot_cmp').setup()

require("lsp_signature").setup({
    handler_opts = {
        border = "rounded",
    },
    hint_enable = false,
    hint_prefix = "",
})

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup()

local border_opts = {
    border = "rounded",
}


local lspkind = require('lspkind')
lspkind.init({
    symbol_map = {
        Copilot = "",
    },
})

cmp.setup {
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,

            before = function(entry, vim_item)
                return vim_item
            end
        })
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    experimental = {
        ghost_text = true,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.confirm {
            select = false,
        },
        ['<C-CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<A-C-CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- { name = 'copilot' },
        { name = 'buffer' },
        { name = 'path' },
    },
    window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
    },
    completion = { completeopt = "menu,menuone,noinsert" },
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        {
            name = 'cmdline',
            option = { ignore_cmds = { '!' } }
        },
    }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done', cmp_autopairs.on_confirm_done()
)
