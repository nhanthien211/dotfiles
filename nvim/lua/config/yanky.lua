local wk = require("which-key")

wk.add({
  { "<C-p>", "<ESC><cmd>YankyRingHistory<CR>",     desc = "Show clipboard history", mode = { "n", "i", "v" } },
  { "=p",    "<Plug>(YankyPutAfterFilterJoined)",  desc = "Put after",              mode = { "n", "x" } },
  { "=P",    "<Plug>(YankyPutBeforeFilterJoined)", desc = "Put before",             mode = { "n", "x" } }
})
