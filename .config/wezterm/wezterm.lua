-- WezTerm config mirroring the Ghostty setup (.config/ghostty/config).
-- Each block notes the Ghostty option it replicates.
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Ensure WezTerm handles the macOS IME correctly
config.use_ime = true

-- font-family = BlexMono Nerd Font / font-size = 15.
-- Explicit fallback chain: Devanagari (Sanskrit) goes to Kohinoor Devanagari
-- (macOS system font) instead of a random fallback.
config.font = wezterm.font_with_fallback({
	"BlexMono Nerd Font",
	"Kohinoor Devanagari",
})
-- Enable HarfBuzz for proper ligature and complex text shaping
config.harfbuzz_features = { "kern", "liga", "clig", "calt" }
config.font_size = 15.0

-- wezterm rasterizes with bundled FreeType even on macOS, which looks thinner
-- and fuzzier than the CoreText rendering in Ghostty/kitty. No hinting (what
-- macOS itself does) + LCD render target is the closest match to native text.
config.freetype_load_flags = "NO_HINTING"
config.freetype_render_target = "HorizontalLcd"

-- theme = catppuccin-frappe (bundled with wezterm, no vendoring needed)
config.color_scheme = "Catppuccin Frappe"

-- window-width = 200 / window-height = 48
config.initial_cols = 200
config.initial_rows = 48

-- Ghostty defaults to 2px window padding
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

-- macos-option-as-alt = true (both alt keys send Alt, not composed chars)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- bell-features = no-audio
config.audible_bell = "Disabled"

-- command = /opt/homebrew/bin/bash --login
config.default_prog = { "/opt/homebrew/bin/bash", "--login" }

-- Ghostty paints the titlebar dark (transparent style); wezterm's native
-- titlebar follows the system appearance and clashes in light mode. Use the
-- fancy tab bar as a dark titlebar with the traffic lights integrated in it
-- (always visible — it doubles as the window drag area).
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "MacOsNative"
config.window_frame = {
	active_titlebar_bg = "#292c3c", -- catppuccin frappe mantle
	inactive_titlebar_bg = "#292c3c",
}

-- tab/window/split-inherit-working-directory: new tabs/splits use the current
-- pane's cwd, reported via OSC 7 (the shell integration sourced in .profile).

-- Splits mirror Ghostty's macOS bindings
-- (cmd+d right, cmd+shift+d down, cmd+alt+arrows to navigate, zoom toggle)
config.keys = {
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD|OPT", action = act.ActivatePaneDirection("Down") },
	{ key = "Enter", mods = "CMD|SHIFT", action = act.TogglePaneZoomState },
}

return config
