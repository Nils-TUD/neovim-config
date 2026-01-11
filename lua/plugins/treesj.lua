return function(proj)
    return {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })

            require('which-key').add({
                { '<Leader>s', require('treesj').toggle, desc = 'Toggle node under cursor' },
            })
        end,
    }
end
