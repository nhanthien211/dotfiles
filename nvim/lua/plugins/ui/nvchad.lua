return {
  {
    "nvchad/base46",
    enabled = false,

    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    enabled = false,
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvzone/volt",
    enabled = false,
  }
}
