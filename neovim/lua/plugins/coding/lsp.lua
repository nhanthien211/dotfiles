return {
	{
		"williamboman/mason.nvim",
		dependencies = {},
	  event = "VeryLazy",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- linter
					"eslint_d",
					"yamllint",
					-- formatter
					"prettierd",
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
	  event = "VeryLazy",
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"cssls",
					"jsonls",
					"tsserver",
					"eslint",
					"yamlls",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			--
			local lspconfig = require("lspconfig")

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})
			-- lspconfig.html.setup({
			--   capabilities = capabilities
			-- })
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})

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
		end,
	},

	{
		"smjonas/inc-rename.nvim",
    event = "VeryLazy",
		config = function()
			require("inc_rename").setup()
		end,
	},
}
