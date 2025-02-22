return {
  {
    "nvim-tree/nvim-web-devicons",
    enabled = false,
    config = function()
      require('nvim-web-devicons').setup({
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          }
        },
      })
    end
  },
  { 'echasnovski/mini.icons', version = false },
}
