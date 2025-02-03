return {
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        rules = {
          { pattern = "lsp", icon = "", color = "green" },
          { pattern = "reload", icon = '', color = 'orange' }
        }
      }
    },
  },
}
