return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({
				fix_pairs = true,
			})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
		end,
	},
}
