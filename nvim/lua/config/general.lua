local wk = require("which-key")

wk.add({
  {
    "<leader>c",
    group = "Code action",
    {
      -- Conform.nvim
      "<leader>cf",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }, function()
          vim.notify("Formatted", "info", {
            title = "conform.nvim",
          })
        end)
      end,
      desc = "Code format",
    },
    {
      -- Nvim-lint.nvim
      "<leader>cl",
      function()
        require("lint").try_lint()
        local linters = require("lint").get_running()
        vim.notify("Run linting", "info", {
          title = table.concat(linters, ", "),
        })
      end,
      desc = "Code linting",
    },

    -- LSP related
    { "<leader>ca", vim.lsp.buf.code_action,                         desc = "Code action" },
    { "<leader>cc", vim.lsp.codelens.run,                            desc = "Run code lense" },
    { "<leader>cC", vim.lsp.codelens.refresh,                        desc = "Refresh and run code lense" },
    { "<leader>ch", vim.lsp.buf.hover,                               desc = "Hover" },
    { "<leader>cs", vim.lsp.buf.signature_help,                      desc = "Signature help" },
    { "<leader>cd", "<Cmd>lua ToggleLspDiagnostic()<CR>",            desc = "Toggle diagnostic" },

    -- Rename
    { "<leader>cr", ":IncRename ",                                   desc = "Rename" },

    -- Trouble
    { "<leader>ci", "<cmd>Trouble document_diagnostics toggle<cr>",  desc = "Toggle document issues" },
    { "<leader>cI", "<cmd>Trouble workspace_diagnostics toggle<cr>", desc = "Toggle document issues" },

    -- typescript-tool
    { "<leader>co", "<cmd>TSToolsOrganizeImports<cr>",               desc = "Organize imports" },
  },
  {
    "<leader>g",
    group = "LSP and Git",
    -- LSP
    { "<leader>gd", "<Cmd>Trouble lsp_definitions toggle<CR>",      desc = "Go to definition" },
    { "<leader>gt", "<Cmd>Trouble lsp_type_definitions toggle<CR>", desc = "Go to type definition" },
    { "<leader>gi", "<Cmd>Trouble lsp_implementations toggle<CR>",  desc = "Go to implementation" },
    { "<leader>gr", "<Cmd>Trouble lsp_references toggle<CR>",       desc = "Go to reference" },
    { "<leader>gs", "<cmd>TSToolsGoToSourceDefinition<cr>",         desc = "Go to source" },
    { "<leader>gD", vim.lsp.buf.declaration,                        desc = "Go to declaration" },

    -- Git
    { "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>",      desc = "Git blame toggle" },
    { "<leader>gp", ":Gitsigns zopreview_hunk<CR>",                 desc = "Git preview hunk" },
  },
  {
    -- Haproon
    "<leader>h",
    group = "Harpoon",
    {
      "<leader>ha",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add to Harpoon",
    },
    {
      "<leader>hc",
      function()
        require("harpoon"):list():clear()
      end,
      desc = "CLear Harpoon",
    },
  },

  -- Display
  { "<leader>l", "<Cmd>Lazy<CR>",  desc = "Display LazyVim" },
  { "<leader>m", "<Cmd>Mason<CR>", desc = "Display Mason" },

  -- Reload
  {
    "<leader>r",
    group = "Reload",
    { "<leader>rl", "<Cmd>LspRestart<CR>", desc = "Reload LSP" },
    {
      "<leader>re",
      function()
        local tmux_session = "media-hub"
        local handle = io.popen("tmux display-message -p '#S'")
        if handle then
          local current_session = handle:read("*a")
          handle:close()

          -- Remove any trailing newline character from the session name
          current_session = current_session:gsub("\n", "")

          -- Check if the current session matches the desired session
          if current_session ~= tmux_session then
            vim.notify("Current session is not " .. tmux_session, "warn")
            return
          end

          local tmux_panel_id = "1.0"
          local reload_command = "tmux send-keys -t " .. tmux_panel_id .. " r"
          if os.execute(reload_command) then
            vim.notify("Emulator reloaded", "info")
          end
        end
      end,
      desc = "Reload emulator",
    },
  },
  {
    "<leader>t",
    group = "Toggle",
    {
      "<leader>tt",
      function()
        require("trouble").close()
      end,
      desc = "Toggle Trouble",
    },
    {
      "<leader>th",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
      desc = "Toggle inlay hint",
    },
  },
})
