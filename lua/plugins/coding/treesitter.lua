return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"html",
				"json",
				"markdown",
				"markdown_inline",
				"tsx",
				"typescript",
				"yaml",
				"css",
				"scss",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
