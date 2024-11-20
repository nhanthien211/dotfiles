return {
	--Noice.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				presets = {
					inc_rename = true,
				},
			})
		end,
	},

	--Notify.nvim
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			background_colour = "#00000",
			timeout = 2000,
			max_height = function()
				return math.floor(vim.o.lines * 0.4)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.4)
			end,
      stages = "fade"  
    },
		config = function(_, opts)
			require("notify").setup(opts)
		end,
	},
}
