-- confirm exits with multiple windows/buffers open
return function(proj)
    return {
        "Nils-TUD/confirm-quit.nvim",
        branch = "multi-bufs",
        event = "CmdlineEnter",
        opts = {
            confirm_multi_bufs = true,
        },
    }
end
