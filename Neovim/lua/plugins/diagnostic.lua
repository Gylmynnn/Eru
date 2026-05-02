return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    enabled = true,
    priority = 1000,
    config = function()
        require "configs.diagnostic"
    end,
}
