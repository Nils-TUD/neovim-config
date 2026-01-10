local function sublime_log()
    local file = vim.fn.expand('%:p')
    vim.api.nvim_command(':!smerge log ' .. file)
end

local function sublime_blame()
    local file = vim.fn.expand('%:p')
    local line = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_command(':!smerge blame ' .. file .. ' ' .. line)
end

require('which-key').add({
    { '<Leader>sl', sublime_log, desc = 'Sublime Merge Log' },
    { '<Leader>sb', sublime_blame, desc = 'Sublime Merge Blame' },
})
