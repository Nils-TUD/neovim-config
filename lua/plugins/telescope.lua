return function(proj)
    return {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local cycle = require('telescope.cycle')(
                require('telescope.builtin').buffers,
                require('telescope.builtin').find_files
            )
            local actions = require('telescope.actions')
            local telescope_defs = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-n>"] = function() cycle.next() end,
                        ["<C-h>"] = actions.which_key,
                        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                        ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                    },
                },
            }
            -- merge with project-specific defaults
            if proj.telescope then
                for k,v in pairs(proj.telescope) do
                    telescope_defs[k] = v
                end
            end

            require('telescope').setup({
                defaults = telescope_defs,
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_mru = true,
                        mappings = {
                            i = {
                                ['<c-d>'] = 'delete_buffer',
                            }
                        }
                    }
                }
            })

            require('which-key').add({
                { '<C-f>', '<cmd>Telescope find_files<cr>', desc = 'Find File' },
                { '<C-g>', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
                { '<C-b>', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
                { '<C-r>', '<cmd>Telescope treesitter<cr>', desc = 'Treesitter' },
            })
        end,
    }
end
