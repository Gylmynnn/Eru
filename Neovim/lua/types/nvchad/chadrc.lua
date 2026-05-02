---@meta
---@class ChadrcConfig
---@field ui? UIConfig
---@field base46? Base46Config
---@field lsp? NvLspConfig
---@field term? TermConfig
---@field cheatsheet? NvCheatsheetConfig
---@field mason? MasonConfig
---@field colorify? ColorifyConfig
---@field nvdash? NvDashConfig

---@class Base46Config
---@field hl_add? HLTable
---@field hl_override? Base46HLGroupsList
---@field changed_themes? ChangedTheme
---@field theme_toggle? ThemeName[]
---@field transparency? boolean
---@field theme? ThemeName
---@field integrations? Base46Integrations[]


---@class UIConfig
---@field cmp? NvCmpConfig
---@field telescope? NvTelescopeConfig
---@field statusline? NvStatusLineConfig
---@field tabufline? NvTabLineConfig

---@class NvCmpConfig
---@field icons? boolean
---@field style? '"default"'|'"flat_light"'|'"flat_dark"'|'"atom"'|'"atom_colored"'
--- @field abbr_maxwidth? integer
--- @field icons_left? boolean
--- @field format_colors? NvCmpFormatColors

---@class NvTelescopeConfig
---@field style? '"borderless"'|'"bordered"'

---@class NvStatusLineConfig
---@field enabled? boolean
---@field theme? '"default"'|'"vscode"'|'"vscode_colored"'|'"minimal"'
---@field separator_style? '"default"'|'"round"'|'"block"'|'"arrow"'|{ left: string, right: string }
---@field order? string[]
---@field modules? table<string, string | fun(): string>
---
---@class NvTabLineConfig
---@field enabled? boolean
---@field lazyload? boolean
---@field bufwidth? number
---@field order? ('"treeOffset"'|'"buffers"'|'"tabs"'|'"btns"')[] | string[]
---@field modules? table<string, fun(): string>

---@class NvDashConfig
---@field load_on_startup? boolean
---@field header? string[] | (fun(): string[])
---@field buttons? NvDashButtonConfig[]
---@class NvDashButtonConfig
---@field hl? string
---@field no_gap? boolean
---@field rep? boolean

---@class NvCheatsheetConfig
---@field theme? '"grid"'|'"simple"'
---@field excluded_groups? string[]

---@class NvLspConfig
---@field signature? boolean

---@class TermSizes
---@field sp? number
---@field vsp? number
---@field ["bo sp"]? number
---@field ["bo vsp"]? number

---@class TermFloat
---@field relative? string
---@field row? number
---@field col? number
---@field width? number
---@field height? number
---@field border? string

---@class TermConfig
---@field base46_colors? boolean
---@field winopts? table
---@field sizes? TermSizes
---@field float? TermFloat

---@class MasonConfig
---@field command? boolean
---@field pkgs? string[]

---@class ColorifyConfig
---@field enabled? boolean
---@field mode? "fg"|"bg"|"virtual"
---@field virt_text? string
---@field highlight? ColorifyHL

---@class ColorifyHL
---@field hex? boolean
---@field lspvars? boolean

---@class NvCmpFormatColors
---@field icon? string # icon to use for color swatches
---@field lsp? boolean # show colors from tailwind/css/astro lsp in menu
