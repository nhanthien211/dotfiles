return {
  -- INFO: run `:Copilot auth` on first run
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end
  },

  {
    "yetone/avante.nvim",
    enabled = false,
    lazy = true,
    event = "VeryLazy",
    version = false,
    dependencies = {
      -- Required
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot',
      -- -- Optional
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          model = "claude-sonnet-4",
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,
          }
        },

      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,         -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = true, -- Whether to enable token counting. Default to true.
      },
      file_selector = { provider = "snacks", },
      windows = { width = 35, },
      hints = { enabled = false },
    },
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  },

  -- NOTE: This is actually quite nice and faster than Avante. Keep in case I change my mind
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" },  -- for curl, log and async functions
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
