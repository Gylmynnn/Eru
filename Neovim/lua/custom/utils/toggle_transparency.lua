local config = require "nvconfig"

---@type function
local function toggleTransparency()
    config.base46.transparency = not config.base46.transparency
    vim.notify("Transparency: " .. tostring(config.base46.transparency), vim.log.levels.INFO)
    require("base46").load_all_highlights()
end

return toggleTransparency
