return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		local git_icons = require("config.icons").git
		require("neo-tree").setup({
			default_component_configs = {
				git_status = {
					symbols = {
						-- Change type
						added = git_icons.added,
						deleted = git_icons.removed,
						modified = git_icons.modified,
						renamed = git_icons.removed,
						-- Status type
						untracked = git_icons.untracked,
						ignored = git_icons.ignored,
						unstaged = git_icons.unstaged,
						staged = git_icons.staged,
						conflict = git_icons.conflict,
					},
				},
			},

			filesystem = {
				follow_current_file = {
					enabled = true,
				},
			},
		})
	end,
}
