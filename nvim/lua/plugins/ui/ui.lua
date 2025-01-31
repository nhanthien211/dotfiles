return {
  -- INFO: disable to use Snacks.picker for vim.ui.select
  -- {
  --   "stevearc/dressing.nvim",
  --   enabled = true,
  --   opts = {},
  -- },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup()
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
        },
      })
    end,
  },
}
