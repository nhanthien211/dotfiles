return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			linters_by_ft = {
				-- javascript = { "eslint" },
				-- typescript = { "eslint" },
				-- javascriptreact = { "eslint" },
				-- typescriptreact = { "eslint" },
				yaml = { "yamllint" },
			},
			-- linters = {
			-- 	eslint = {
			-- 		args = {
			-- 			"--no-warn-ignored", -- <-- this is the key argument
			-- 			"--format",
			-- 			"json",
			-- 			"--stdin",
			-- 			"--stdin-filename",
			-- 			function()
			-- 				return vim.api.nvim_buf_get_name(0)
			-- 			end,
			-- 		},
			-- 	},
			-- },
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft
		end,
	},
}
