-- change lsp icons
local lsp_icons = require("config.icons").diagnostics
local symbols = { Error = lsp_icons.error, Info = lsp_icons.info, Hint = lsp_icons.hint, Warn = lsp_icons.warn }

for name, icon in pairs(symbols) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

-- Change prefix character
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
})

-- disable inline diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- Change compeletion icons
local completion_icons = require("config.icons").lsp_completions
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = completion_icons[kind] or kind
end

-- TODO: move all client_capabilities to separate config
-- config = function()
		-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- 	capabilities.textDocument.foldingRange = {
		-- 		dynamicRegistration = false,
		-- 		lineFoldingOnly = true,
		-- 	}
		-- 	local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
		-- 	for _, ls in ipairs(language_servers) do
		-- 		require("lspconfig")[ls].setup({
		-- 			capabilities = capabilities,
		-- 			-- you can add other fields for setting up lsp server in this table
		-- 		})
		-- 	end
		-- 	require("ufo").setup()
		-- end,


-- TODO: move to keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
