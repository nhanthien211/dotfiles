return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        neotree = true,
        snacks = true
      },
      custom_highlights = function(colors)
        return {
          -- NormalFloat = { bg = colors.base, fg = colors.text },
          -- SnacksPickerListCursorLine = { bg = colors.transparent_background, style = { "bold" } },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin") -- default
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)

      -- vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "cooler",
      highlight_overrides = { -- for transparent_background
        Normal = { bg = 'NONE' },
        NormalNC = { bg = 'NONE' },
        CursorLine = { bg = '#222128' },
      },
    },
    config = function(_, opts)
      require("oldworld").setup(opts)

      -- vim.cmd.colorscheme("oldworld")
    end
  }
}
