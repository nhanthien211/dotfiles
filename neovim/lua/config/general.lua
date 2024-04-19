local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

local mappings = {
	c = {
		name = "Code action",

		-- Conform.nvim
		f = {
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				}, function()
					vim.notify("Formatted", "info", {
						title = "conform.nvim",
					})
				end)
			end,
			"Code format",
		},

		-- Nvim-lint.nvim
		l = {
			function()
				require("lint").try_lint()
				vim.notify("Trigger linting", "info", {
					title = "nvim-lint",
				})
			end,
			"Code linting",
		},

		-- LSP related
		a = { vim.lsp.buf.code_action, "Code action" },
		c = { vim.lsp.codelens.run, "Run code lense" },
		C = { vim.lsp.codelens.refresh, "Refresh and run code lense" },
		h = { vim.lsp.buf.hover, "Hover" },
		s = { vim.lsp.buf.signature_help, "Signature help" },
		d = { "<Cmd>lua ToggleLspDiagnostic()<CR>", "Toggle diagnostic" },

		-- Rename
		r = { ":IncRename ", "Rename" },

		-- Trouble
		i = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle document issues" },
		I = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle document issues" },

		-- typescript-tool
		o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
	},
	g = {
		name = "LSP and Git",
		-- LSP
		d = { "<Cmd>TroubleToggle lsp_definitions<CR>", "Go to definition" },
		t = { "<Cmd>TroubleToggle lsp_type_definitions<CR>", "Go to type definition" },
		i = { "<Cmd>TroubleToggle lsp_implementations<CR>", "Go to implementation" },
		r = { "<Cmd>TroubleToggle lsp_references<CR>", "Go to reference" },
		s = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source" },
		D = { vim.lsp.buf.declaration, "Go to declaration" },

		-- Git
		b = { ":Gitsigns toggle_current_line_blame<CR>", "Git blame toggle" },
		p = { ":Gitsigns preview_hunk<CR>", "Git preview hunk" },
	},
	l = { "<Cmd>Lazy<CR>", "Display LazyVim" },
	m = { "<Cmd>Mason<CR>", "Display Mason" },
}

wk.register(mappings, opts)
