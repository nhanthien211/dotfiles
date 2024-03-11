local map = vim.keymap.set
local silent = { silent = true }

-- traditional save
map("n", "<C-s>", ":w<CR>", silent)
map("i", "<C-s>", "<ESC>:w<CR>a", silent)

-- comment
map("i", "<c-/>", function()
	require("Comment.api").toggle.linewise.current()
end, { remap = true, desc = "Comment toggle" })

map(
	"v",
	"<c-/>",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ remap = true, desc = "Comment Toggle" }
)

-- telescope
local telescope_builtin = require("telescope.builtin")
map("n", "<leader>ff", telescope_builtin.find_files, { desc = "find files" })
map("n", "<leader>fw", telescope_builtin.live_grep, { desc = "live grep" })
map("n", "<leader>fc", telescope_builtin.colorscheme, { desc = "change theme" })

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
