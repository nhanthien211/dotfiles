local wk = require('which-key')
local avante = require("avante.api")

-- NOTE: Picker key map
wk.add({
  { "<leader>f",  group = "Find" },
  -- Search
  { "<leader>ff", function() Snacks.picker.files() end,                desc = "Find Files", },
  { "<leader>fc", function() Snacks.picker.colorschemes() end,         desc = "Find Theme" },
  { "<leader>fw", function() Snacks.picker.grep() end,                 desc = "Find Words" },
  { "<leader>fW", function() Snacks.picker.grep_word() end,            desc = "Find Current word",   mode = { "n", "v" } },
  { "<leader>fi", function() Snacks.picker.diagnostics() end,          desc = "Find Diagnostics" },
  { "<leader>fk", function() Snacks.picker.keymaps() end,              desc = "Find Keymaps" },
  { "<leader>fl", function() Snacks.picker.resume() end,               desc = "Find Last" },
  { "<leader>fp", function() Snacks.picker.projects() end,             desc = "Find Projects" },
  { "<leader>ft", function() Snacks.picker.todo_comments() end,        desc = "Find Comment tag" },
  { "<leader>fb", function() Snacks.picker.buffers() end,              desc = "Find Buffer" },

  -- LSP
  { "<leader>fd", function() Snacks.picker.lsp_definitions() end,      desc = "Find Definition" },
  { "<leader>fD", function() Snacks.picker.lsp_declarations() end,     desc = "Find Declaration" },
  { "<leader>fr", function() Snacks.picker.lsp_references() end,       desc = "Find References",     nowait = true, },
  { "<leader>fI", function() Snacks.picker.lsp_implementations() end,  desc = "Find Implementation" },
  { "<leader>fy", function() Snacks.picker.lsp_type_definitions() end, desc = "Find Type Definition" },

  -- INFO: Deprecated, currently using arrow instead
  -- Harpoon
  -- {
  --   "<leader>fh",
  --   function()
  --     local harpoon = require("harpoon")
  --
  --     Snacks.picker.files({
  --       title   = 'Harpoon',
  --       actions = {
  --         remove_from_harpoon = function(picker)
  --           local items = picker:selected({ fallback = true })
  --           Snacks.picker.select(
  --             { "Yes", "No" },
  --             { prompt = "Remove from Harpoon?" },
  --             function(_, idx)
  --               if idx == 1 then
  --                 for _, item in ipairs(items) do
  --                   harpoon:list():remove_at(item.idx)
  --                 end
  --                 picker:find()
  --               end
  --             end)
  --         end
  --       },
  --       win     = {
  --         input = {
  --           keys = {
  --             ["<C-d>"] = { "remove_from_harpoon", mode = { "i", "n" }, desc = "Remove item from Harpoon" }
  --           }
  --         }
  --       },
  --       finder  = function()
  --         local items = {}
  --         for _, item in ipairs(harpoon:list().items) do
  --           items[#items + 1] = {
  --             file = item.value,
  --             text = item.value,
  --           }
  --         end
  --         return items
  --       end,
  --     })
  --   end,
  --   desc = "Find Harpoon list",
  -- }
})

-- NOTE: Notifier key map
wk.add({
  { "<leader>n",  group = "Notification" },
  { "<leader>ns", function() Snacks.notifier.show_history() end, desc = "Show notification history" },
  { "<leader>nh", function() Snacks.notifier.hide() end,         desc = "Dismiss all notifcations" },
})

-- NOTE: Explorer
wk.add({
  { "<c-e>", function() Snacks.picker.explorer() end, desc = "Open file explorer" }
})

-- NOTE: Toggle key map
-----------------Toggle LSP diagnostic helper functions--------------------------------------------------------
local ignore_events = false
wk.add({
  { "<leader>t", group = "Toggle" }
})
function ToggleLspDiagnostic()
  -- Additional check to remove highlight / floating windows
  if ignore_events then
    -- Set eventignore to empty, not ignoring any events
    vim.opt.eventignore = ""
    vim.diagnostic.config({
      underline = true,
    })
    ignore_events = false
  else
    -- Close all floating windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        vim.api.nvim_win_close(win, true)
      end
    end
    vim.diagnostic.config({
      underline = false,
    })

    -- Set eventignore to ignore CursorHold and CursorHoldI events
    vim.opt.eventignore = "CursorHold,CursorHoldI"
    ignore_events = true
  end
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

Snacks.toggle.words():map("<leader>tw")
Snacks.toggle.inlay_hints():map("<leader>th")
-- Dignostics
Snacks.toggle({
  name = "code diagnostics",
  get = function()
    return vim.diagnostic.is_enabled()
  end,
  set = function()
    ToggleLspDiagnostic()
  end
}):map("<leader>td")
-- Git
Snacks.toggle({
  name = "git line blame",
  get = function()
    return require("gitsigns.config").config.current_line_blame
  end,
  set = function()
    require("gitsigns").toggle_current_line_blame()
  end
}):map("<leader>tb")
Snacks.toggle({
  name = "relative line number",
  get = function()
    return vim.wo.relativenumber
  end,
  set = function()
    vim.wo.relativenumber = not vim.wo.relativenumber
  end
}):map("<leader>tl")

-- NOTE: Input
wk.add({
  {
    "<C-g>",
    function()
      Snacks.input.input({ prompt = "Go to line: " }, function(value)
        local line_number = tonumber(value)
        if line_number then
          vim.api.nvim_feedkeys(line_number .. 'G', 'n', false)
        end
      end)
    end,
    desc = "Go to line: "
  }
})

-- NOTE: Buffers
wk.add({
  {
    "<leader>w",
    function()
      Snacks.bufdelete(0)
    end,
    desc = "Close buffer",
    hidden = true
  },
})
