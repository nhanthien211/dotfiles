return {
	{
		"nvim-telescope/telescope.nvim",
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

			require("telescope").setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
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
