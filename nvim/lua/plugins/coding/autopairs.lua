return {
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    config = true,
  },

  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",            -- Add surrounding in Normal and Visual modes
          delete = "ds",         -- Delete surrounding
          replace = "cr",        -- Replace surrounding

          find = "sf",           -- Find surrounding (to the right)
          find_left = "sF",      -- Find surrounding (to the left)
          highlight = "sh",      -- Highlight surrounding
          update_n_lines = "sn", -- Update `n_lines`

          suffix_last = "l",     -- Suffix to search with "prev" method
          suffix_next = "n",     -- Suffix to search with "next" method
        },
      })
    end,
  },
}
