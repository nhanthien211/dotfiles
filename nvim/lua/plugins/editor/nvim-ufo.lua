return {
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(_, ft, _)
        -- INFO some filetypes only allow indent, some only LSP, some only
        -- treesitter. However, ufo only accepts two kinds as priority,
        -- therefore making this function necessary :/
        local lspWithOutFolding = { "markdown", "sh", "css", "html", "python" }
        if vim.tbl_contains(lspWithOutFolding, ft) then
          return { "treesitter", "indent" }
        end
        return { "lsp", "indent" }
      end,
    },
    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
}
