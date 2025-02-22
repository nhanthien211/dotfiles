-------------------------------------------------------------------------------------------------------------------

-- change lsp icons
local lsp_icons = require("config.icons").diagnostics
local symbols = { Error = lsp_icons.error, Info = lsp_icons.info, Hint = lsp_icons.hint, Warn = lsp_icons.warn }

for name, icon in pairs(symbols) do
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-------------------------------------------------------------------------------------------------------------------
-- Change prefix character
vim.diagnostic.config({
  virtual_text = false,
  float = { border = 'rounded' },
  update_in_insert = false,
})

-------------------------------------------------------------------------------------------------------------------
-- Change compeletion icons
local completion_icons = require("config.icons").lsp_completions
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = completion_icons[kind] or kind
end

-------------------------------------------------------------------------------------------------------------------
-- LSP and CMP integration
local lspToMasonMap = {
  lua_ls = "lua-language-server",
  yamlls = "yaml-language-server",
  ["typescript-tools"] = "typescript-language-server",
}

local serverConfigs = {}
for lspName, _ in pairs(lspToMasonMap) do
  serverConfigs[lspName] = {}
end

serverConfigs.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },            -- when contributing to nvim plugins missing a `.luarc.json`
        disable = { "trailing-space" }, -- formatter already does that
      },
    },
  },
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- This is to enable nvim-ufo use LSP
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- LSP handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false
  })
}

local on_attach = function(client)
  local client_name = client.name
  if client_name:match('lua') then
    return
  end

  if client_name:match('typescript') or client_name:match('ts') then
    -- for typescript, we want to use prettierd
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

local lspconfig = require("lspconfig")
for lsp, serverConfig in pairs(serverConfigs) do
  serverConfig.capabilities = capabilities
  serverConfig.handlers = handlers
  serverConfig.on_attach = on_attach
  lspconfig[lsp].setup(serverConfig)
end
