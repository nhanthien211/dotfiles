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
		w = {
			function()
				local conf = require("telescope.config").values
				require("telescope.builtin").live_grep({
					vimgrep_arguments = table.insert(conf.vimgrep_arguments, "--fixed-strings"),
				})
			end,
			"Find word (Live grep)",
		},
		c = { "<Cmd>Telescope colorscheme<CR>", "Find theme" },
		r = { "<Cmd>Telescope lsp_references<CR>", "Find reference" },
		i = { "<Cmd>Telescope diagnostics<CR>", "Find code diagnostics" },

		-- Telescope plugins
		n = { "<Cmd>Noice telescope<CR>", "Find Noice message" },
		t = { "<Cmd>TodoTelescope<CR>", "Find todo" },
		h = {
			function()
				-- basic telescope configuration
				local harpoon = require("harpoon")
				local conf = require("telescope.config").values
				local function toggle_telescope(harpoon_files)
					local file_paths = {}
					for _, item in ipairs(harpoon_files.items) do
						table.insert(file_paths, item.value)
					end

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end
				toggle_telescope(harpoon:list())
			end,
			"Find Harpoon list",
		},
		l = { "<Cmd>Telescope resume<CR>", "Last Telescope session" },
	},
}

wk.register(mappings, opts)
