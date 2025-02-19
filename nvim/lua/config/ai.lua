local wk = require("which-key")
local avante = require("avante.api")

wk.add({
  { "<leader>a",  group = "Avante" },
  { "<leader>aa", function() avante.ask() end,                      desc = "Avante: ask",               mode = { "n", "v" } },
  { "<leader>ar", function() avante.refresh() end,                  desc = "Avante: refresh",           mode = "n" },
  { "<leader>af", function() avante.focus() end,                    desc = "Avante: focus",             mode = "n" },
  { "<leader>ae", function() avante.edit() end,                     desc = "Avante: edit",              mode = "v" },
  -- Toggle
  { "<leader>at", function() avante.toggle() end,                   desc = "Avante: toggle chat",       mode = "n" },
  { "<leader>ad", function() avante.toggle.debug() end,             desc = "Avante: toggle debug",      mode = "n" },
  { "<leader>ah", function() avante.toggle.hint() end,              desc = "Avante: toggle hint",       mode = "n" },
  { "<leader>as", function() avante.toggle.suggestion() end,        desc = "Avante: toggle suggestion", mode = "n" },
  { "<leader>aR", function() require("avante.repo_map").show() end, desc = "Avante: toggle Repo map",   mode = "n" },
})
