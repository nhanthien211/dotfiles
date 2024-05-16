-- This is to enable float border
local border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

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
	virtual_text = false,
	float = { border = border },
	update_in_insert = false,
})

-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------

-- disable inline diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	update_in_insert = false,
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
	["typescript-tools"] = "typescript-language-server",
	-- eslint = "eslint_lsp",
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
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")

-- This is to enable nvim-ufo

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		update_in_insert = false,
	}),
}

for lsp, serverConfig in pairs(serverConfigs) do
	serverConfig.capabilities = capabilities
	serverConfig.handlers = handlers
	lspconfig[lsp].setup(serverConfig)
end

-----------------Toggle LSP diagnostic helper functions--------------------------------------------------------

local ignore_events = false

function ToggleLspDiagnostic()
	if ignore_events then
		-- Set eventignore to empty, not ignoring any events
		vim.opt.eventignore = ""
		vim.diagnostic.config({
			underline = true,
		})
		ignore_events = false
		vim.notify("Enable diagnostic", "info", {
			title = "LSP Diagnostic",
		})
	else
		-- Close all floating windows
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				vim.api.nvim_win_close(win, true)
			end
		end
		vim.diagnostic.config({
			underline = false,
		})

		-- Set eventignore to ignore CursorHold and CursorHoldI events
		vim.opt.eventignore = "CursorHold,CursorHoldI"
		ignore_events = true
		vim.notify("Disable diagnostic", "info", {
			title = "LSP Diagnostic",
		})
	end
end

-------------------------------------------------------------------------------------------------------------------
