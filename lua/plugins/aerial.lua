-- code outline
return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('aerial').setup({})
        require('which-key').add({
            { '<leader>o', '<cmd>AerialToggle<cr>', desc = 'Toggle Code Outline' },
        })
    end
}
