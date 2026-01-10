-- Please place this file to following location
-- ~/.config/nvim/init.lua on Mac, Linux
-- ~/AppData/Local/nvim/init.lua on Windows
--------------------------------------------------------------

require('config.debug')
require('config.options')
require('config.keymaps')
require('config.lazy')

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

local default_lsps = {
    pylsp = true,
    lua_ls = true,
    bashls = true,
    texlab = true,
}

-- start lsp clients according to project settings
if proj_local.lsp then
    for k, v in pairs(proj_local.lsp) do
        -- rust is already handled by rust-tools
        if k ~= 'rust-analyzer' then
            if v then
                vim.lsp.config(k, v)
            else
                default_lsps[k] = false
            end
        end
    end
end

-- now start all not-disabled default LSPs
for k, v in pairs(default_lsps) do
    if v then
        vim.lsp.enable(k)
    end
end

-- trim whitespace on save
if proj_local.save_trim_ws then
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        pattern = proj_local.save_trim_ws,
        command = [[%s/\s\+$//e]],
    })
end

-- format on save
if proj_local.save_lsp_format then
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        pattern = proj_local.save_lsp_format,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- nvim-cmp
local cmp = require('cmp')

-- Comparator that pushes snippets to the bottom
local function deprioritize_snippets(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()

  if kind1 == cmp.lsp.CompletionItemKind.Snippet and
     kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
    return false
  end

  if kind2 == cmp.lsp.CompletionItemKind.Snippet and
     kind1 ~= cmp.lsp.CompletionItemKind.Snippet then
    return true
  end
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    completion = {
        autocomplete = false,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'vsnip' },
    }, {
        { name = 'buffer', keyword_length = 3 },
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
            })
        }),
    },
    sorting = {
        comparators = {
            deprioritize_snippets,           -- 🔹 snippets last
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

-- telescope
local cycle = require('telescope.cycle')(
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
if proj_local.telescope then
    for k,v in pairs(proj_local.telescope) do
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
})

-- close floating windows via <C-w>f
local function close_floating()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
        end
    end
end
require('which-key').add({
    { '<C-w>f', close_floating, desc = 'Closes all floating windows' },
})

-- sublime merge interaction
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

-- ignore cancellations by the LSP
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
