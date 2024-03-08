return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>p", builtin.find_files, {})
		end,
	},

	-- telescope for vim.ui.select
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
