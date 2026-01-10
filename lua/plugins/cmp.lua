local function has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- Comparator that pushes snippets to the bottom
local function deprioritize_snippets(entry1, entry2)
    local kind1 = entry1:get_kind()
    local kind2 = entry2:get_kind()

    local cmp = require('cmp')

    if kind1 == cmp.lsp.CompletionItemKind.Snippet and
        kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
        return false
    end

    if kind2 == cmp.lsp.CompletionItemKind.Snippet and
        kind1 ~= cmp.lsp.CompletionItemKind.Snippet then
        return true
    end
end

return function(proj)
    return {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                completion = {
                    autocomplete = false,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_length = 3 },
                    { name = 'vsnip' },
                }, {
                    { name = 'buffer', keyword_length = 3 },
                }),
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol_text',
                        menu = ({
                            buffer = '[Buffer]',
                            nvim_lsp = '[LSP]',
                            luasnip = '[LuaSnip]',
                            nvim_lua = '[Lua]',
                            latex_symbols = '[Latex]',
                        })
                    }),
                },
                sorting = {
                    comparators = {
                        deprioritize_snippets,           -- 🔹 snippets last
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.score,
                        cmp.config.compare.kind,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
            })
        end,
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'onsails/lspkind-nvim',
        },
    }
end
