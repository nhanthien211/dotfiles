return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      input = { enabled = true, },
      scroll = { enabled = true },

      picker = {
        enabled = true,
        highlight = {

        },
        layout = {
          cycle = true, --- Use the default layout or vertical if the window is too narrow
          preset = function() return vim.o.columns >= 120 and "telescope" or "vertical" end,
        },

        win = {
          preview = {
            minimal = true
          },
        },
      },
      statuscolumn = {
        enabled = true,
        folds = {
          open = true, -- show open fold icons
        },
      },
      words = {
        enabled = true,
        debounce = 200,
      },

      indent = {
        enabled = true,
        chunk = {
          enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          }
        }
      },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
      },

    },
  }
}
