local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

local mappings = {
	f = {
		name = "Telescope",
		f = { "<Cmd>Telescope find_files<CR>", "Find files" },
		w = { "<Cmd>Telescope live_grep<CR>", "Find word (Live grep)" },
		c = { "<Cmd>Telescope colorscheme<CR>", "Find theme" },
		r = { "<Cmd>Telescope lsp_references<CR>", "Find reference" },
		i = { "<Cmd>Telescope diagnostics<CR>", "Find code diagnostics" },

		-- Telescope plugins
		n = { "<Cmd>Noice telescope<CR>", "Find Noice message" },
		t = { "<Cmd>TodoTelescope<CR>", "Find todo" },
	},
}

wk.register(mappings, opts)
