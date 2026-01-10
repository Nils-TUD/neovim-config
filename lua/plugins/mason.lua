-- lsp installer
return function(proj)
    return {
        'williamboman/mason.nvim',
        build = ':MasonUpdate', -- :MasonUpdate updates registry contents
        opts = {
            ui = {
                border = 'single',
            }
        },
    }
end
