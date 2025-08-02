return {
  {
    "nvchad/base46",
    -- enabled = false,
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    -- enabled = false,
    lazy = false,
    config = function()
      require "nvchad"
      -- vim.cmd.colorscheme("nvchad") -- default

      vim.keymap.set("n", "<leader>fn", function()
        require("nvchad.themes").open()
      end, { desc = "Find base46 theme" })
    end,
  },

  {
    "nvzone/volt",
    enabled = false,
  }
}
