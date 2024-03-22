local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

local mappings = {
	f = {
		name = "Toggle telescope",
		f = { "<Cmd>Telescope find_files<CR>", "Find files" },
		w = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
		c = { "<Cmd>Telescope colorscheme<CR>", "Change theme" },
		r = { "<Cmd>Telescope lsp_references<CR>", "View reference" },
		i = { "<Cmd>Telescope diagnostics<CR>", "View code diagnostics" },

		-- Telescope plugins
		n = { "<Cmd>Noice telescope<CR>", "View Noice message" },
		t = { "<Cmd>TodoTelescope<CR>", "View todo" },
	},
}

wk.register(mappings, opts)
