return {
    'williamboman/mason-lspconfig.nvim',
    opts = {
        -- in clang 17 the formatter ignores my .clang-format
        ensure_installed = { "clangd@16.0.2" },
        automatic_enable = {
            exclude = {
                -- rustaceanvim will start it (otherwise we have two)
                "rust_analyzer",
            }
        }
    },
}
