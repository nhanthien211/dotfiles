local wk = require("which-key")

wk.add({
  {
    "<leader>f",
    group = "Telescope",
    { "<leader>ff", "<Cmd>Telescope find_files<CR>",     desc = "Find files" },
    {
      "<leader>fw",
      function()
        local conf = require("telescope.config").values
        require("telescope.builtin").live_grep({
          vimgrep_arguments = table.insert(conf.vimgrep_arguments, "--fixed-strings"),
        })
      end,
      desc = "Find word (Live grep)",
    },
    { "<leader>fc", "<Cmd>Telescope colorscheme<CR>",    desc = "Find theme" },
    { "<leader>fr", "<Cmd>Telescope lsp_references<CR>", desc = "Find reference" },
    { "<leader>fi", "<Cmd>Telescope diagnostics<CR>",    desc = "Find code diagnostics" },
    { "<leader>fe", "<Cmd>Telescope simulators run<CR>", desc = "Find simulators" },

    -- Telescope plugins
    { "<leader>fn", "<Cmd>Noice telescope<CR>",          desc = "Find Noice message" },
    { "<leader>ft", "<Cmd>TodoTelescope<CR>",            desc = "Find todo" },
    { "<leader>fy", "<Cmd>Telescope yank_history<CR>",   desc = "Find yank history" },
    {
      "<leader>fh",
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
      desc = "Find Harpoon list",
    },
    { "<leader>fl", "<Cmd>Telescope resume<CR>", desc = "Last Telescope session" },
  },
})
