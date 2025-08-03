local M = {}
local wk = require("which-key")

-- Code actions module
M.setup_code_actions = function()
  wk.add({
    {
      "<leader>c",
      group = "Code action",
      {
        "<leader>cf",
        function()
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500,
          }, function()
            vim.notify("Formatted", vim.log.levels.INFO, { title = "Conform" })
          end)
        end,
        desc = "Code format",
      },
      {
        "<leader>cl",
        function()
          require("lint").try_lint()
          local linters = require("lint").get_running()
          vim.notify("Run linting", vim.log.levels.INFO, { title = table.concat(linters, ", ") })
        end,
        desc = "Code linting",
      },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "Code action" },
      { "<leader>cc", vim.lsp.codelens.run,       desc = "Run code lense" },
      { "<leader>cC", vim.lsp.codelens.refresh,   desc = "Refresh and run code lense" },
      { "<leader>ch", vim.lsp.buf.hover,          desc = "Hover" },
      { "<leader>cs", vim.lsp.buf.signature_help, desc = "Signature help" },
      { "<leader>cr", vim.lsp.buf.rename,         desc = "Rename" },
    },
  })
end

-- TypeScript specific actions
M.setup_typescript_actions = function()
  local function get_typescript_client()
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == "typescript-tools" then
        return client
      end
    end
    return nil
  end

  wk.add({
    {
      "<leader>co",
      function()
        local client = get_typescript_client()
        if client then
          require("typescript-tools.api").organize_imports()
        end
      end,
      desc = "Organize imports"
    },
    {
      "<leader>gs",
      function()
        local client = get_typescript_client()
        if client then
          require("typescript-tools.api").go_to_source_definition()
        end
      end,
      desc = "Go to source"
    },
  })
end

-- Trouble/LSP navigation
M.setup_trouble = function()
  wk.add({
    { "<leader>g",  group = "Trouble" },
    { "<leader>gd", "<Cmd>Trouble lsp_definitions toggle<CR>",          desc = "Show definition" },
    { "<leader>gt", "<Cmd>Trouble lsp_type_definitions toggle<CR>",     desc = "Show type definition" },
    { "<leader>gi", "<Cmd>Trouble lsp_implementations toggle<CR>",      desc = "Show implementation" },
    { "<leader>gr", "<Cmd>Trouble lsp_references toggle<CR>",           desc = "Show reference" },
    { "<leader>gD", "<Cmd>Trouble lsp_declarations toggle<CR>",         desc = "Show declaration" },
    { "<leader>cd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Show document issues" },
    { "<leader>cD", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Show workspace issues" },
  })
end

-- Utility commands
M.setup_utilities = function()
  wk.add({
    { "<leader>l", "<Cmd>Lazy<CR>",  desc = "Display LazyVim" },
    { "<leader>m", "<Cmd>Mason<CR>", desc = "Display Mason" },
    {
      "<leader>r",
      group = "Reload",
      { "<leader>rl", "<Cmd>LspRestart<CR>", desc = "Reload LSP" },
      {
        "<leader>rs",
        function()
          require('lualine').refresh()
        end,
        desc = "Reload Statusline"
      },
      {
        "<leader>re",
        function()
          local tmux_session = "mediahub"
          local handle = io.popen("tmux display-message -p '#S'")
          if handle then
            local current_session = handle:read("*a"):gsub("\n", "")
            handle:close()

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
end

-- Main setup
M.setup = function()
  M.setup_code_actions()
  M.setup_typescript_actions()
  M.setup_trouble()
  M.setup_utilities()
end

M.setup()

return M
