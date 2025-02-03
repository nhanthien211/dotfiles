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
          vim.notify("Formatted", vim.log.levels.INFO, {
            title = "Conform",
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
        vim.notify("Run linting", vim.log.levels.INFO, {
          title = table.concat(linters, ", "),
        })
      end,
      desc = "Code linting",
    },

    -- LSP related
    { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code action" },
    { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run code lense" },
    { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh and run code lense" },
    { "<leader>ch", vim.lsp.buf.hover,                                  desc = "Hover" },
    { "<leader>cs", vim.lsp.buf.signature_help,                         desc = "Signature help" },

    -- Rename
    { "<leader>cr", ":IncRename ",                                      desc = "Rename" },

    -- Diagnostics in Trouble
    { "<leader>cd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Show document issues" },
    { "<leader>cD", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Show workspace issues" },

    -- typescript-tool
    {
      "<leader>co",
      function()
        local foundApi = false
        for _, client in ipairs(vim.lsp.get_clients()) do
          local lspName = client.name
          if lspName:match('typescript-tools') then
            require("typescript-tools.api").organize_imports()
            foundApi = true
          end
        end
        if not foundApi then
          vim.notify("No matching LSP client API for organize imports", vim.log.levels.INFO)
        end
      end,
      desc = "Organize imports"
    },
    {
      "<leader>gs",
      function()
        local foundApi = false
        for _, client in ipairs(vim.lsp.get_clients()) do
          local lspName = client.name
          if lspName:match('typescript-tools') then
            require("typescript-tools.api").go_to_source_definition()
            foundApi = true
          end
        end
        if not foundApi then
          vim.notify("No matching LSP client API for source definition", vim.log.levels.INFO)
        end
      end,
      desc = "Go to source"
    },
  },

  { "<leader>g",  group = "LSP" },
  -- LSP
  { "<leader>gd", "<Cmd>Trouble lsp_definitions toggle focus=true<CR>",     desc = "Go to definition" },
  { "<leader>gt", "<Cmd>Trouble lsp_type_definitions toggle<CR>",           desc = "Go to type definition" },
  { "<leader>gi", "<Cmd>Trouble lsp_implementations toggle focus=true<CR>", desc = "Go to implementation" },
  { "<leader>gr", "<Cmd>Trouble lsp_references toggle focus=true<CR>",      desc = "Go to reference" },
  { "<leader>gD", vim.lsp.buf.declaration,                                  desc = "Go to declaration" },

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
      desc = "Clear Harpoon",
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
        local tmux_session = "mediahub" -- session that we can run this function
        local handle = io.popen("tmux display-message -p '#S'")
        if handle then
          local current_session = handle:read("*a")
          handle:close()

          -- Remove any trailing newline character from the session name
          current_session = current_session:gsub("\n", "")

          -- Check if the current session matches the desired session
          if current_session ~= tmux_session then
            vim.notify("Current session is not " .. tmux_session, vim.log.levels.ERROR)
            return
          end

          local tmux_panel_id = "2.1"
          local reload_command = "tmux send-keys -t " .. tmux_panel_id .. " r"
          if os.execute(reload_command) then
            vim.notify("Emulator reloaded", vim.log.levels.INFO)
          end
        end
      end,
      desc = "Reload emulator",
    },
  },
})
