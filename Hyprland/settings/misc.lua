local hyprland = require("helper")

hyprland.section("misc", {
    vfr = true,
    vrr = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
})

hyprland.section("xwayland", {
    force_zero_scaling = true,
})
