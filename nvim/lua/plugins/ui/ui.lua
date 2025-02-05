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
          -- ENABLE TO HAVE LSP DIAGNOSTICS ON TAB
          -- diagnostics = "nvim_lsp",
          -- diagnostics_update_in_insert = false,
          -- diagnostics_indicator = function(_, _, diagnostics_dict)
          -- 	local icons = require("config.icons").diagnostics
          -- 	local s = ""
          -- 	for e, n in pairs(diagnostics_dict) do
          -- 		local sym = e == "error" and icons.error or (e == "warning" and icons.warning or icons.hint)
          -- 		s = s .. n .. " " .. sym
          -- 	end
          -- 	return s
          -- end,
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
