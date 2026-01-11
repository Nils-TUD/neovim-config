return function(proj)
    return {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                'css';
                'javascript';
                'html';
            })
        end,
    }
end
