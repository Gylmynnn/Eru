-- ── Layouts ─────────────────────────────────────────────────

local hyprland = require("helper")

hyprland.section("dwindle", {
    pseudotile = "yes",
    preserve_split = "yes",
})

hyprland.section("master", {
    new_status = "master",
})
