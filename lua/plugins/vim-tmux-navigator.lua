return function(proj)
    return {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<M-left>", "<cmd>TmuxNavigateLeft<cr>" },
            { "<M-down>", "<cmd>TmuxNavigateDown<cr>" },
            { "<M-up>", "<cmd>TmuxNavigateUp<cr>" },
            { "<M-right>", "<cmd>TmuxNavigateRight<cr>" },
        },
    }
end
