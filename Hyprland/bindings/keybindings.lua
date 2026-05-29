local constants = require("constants")

local mainMod = constants.mainMod
local term = constants.terminal
local editor = constants.editor
local file = constants.fileManager
local browser = constants.browser
local office = constants.office
local scrPath = constants.scrPath

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen())
hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + Tab", function()
	hl.plugin.hyprexpo.expo("toggle")
end)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"))
hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd('nwg-bar -i 60 -p "right" -mr 20'))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("killall waybar || waybar"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("echo applauncher > " .. os.getenv("XDG_RUNTIME_DIR") .. "/skwd/cmd"))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(office))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd("Hyde show emoji"))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"))

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh c"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/keybinds_hint.sh c"))

hl.bind("F10", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("F11", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("F12", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"),
	{ locked = true, repeating = true }
)

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"))
hl.bind("Print", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"))

-- ── Wallpaper / Theme ────────────────────────────────────────
hl.bind(mainMod .. " + ALT + Right", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n"))
hl.bind(mainMod .. " + ALT + Left", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p"))
hl.bind(mainMod .. " + ALT + Up", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"))
hl.bind(mainMod .. " + ALT + Down", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themestyle.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/swwwallselect.sh"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"))

hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.group.prev())
hl.bind(mainMod .. " + CTRL + L", hl.dsp.group.next())

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + Left", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + Down", hl.dsp.focus({ workspace = "empty" }))
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ── Workspaces: Move Window ──────────────────────────────────
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + ALT + Left", hl.dsp.window.move({ workspace = "r-1" }))

-- ── Workspaces: Move Window Silently ─────────────────────────
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- ── Special Workspace (Scratchpad) ───────────────────────────
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special", silent = true }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special())

-- ── Resize ───────────────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 30, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -30, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -30 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 30 }), { repeating = true })

local function moveActiveOrTile(dx, dy, dir)
	local w = hl.get_active_window()
	if w ~= nil and w.floating then
		hl.dispatch(hl.dsp.window.move_active({ x = dx, y = dy }))
	else
		hl.dispatch(hl.dsp.window.move_to({ direction = dir }))
	end
end

hl.bind(mainMod .. " + SHIFT + CTRL + Left", function()
	moveActiveOrTile(-30, 0, "l")
end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + CTRL + Right", function()
	moveActiveOrTile(30, 0, "r")
end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + CTRL + Up", function()
	moveActiveOrTile(0, -30, "u")
end, { repeating = true })
hl.bind(mainMod .. " + SHIFT + CTRL + Down", function()
	moveActiveOrTile(0, 30, "d")
end, { repeating = true })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true })
