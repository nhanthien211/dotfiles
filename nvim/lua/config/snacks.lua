local wk = require('which-key')

-- Picker key map
wk.add({
  { "<leader>f",  group = "Find" },
  -- Search
  { "<leader>ff", function() Snacks.picker.files() end,                desc = "Find files", },
  { "<leader>fc", function() Snacks.picker.colorschemes() end,         desc = "Find theme" },
  { "<leader>fw", function() Snacks.picker.grep() end,                 desc = "Find words" },
  { "<leader>fW", function() Snacks.picker.grep_word() end,            desc = "Find current word",    mode = { "n", "v" } },
  { "<leader>fi", function() Snacks.picker.diagnostics() end,          desc = "Find diagnostics" },
  { "<leader>fk", function() Snacks.picker.keymaps() end,              desc = "Find keymaps" },
  { "<leader>fl", function() Snacks.picker.resume() end,               desc = "Find last" },
  { "<leader>fp", function() Snacks.picker.projects() end,             desc = "Find projects" },
  { "<leader>ft", function() Snacks.picker.todo_comments() end,        desc = "Find comment tag" },
  -- LSP
  { "<leader>fd", function() Snacks.picker.lsp_definitions() end,      desc = "Go to Definition" },
  { "<leader>fr", function() Snacks.picker.lsp_references() end,       desc = "Go to References",     nowait = true, },
  { "<leader>fI", function() Snacks.picker.lsp_implementations() end,  desc = "Go to Implementation" },
  { "<leader>fy", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
})

-- Notifier key map
wk.add({
  { "<leader>n",  group = "Notification" },
  { "<leader>ns", function() Snacks.notifier.show_history() end, desc = "Show notification history" },
  { "<leader>nh", function() Snacks.notifier.hide() end,         desc = "Dismiss all notifcations" },
})

-- Explorer
wk.add({
  { "<c-e>", function() Snacks.picker.explorer() end, desc = "Open file explorer" }
})

-- Toggle key map
Snacks.toggle.words():map("<leader>tw")
Snacks.toggle.inlay_hints():map("<leader>th")
Snacks.toggle({
  name = "Code diagnostics",
  get = function()
    return vim.diagnostic.is_enabled()
  end,
  set = function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end
}):map("<leader>td")
