return {
  --Noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("noice").setup({
        presets = {
          inc_rename = true,
        },
      })
    end,
  },
}
