return {
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
  }
}
