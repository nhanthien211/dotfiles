return {
  -- Plugin for tab ui
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          enforce_regular_tabs = false,
          middle_mouse_command = function(bufnum)
            Snacks.bufdelete(bufnum)
          end,

          close_command = function(bufnum)
            Snacks.bufdelete(bufnum)
          end,
          separator_style = "thin",
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          offsets = {
            {
              filetype = "snacks_layout_box",
              text = function()
                return nil
              end,
              -- highlight = "Directory",
              text_align = "center",
              separator = true,
            },
          },
          -- ENABLE TO HAVE LSP DIAGNOSTICS ON TAB
          -- diagnostics = "nvim_lsp",
          -- diagnostics_update_in_insert = false,
          -- diagnostics_indicator = function(_, _, diagnostics_dict)
          -- 	local icons = require("config.icons").diagnostics
          -- 	local s = ""
          -- 	for e, n in pairs(diagnostics_dict) do
          -- 		local sym = e == "error" and icons.error or (e == "warning" and icons.warning or icons.hint)
          -- 		s = s .. n .. " " .. sym
          -- 	end
          -- 	return s
          -- end,
        },

        highlights = require("catppuccin.groups.integrations.bufferline").get({
          custom = {
            all = {
              fill = { bug = "#000000" },
            },
          },
        }),
      })
    end,
  },
}
