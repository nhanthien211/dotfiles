return {
	{
		"numToStr/Comment.nvim",
		lazy = true,
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
