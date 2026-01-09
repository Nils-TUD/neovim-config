-- browse file system
return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('which-key').add({
            { '<leader>x', '<cmd>Neotree reveal toggle<cr>', desc = 'Toggle File Explorer' },
        })
    end
}
