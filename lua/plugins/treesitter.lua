return function(proj)
    return {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.10.0',
        build = ':TSUpdate',
        opts = {
            ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'rust', 'python' },
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    }
end
