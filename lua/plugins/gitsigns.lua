return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            signs_staged_enable = true,
            numhl = true,
        })

        require('which-key').add({
            { '<Leader>ö', '<cmd>Gitsigns nav_hunk prev<cr>', desc = 'Previous Hunk' },
            { '<Leader>ä', '<cmd>Gitsigns nav_hunk next<cr>', desc = 'Next Hunk' },
            { '<Leader>hp', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview Hunk' },
            { '<Leader>hs', '<cmd>Gitsigns stage_hunk<cr>', desc = 'Stage Hunk' },
            { '<Leader>hs', function()
                require('gitsigns').stage_hunk({vim.fn.line('v'), vim.fn.line('.')})
            end, desc = 'Stage Selected Hunk', mode = "v" },
            { '<Leader>hr', '<cmd>Gitsigns reset_hunk<cr>', desc = 'Reset Hunk' },
            { '<Leader>hh', '<cmd>Gitsigns toggle_linehl<cr>', desc = 'Highlight Hunks' },
            { '<Leader>bb', '<cmd>Gitsigns blame<cr>', desc = 'Blame Buffer' },
            { '<Leader>bl', '<cmd>Gitsigns blame_line<cr>', desc = 'Blame Line' },
        })
    end
}
