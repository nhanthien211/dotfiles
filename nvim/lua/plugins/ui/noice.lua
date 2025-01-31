return {
  --Noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
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
