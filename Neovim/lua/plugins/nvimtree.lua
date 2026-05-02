return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    enabled = true,
    opts = function()
        return require "configs.nvimtree"
    end,
}
