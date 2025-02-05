return {
  -- todo-comments.nvim: Styling for comment tagging
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup({
        keywords = {
          TODO = { color = '#8caeee' },
          PERF = { icon = "", color = "#cebebe", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = '', color = "#81c8be", alt = {} },
          INFO = { icon = '󰋼', color = "#ca9ee6" },
          HACK = { icon = "󱜢", }
        }
      })
    end,
  },

  -- lualine.nvim: plugin for vim status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,
        },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          enforce_regular_tabs = false,
          middle_mouse_command = function(bufnum)
            Snacks.bufdelete(bufnum)
          end,

          close_command = function(bufnum)
            Snacks.bufdelete(bufnum)
          end,
          separator_style = "thin",
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          offsets = {
            {
              filetype = "snacks_layout_box",
              text = "File explorer",
              highlight = "Directory",
              text_align = "center",
              separator = true,
            },
          },
        },

        highlights = require("catppuccin.groups.integrations.bufferline").get({
          custom = {
            all = {
              fill = { bug = "#000000" },
            },
          },
        }),
      })
    end,
  }
}
