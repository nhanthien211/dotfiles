local M = {}

M.setup_diagnostic_icons = function()
  local lsp_icons = require("config.icons").diagnostics

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = lsp_icons.error,
        [vim.diagnostic.severity.WARN] = lsp_icons.warn,
        [vim.diagnostic.severity.HINT] = lsp_icons.hint,
        [vim.diagnostic.severity.INFO] = lsp_icons.info,
      },
    },
    update_in_insert = false,
    virtual_lines = false,
    virtual_text = false,
    severity_sort = true,
    float = {
      focusable = false,
      prefix = " ",
      border = "rounded",
    },
  })
end

M.setup_completion_icons = function()
  local completion_icons = require("config.icons").lsp_completions
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = completion_icons[kind] or kind
  end
end

-- Enhanced capabilities with native 0.11 features
M.get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Native completion improvements in 0.11
  capabilities.textDocument.semanticTokens.multilineTokenSupport = true
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
  }

  -- Enhanced folding capabilities
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  -- Native inlay hints support
  capabilities.textDocument.inlayHint = {
    dynamicRegistration = false,
  }

  return capabilities
end

-- Enhanced on_attach with 0.11 features
M.on_attach = function(client, bufnr)
  local client_name = client.name

  -- Skip lua_ls specific setup to avoid conflicts
  if client_name:match('lua') then
    return
  end

  -- Disable formatting for TypeScript tools - use conform instead
  if client_name:match('typescript') or client_name:match('ts') then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Enable inlay hints if supported (native in 0.11)
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Setup buffer-local keymaps here if needed
  -- This is cleaner than global keymaps for LSP functions
end

-- Server configurations
M.get_server_configs = function()
  local configs = {
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            disable = { "trailing-space" },
          },
          hint = {
            enable = true, -- Enable native inlay hints
          },
        },
      },
    },
    yamlls = {},
    ["typescript-tools"] = {}, -- Will be configured by typescript-tools plugin
  }

  return configs
end

M.setup_lsp = function()
  local capabilities = M.get_capabilities()
  local server_configs = M.get_server_configs()

  local lspconfig = require("lspconfig")

  for server_name, config in pairs(server_configs) do
    -- Skip typescript-tools as it's handled by its plugin
    if server_name ~= "typescript-tools" then
      config.capabilities = capabilities
      config.on_attach = M.on_attach
      lspconfig[server_name].setup(config)
    end
  end
end

-- Main setup function
M.setup = function()
  M.setup_diagnostic_icons()
  M.setup_completion_icons()
  M.setup_lsp()
end

-- Initialize
M.setup()

return M
