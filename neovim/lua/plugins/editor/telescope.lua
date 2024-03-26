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

			local telescopeConfig = require("telescope.config")

			local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }
			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			local actions = require("telescope.actions")
			telescope.setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				defaults = {
					wrap_results = true,
					vimgrep_arguments = vimgrep_arguments,
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
