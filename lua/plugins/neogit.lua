return function(proj)
    return {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            require('neogit').setup({
                graph_style = "unicode",
                disable_line_numbers = false,
                console_timeout = 10000,
                sections = {
                    recent = {
                        folded = false,
                    },
                },
            })

            -- customize some colors
            vim.cmd([[hi MyNeogitRemote guifg=blue]])
            vim.cmd([[hi! link NeogitRemote MyNeogitRemote]])

            require('which-key').add({
                { '<Leader>g', '<cmd>Neogit<cr>', desc = 'Start Neogit' },
                {
                    '<Leader>v',
                    function()
                        local view = require("diffview.lib").get_current_view()
                        if view then
                            vim.cmd("DiffviewClose")
                        else
                            vim.cmd("DiffviewOpen")
                        end
                    end,
                    desc = 'Toggle Diffview'
                }
            })
        end
    }
end
