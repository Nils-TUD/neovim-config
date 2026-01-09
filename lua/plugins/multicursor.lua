return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",  -- Use the latest tagged version
    opts = {},  -- This causes the plugin setup function to be called
    keys = {
        {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move up"},
        {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move down"},

        {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove cursor"},

        {"<c-d>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
        {"<c-k>", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},

        {"<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = {"n", "x"}, desc = "Lock virtual cursors"},
    },
}
