return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "lua",
          "javascript",
          "html",
          "json",
          "markdown",
          "markdown_inline",
          "tsx",
          "typescript",
          "yaml",
          "css",
          "scss",
          "regex",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
}
