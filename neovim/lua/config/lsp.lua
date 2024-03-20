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
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")

-- This is to enable nvim-ufo

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local language_servers = require("lspconfig").util.available_servers()

for _, ls in ipairs(language_servers) do
	if ls == "lua_ls" then
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	else
		lspconfig[ls].setup({
			capabilities = capabilities,
		})
	end
end

-------------------------------------------------------------------------------------------------------------------
