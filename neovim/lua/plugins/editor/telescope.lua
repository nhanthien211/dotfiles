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
			require("telescope").load_extension("fzf")
			local actions = require("telescope.actions")
			require("telescope").setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
				},
			})
		end,
	},

	-- telescope for vim.ui.select
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
