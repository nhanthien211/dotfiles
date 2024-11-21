local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local keys = {}

-- Visual configuration
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('MesloLGS NF', { weight = 'Bold' })
config.font_size = 13
config.enable_tab_bar = false

config.background= {
    -- the back-most layer, should be image
    {
      source = {
        File = '/Users/ttn/.config/wezterm/wallpaper/neovim-background-3.jpg', -- Replace with the path to your image
      },
      opacity = 1.0, -- Adjust transparency (1.0 is fully opaque, 0.0 is fully transparent)
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

return config
