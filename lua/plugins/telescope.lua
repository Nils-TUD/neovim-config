-- create a new cycle picker with the given pickers to cycle trough
local function create_cycle_picker(...)
    local builtin = require "telescope.builtin"
    local state = require "telescope.actions.state"

    local pickers = {...}
    if #pickers == 0 then
        pickers = {
            builtin.find_files,
            builtin.buffers,
        }
    end

    -- although lua tables are indexed from 1 one start with 0 because it is
    -- easier to do the modulo stuff 0 based and just add 1 when accessing the
    -- table.
    local index = 0

    -- the picker object we will return
    local cycle = {}
    function cycle.cycle(step)
        step = step or 1
        index = (index + step) % #pickers
        pickers[index+1] { default_text = state.get_current_line() }
    end
    function cycle.next() cycle.cycle(1) end
    function cycle.previous() cycle.cycle(-1) end

    -- return a dynamically created cycle picker with the given pickers
    return setmetatable(cycle, {
        __call = function(opts)
            index = 0
            pickers[index+1](opts)
        end
    })
end

return function(proj)
    return {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local cycle = create_cycle_picker(
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
                { '<C-t>', '<cmd>Telescope resume<cr>', desc = 'Resume Last Search' },
            })
        end,
    }
end
