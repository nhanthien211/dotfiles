return {
  {
    "williamboman/mason.nvim",
    dependencies = {},
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    enabled = false, -- enable only during first run
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- linter
          "eslint_d",
          "eslint",
          -- formatter
          "prettierd",
          "prettier",
          "stylua",
          -- lsp
          "lua-language-server",
          "yaml-language-server",
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    enabled = false, -- enable only during first run
    event = "VeryLazy",
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "yamlls",
        },
      })
    end,
  },

  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require("template-string").setup({
        remove_template_string = true, -- remove backticks when there are no template strings
        restore_quotes = {
          -- quotes used when "remove_template_string" option is enabled
          normal = [[']],
          jsx = [["]],
        },
      })
    end,
  },
}
