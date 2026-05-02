return {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
    },
    config = function()
        require "configs.fluttertool"
    end,
}
