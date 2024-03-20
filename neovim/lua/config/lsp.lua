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

-- Change compeletion icons
local completion_icons = require("config.icons").lsp_completions
local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = completion_icons[kind] or kind
end

-- TODO: move to keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
