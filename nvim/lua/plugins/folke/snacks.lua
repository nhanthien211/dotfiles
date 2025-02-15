return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- bigfile = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      input = { enabled = true, },
      scroll = { enabled = true },
      dashboard = { enabled = true },
      image = { enabled = true },
      explorer = { enabled = true },
      notifier = { enabled = true, },
      words = { enabled = true, },

      picker = {
        enabled = true,
        sources = {
          explorer = {
            win = {
              input = {
                title = ""
              }
            }
            -- or provide completely different layout
            -- layout = "custom_file_exlorer"
          }
        },

        layouts = {
          -- INFO: define custom layout to be use
          -- custom_file_exlorer = {
          --   preview = false,
          --   layout = {
          --     backdrop = false,
          --     width = 40,
          --     min_width = 40,
          --     height = 0,
          --     position = "left",
          --     border = "none",
          --     box = "vertical",
          --     {
          --       win = "input",
          --       height = 1,
          --       border = "rounded",
          --       title_pos = "center",
          --     },
          --     { win = "list",    border = "none" },
          --     { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          --   },
          -- }
        },
        layout = {
          cycle = true, --- Use the default layout or vertical if the window is too narrow
          preset = function() return vim.o.columns >= 120 and "telescope" or "vertical" end,
        },

        win = {
          preview = {
            minimal = true,
          },
        },
      },
      statuscolumn = {
        enabled = true,
        folds = {
          open = true, -- show open fold icons
        },
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

    },
  }
}
