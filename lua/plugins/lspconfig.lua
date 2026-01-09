return {
    'neovim/nvim-lspconfig',
    config = function()
        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local r_opts = {
                    buffer = ev.buf,
                    mode = 'n',
                }
                require('which-key').add({
                    { '<Leader>D', vim.lsp.buf.declaration, desc = 'Go To Declaration' },
                    { '<Leader>d', vim.lsp.buf.definition, desc = 'Go To Definition' },
                    { '<Leader>i', vim.lsp.buf.implementation, desc = 'Go To Implementation' },
                    { '<Leader>r', vim.lsp.buf.references, desc = 'Show References' },
                    { '<Leader>R', vim.lsp.buf.rename, desc = 'Rename' },
                    { '<Leader>a', vim.lsp.buf.code_action, desc = 'Code Actions' },
                    { '<Leader>ci', vim.lsp.buf.incoming_calls, desc = 'Incoming Calls' },
                    { '<Leader>co', vim.lsp.buf.outgoing_calls, desc = 'Outgoing Calls' },
                    { '<leader>n', '<cmd>RustLsp renderDiagnostic cycle_prev<cr>', desc = 'Previous Diagnostics' },
                    { '<leader>m', '<cmd>RustLsp renderDiagnostic cycle<cr>', desc = 'Next Diagnostics' },
                    { '<Leader>e', '<cmd>RustLsp expandMacro<cr>', desc = 'Expand Macro' },
                    {
                        '<Leader>f',
                        function()
                            vim.lsp.buf.format { async = true }
                        end,
                        desc = 'Format'
                    },
                    { '<C-space>', vim.lsp.buf.hover, desc = 'Show documentation' },
                    { '<C-r>', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'LSP Document Symbols' },
                    { '<C-x>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'LSP Workspace Symbols' },
                    { '<leader>s', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace Diagnostics' },
                }, r_opts)
            end,
        })
    end
}
