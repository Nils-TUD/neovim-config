return function(proj)
    return {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- relative path
                    }
                },
                lualine_a = {
                    {
                        'mode',
                        fmt = function(mode)
                            return vim.b['visual_multi'] and mode .. ' - MULTI' or mode
                        end
                    },
                },
            },
        },
    }
end
