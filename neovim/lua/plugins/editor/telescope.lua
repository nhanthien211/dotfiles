return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = "VeryLazy",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")

			local actions = require("telescope.actions")
			telescope.setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					wrap_results = true,
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
			})
		end,
	},
}
