return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        swift = { "swiftlint" }
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      -- add --no-ignore to eslint_d
      local eslint_d = require("lint").linters.eslint_d
      eslint_d.args = vim.list_extend(
        { "--no-warn-ignored" },
        eslint_d.args
      )
    end,
  },
}
