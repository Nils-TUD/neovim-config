-- search and replace
return function(proj)
    return {
        'nvim-pack/nvim-spectre',
        opts = {
            default = {
                replace = {
                    cmd = "oxi"
                }
            }
        },
        config = function()
            require('which-key').add({
                {
                    '<leader>p',
                    function()
                        require('spectre').open(proj.spectre)
                    end,
                    desc = 'Interactive search & replace'
                },
                {
                    '<leader>P',
                    function()
                        -- to ensure that we can reach the file via rg, set cwd to its directory and use the
                        -- file name as the path.
                        local buf_path = vim.fn.expand('%:p:h')
                        local buf_file = vim.fn.expand('%:t')
                        require('spectre').open({
                            is_insert_mode = true,
                            cwd = buf_path,
                            path = buf_file,
                            is_close = true, -- close an exists instance of spectre and open new
                        })
                    end,
                    desc = 'Interactive search & replace (current file)',
                }
            })
        end
    }
end
