return {
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd('colorscheme github_light')
        -- don't paint the background (otherwise tmux active/inactive bg doesn't work)
        vim.cmd([[ highlight Normal guibg=NONE ]])
        -- nicer border color for popups
        vim.cmd([[ highlight FloatBorder guifg=#000 guibg=NONE ]])
        -- change LSP hint font color as the default is barely visible
        vim.cmd([[ highlight DiagnosticVirtualTextHint guifg=darkgrey ]])
    end,
}
