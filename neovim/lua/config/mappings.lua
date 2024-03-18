local map = vim.keymap.set
local silent = { silent = true }

-- traditional save
map("n", "<C-s>", ":w<CR>", silent)
map("i", "<C-s>", "<ESC>:w<CR>a", silent)

-- Notify
map({ "n", "v" }, "<leader>un", function()
	require("notify").dismiss(silent)
end, { desc = "Dimiss all notifcation" })

-- linting
map("n", "<leader>l", function()
	require("lint").try_lint()
	vim.notify("Trigger linting", "info", {
		title = "nvim-lint",
	})
end, { desc = "Trigger linting for current file" })

-- neotree
map("n", "<c-e>", "<cmd>Neotree toggle<cr>", { desc = "toggle file explorer" })

-- formatting
map({ "n", "v", "i" }, "<C-S-F>", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})

	vim.notify("Formatted", "info", {
		title = "conform.nvim",
	})
end, { desc = "Format file or selected range" })
