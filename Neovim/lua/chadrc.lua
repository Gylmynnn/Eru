--- NOTE: This for nvchad prefrences configuration

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everblush",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  cmp = {
    icons_left = false,
    icons = true,
    lspkind_text = false,
    style = "flat_dark",
    border_color = "#E57474",
    border = true,
    selected_item_bg = "colored",
  },

  telescope = { style = "borderless" },

  tabufline = {
    enabled = false,
    lazyload = false,
  },
  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "round",
    overriden_modules = nil,
  },
}

-- M.nvdash = { load_on_startup = true }

return M
