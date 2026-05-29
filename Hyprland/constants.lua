---@class GlobalVariables
---@field scrPath string
---@field terminal string
---@field browser string
---@field editor string
---@field fileManager string
---@field mainMod string
---@field office string
---@field GTK_THEME string
---@field ICON_THEME string
---@field COLOR_SCHEME string

---@type GlobalVariables
local Constants = {
	scrPath = os.getenv("HOME") .. "/.local/share/bin",
	browser = "min-browser",
	fileManager = "thunar",
	editor = "code",
	terminal = "kitty",
	mainMod = "SUPER",
	office = "onlyoffice-desktopeditors",
	GTK_THEME = "Everblush",
	ICON_THEME = "Windows XP SVG",
	COLOR_SCHEME = "prefer-dark",
}
return Constants
