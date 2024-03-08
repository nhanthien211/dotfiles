return {
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},

				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			-- key binding to trigger format
			vim.keymap.set({ "n", "v" }, "<C-S-F>", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})

				vim.notify("Formatted", "info", {
					title = "conform.nvim",
				})
			end, { desc = "Format file or selected range" })
		end,
	},
}
