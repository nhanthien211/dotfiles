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
		n = { ":Noice telescope", "View Noice message" },
		t = { ":TodoTelescope", "View todo" },
	},
}

wk.register(mappings, opts)
