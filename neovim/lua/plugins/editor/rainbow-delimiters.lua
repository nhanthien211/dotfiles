return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("rainbow-delimiters.setup").setup()
		end,
	},
}
