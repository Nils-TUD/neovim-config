require('config.debug')
require('config.options')
require('config.keymaps')

-- project local settings
local proj_local_str = vim.secure.read('.nvim.lua')
local proj_local = {
    telescope = {},
    spectre = {},
    lsp = {},
}
if proj_local_str then
    proj_local = loadstring(proj_local_str)()
end

require('config.lazy')(proj_local)
require('config.lsp')(proj_local)

require('config.sublime')
