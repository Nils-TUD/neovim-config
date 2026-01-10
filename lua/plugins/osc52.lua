-- OSC 52 for proper copy&paste support
return function(proj)
    return {
        'ojroques/nvim-osc52',
        config = function()
            require('osc52').setup({
                tmux_passthrough = true,
            })

            -- copy and paste via osc52
            local function copy(lines, _)
                require('osc52').copy(table.concat(lines, '\n'))
            end
            local function paste()
                return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
            end

            vim.g.clipboard = {
                name = 'osc52',
                copy = { ['+'] = copy, ['*'] = copy },
                paste = { ['+'] = paste, ['*'] = paste },
            }

            vim.api.nvim_create_autocmd('TextYankPost', {
                callback = function()
                    if vim.v.event.operator == 'y' and (vim.v.event.regname == '' or vim.v.event.regname == '+') then
                        require('osc52').copy_register('+')
                    end
                end
            })
        end,
    }
end
