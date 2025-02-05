-- NOTE: this contains unused / removed plugins
--but we may revert in the future as they are still great ons

return {
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   tag = "0.1.5",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --     },
  --     {
  --       "dimaportenko/telescope-simulators.nvim",
  --     },
  --   },
  --   config = function()
  --     local telescope = require("telescope")
  --     telescope.load_extension("fzf")
  --     telescope.load_extension("yank_history")
  --
  --     local telescopeConfig = require("telescope.config")
  --
  --     local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }
  --     table.insert(vimgrep_arguments, "--hidden")
  --     table.insert(vimgrep_arguments, "--glob")
  --     table.insert(vimgrep_arguments, "!**/.git/*")
  --
  --     local actions = require("telescope.actions")
  --     telescope.setup({
  --       pickers = {
  --         colorscheme = {
  --           enable_preview = true,
  --         },
  --         find_files = {
  --           find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
  --         },
  --       },
  --       defaults = {
  --         -- wrap_results = true,
  --         vimgrep_arguments = vimgrep_arguments,
  --         appings = {
  --           i = {
  --             ["<esc>"] = actions.close,
  --           },
  --         },
  --       },
  --     })
  --
  --     require("simulators").setup({
  --       android_emulator = true,
  --       apple_simulator = true,
  --     })
  --   end,
  -- },
  --
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   -- event = "VeryLazy",
  --   -- lazy = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     local git_icons = require("config.icons").git
  --     require("neo-tree").setup({
  --       enable_diagnostics = false,
  --       default_component_configs = {
  --         git_status = {
  --           symbols = {
  --             -- Change type
  --             added = git_icons.added,
  --             deleted = git_icons.removed,
  --             modified = git_icons.modified,
  --             renamed = git_icons.removed,
  --             -- Status type
  --             untracked = git_icons.untracked,
  --             ignored = git_icons.ignored,
  --             unstaged = git_icons.unstaged,
  --             staged = git_icons.staged,
  --             conflict = git_icons.conflict,
  --           },
  --         },
  --       },
  --
  --       filesystem = {
  --         follow_current_file = {
  --           enabled = true,
  --         },
  --         filtered_items = {
  --           visible = true,
  --           hide_dotfiles = false,
  --           hide_gitignored = true,
  --           hide_by_name = {
  --             ".gitignore",
  --             "package-lock.json",
  --             "yarn-lock.json",
  --           },
  --           never_show = {
  --             ".git",
  --             ".DS_Store",
  --             "thumbs.db",
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- }
  --
  -- {
  --   "akinsho/bufferline.nvim",
  --   enabled = false,
  --   version = "*",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("bufferline").setup({
  --       options = {
  --         enforce_regular_tabs = false,
  --         middle_mouse_command = function(bufnum)
  --           Snacks.bufdelete(bufnum)
  --         end,
  --
  --         close_command = function(bufnum)
  --           Snacks.bufdelete(bufnum)
  --         end,
  --         separator_style = "thin",
  --         hover = {
  --           enabled = true,
  --           delay = 200,
  --           reveal = { "close" },
  --         },
  --         offsets = {
  --           {
  --             filetype = "snacks_layout_box",
  --             text = "File explorer",
  --             highlight = "Directory",
  --             text_align = "center",
  --             separator = true,
  --           },
  --         },
  --       },
  --
  --       highlights = require("catppuccin.groups.integrations.bufferline").get({
  --         custom = {
  --           all = {
  --             fill = { bug = "#000000" },
  --           },
  --         },
  --       }),
  --     })
  --   end,
  -- }
}
