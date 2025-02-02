return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    ft = { "markdown", "norg", "rmd", "org" },
    config = function()
      require('render-markdown').setup({})
    end,
  }
}
