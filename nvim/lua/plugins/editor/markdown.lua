return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    event = "VeryLazy",
    ft = { "markdown", "norg", "rmd", "org" },
    config = function()
      require('render-markdown').setup({})
    end,
  }
}
