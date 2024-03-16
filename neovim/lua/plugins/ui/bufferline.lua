return {
	-- Plugin for tab ui
	{
		"akinsho/bufferline.nvim",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"famiu/bufdelete.nvim",
		},
		opts = {
			options = {
				enforce_regular_tabs = false,
				middle_mouse_command = function(bufnum)
					require("bufdelete").bufdelete(bufnum, true)
				end,

				close_command = function(bufnum)
					require("bufdelete").bufdelete(bufnum, true)
				end,
				separator_style = "thin",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
						separator = true,
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(_, _, diagnostics_dict)
					local icons = require("config").icons.diagnostics
					local s = ""
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and icons.error or (e == "warning" and icons.warning or icons.hint)
						s = s .. n .. " " .. sym
					end
					return s
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
}
