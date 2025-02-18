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
          { pattern = "trouble", icon = "", color = "green" },
          { pattern = "harpoon", icon = '󰉺', color = 'green' },
          { pattern = "reload", icon = '', color = 'orange' },
          { pattern = "notification", icon = '󱥁', color = 'orange' },
          { pattern = "avante", icon = "󰚩", color = 'red' },
          { pattern = "flash", icon = "⚡", },
        }
      }
    },
  },
}
