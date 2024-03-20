local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

-- TODO: move to keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})

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

		-- Rename
		r = { ":IncRename ", "Rename" },

    -- Trouble
    t = { "<cmd>TroubleToggle<cr>", "Toggle issues" },
	},
	l = { "<Cmd>Lazy<CR>", "Display LazyVim" },
	m = { "<Cmd>Mason<CR>", "Display Mason" },
}

wk.register(mappings, opts)
