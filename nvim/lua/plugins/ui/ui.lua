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
}
