local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Visual configuration
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback {
  { family = 'FiraCode Nerd Font', weight = 600, harfbuzz_features = { "calt=1", "clig=1", "liga=1" } },
  { family = 'Monaspace Neon',     weight = 600, harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
}

config.font_size = 13
config.freetype_load_target = 'Light'
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.hide_tab_bar_if_only_one_tab = true
config.warn_about_missing_glyphs = true

config.window_padding = {
  left = "0.50cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = "0cell",
}
config.underline_thickness = "200%"
config.underline_position = "-3pt"
config.enable_scroll_bar = false
config.animation_fps = 60
config.prefer_egl = true
config.debug_key_events = true
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.2
}
config.background = {
  -- the back-most layer, should be image
  {
    source = {
      File = '/Users/ttn/.config/wezterm/wallpaper/neovim-background-3.jpg',
    },
    opacity = 1.0,
  },
  -- follow by a color layer which on top of the previous image
  -- set opacity so we can see the image
  {
    source = {
      Gradient = {
        colors = { '#000000' }
      }
    },
    width = '100%',
    height = '100%',
    opacity = 0.6
  },
}

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.enable_wayland = true

-- Keys
config.keys = {
  -- Pane
  { key = "$",          mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "%",          mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "x",          mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = "z",          mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },
  { key = "h",          mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l",          mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k",          mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j",          mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
  { key = "UpArrow",    mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
  { key = "DownArrow",  mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

  -- Tab binding
  { key = "t",          mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "s",          mods = "CTRL|SHIFT", action = wezterm.action.ShowTabNavigator },

  -- Workspace
  { key = "m",          mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

  -- General
  { key = "p",          mods = "CTRL|SHIFT", action = wezterm.action.ActivateCommandPalette },
  { key = "y",          mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
  { key = "c",          mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
  { key = "v",          mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
  { key = "h",          mods = "CTRL|SHIFT", action = wezterm.action.HideApplication },
  { key = "f",          mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
  { key = "LeftArrow",  mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6D") },
  { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.SendString("\x1b[1;6C") },
}

return config
