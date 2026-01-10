return function(proj)
    local default_lsps = {
        pylsp = true,
        lua_ls = true,
        bashls = true,
        texlab = true,
    }

    -- start lsp clients according to project settings
    if proj.lsp then
        for k, v in pairs(proj.lsp) do
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
    if proj.save_trim_ws then
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = proj.save_trim_ws,
            command = [[%s/\s\+$//e]],
        })
    end

    -- format on save
    if proj.save_lsp_format then
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = proj.save_lsp_format,
            callback = function()
                vim.lsp.buf.format()
            end
        })
    end

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
end
