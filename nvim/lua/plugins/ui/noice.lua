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
      require("noice").setup({
        presets = {
          inc_rename = true,
        },
      })
    end,
  },
}
