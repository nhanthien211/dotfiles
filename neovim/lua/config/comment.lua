local wk = require("which-key")

wk.register({
	["<C-c>"] = {
		function()
			require("Comment.api").toggle.linewise.current()
		end,
		"Toggle comment",
	},
}, {
	mode = { "n", "i" },
})

wk.register({
	["<C-c>"] = {
		"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		"Toggle block comment",
	},
}, {
	mode = "v",
})
