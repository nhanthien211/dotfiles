-------------------------------------------------------------------------------------------------------------------

-- change lsp icons
local lsp_icons = require("config.icons").diagnostics
local symbols = { Error = lsp_icons.error, Info = lsp_icons.info, Hint = lsp_icons.hint, Warn = lsp_icons.warn }

for name, icon in pairs(symbols) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------

-- Change prefix character
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
})

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------

-- disable inline diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
})

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------

-- Change compeletion icons
local completion_icons = require("config.icons").lsp_completions
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = completion_icons[kind] or kind
end

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------

-- LSP and CMP integration
local lspToMasonMap = {
	lua_ls = "lua-language-server",
	html = "html",
	cssls = "css",
	jsonls = "json",
	tsserver = "typescript-language-server",
	eslint = "eslint_ls",
	yamlls = "yaml_ls",
}

local serverConfigs = {}
for lspName, _ in pairs(lspToMasonMap) do
	serverConfigs[lspName] = {}
end

serverConfigs.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
				globals = { "vim" }, -- when contributing to nvim plugins missing a `.luarc.json`
				disable = { "trailing-space" }, -- formatter already does that
			},
    }
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")

-- This is to enable nvim-ufo

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

for lsp, serverConfig in pairs(serverConfigs) do
  serverConfig.capabilities = capabilities
  lspconfig[lsp].setup(serverConfig)
end

-------------------------------------------------------------------------------------------------------------------
