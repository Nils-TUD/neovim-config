-- lsp installer
return {
    'williamboman/mason.nvim',
    build = ':MasonUpdate', -- :MasonUpdate updates registry contents
    opts = {
        ui = {
            border = 'single',
        }
    },
}
