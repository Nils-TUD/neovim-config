return function(proj)
    return {
        'numToStr/FTerm.nvim',
        config = function()
            local ft_cfg = {
                border = 'double',
                dimensions  = {
                    height = 0.9,
                    width = 0.9,
                },
            }
            require('FTerm').setup(ft_cfg)

            require('which-key').add({
                {
                    '<Leader>t',
                    function()
                        require('FTerm').toggle()
                    end,
                    desc = 'Opening FTerm',
                },
            })
        end
    }
end
