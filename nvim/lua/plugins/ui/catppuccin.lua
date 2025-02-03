return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "frappe",
      transparent_background = true,
      integrations = {
        neotree = true,
        -- snacks = true,
      },
      custom_highlights = function(colors)
        return {
          -- SnacksPickerListCursorLine = { bg = colors.transparent_background, style = { "bold" } },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
