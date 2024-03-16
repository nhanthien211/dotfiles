local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

local mappings = {
	b = {
		name = "bufferline",
		p = { "<Cmd>BufferLineTogglePin<CR>", "Toggle tab pin" },
		c = {
			name = "bufferline delete",
			o = { "<Cmd>BufferLineCloseOthers<CR>", "Close other tab" },
			r = { "<Cmd>BufferLineCloseRight<CR>", "Close right tab" },
			l = { "<Cmd>BufferLineCloseLeft<CR>", "Close left tab" },
		},
	},
	["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Go to tab 1" },
	["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Go to tab 2" },
	["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Go to tab 3" },
	["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Go to tab 4" },
	["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Go to tab 5" },
	["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Go to tab 6" },
	["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Go to tab 7" },
	["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Go to tab 8" },
	["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Go to tab 9" },
	-- ["<Tab>"] = { "<Cmd>BufferLineCycleNext<CR>", "Next tab" },
	-- ["<S-Tab>"] = { "<Cmd>BufferLineCyclePrev<CR>", "Previous tab" },
}

wk.register(mappings, opts)
