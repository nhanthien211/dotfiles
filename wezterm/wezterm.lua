local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Visual configuration
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback {
  { family = 'FiraCode Nerd Font', weight = 600, harfbuzz_features = { "calt=1", "clig=1", "liga=1" } },
  { family = 'Monaspace Neon',     weight = 600, harfbuzz_features = { "calt=0", "clig=0", "liga=0" } },
}

-- =>
config.font_size = 13
config.freetype_load_target = 'Light'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.warn_about_missing_glyphs = true
config.animation_fps = 60
config.prefer_egl = true

config.background = {
  -- the back-most layer, should be image
  {
    source = {
      File = '/Users/ttn/.config/wezterm/wallpaper/neovim-background-2.jpg',
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
    opacity = 0.7
  },
}

config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'
config.enable_wayland = true

-- Keys
config.keys = {
  { key = "%",   mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "$",   mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "w",   mods = "CTRL",       action = wezterm.action.CloseCurrentPane { confirm = true } },

  { key = "h",   mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l",   mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k",   mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j",   mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

  { key = "t",   mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
}

return config
