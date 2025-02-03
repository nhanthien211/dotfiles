return {
  -- todo-comments.nvim: Styling for comment tagging
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
          globalstatus = true,
        },
      })
    end,
  },
}
