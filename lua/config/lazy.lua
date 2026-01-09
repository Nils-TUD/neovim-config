local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print('Cloning lazy.nvim ...')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Dynamically require all plugin files
local plugin_folder = "plugins"
local cfg_folder = vim.fn.stdpath("config")
local plugin_filelist = vim.fn.glob(cfg_folder .. "/lua/" .. plugin_folder .. "/*.lua")
local plugin_files = vim.split(plugin_filelist, "\n")

local plugins = {}
for _, file in ipairs(plugin_files) do
    local name = file:match(".+/lua/.+/(.+)%.lua$")
    local plugin = require(plugin_folder .. "." .. name)
    table.insert(plugins, plugin)
end

local opts = {
    ui = {
        border = 'single',
    }
}

require("lazy").setup(plugins, opts)
