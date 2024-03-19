local wk = require("which-key")

local opts = {
	mode = { "n", "v" },
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
				})

				vim.notify("Formatted", "info", {
					title = "conform.nvim",
				})
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
		a = {
			vim.lsp.buf.code_action,
			"Code action",
		},
		c = {
			vim.lsp.codelens.run,
			"Run code lense",
		},
		C = {
			vim.lsp.codelens.refresh,
			"Refresh and run code lense",
		},
	},
	l = { "<Cmd>Lazy<CR>", "Display LazyVim" },
	m = { "<Cmd>Mason<CR>", "Display Mason" },
}

wk.register(mappings, opts)
