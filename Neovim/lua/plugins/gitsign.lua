return {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    enabled = true,
    opts = function()
        return require "configs.gitsign"
    end,
}
