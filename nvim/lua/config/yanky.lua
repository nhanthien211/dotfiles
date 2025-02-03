local wk = require("which-key")

wk.add({
  {
    "<C-p>", "<ESC><cmd>YankyRingHistory<CR>", desc = "Show clipboard history", mode = { "n", "i" },
  },
  {
    "=p", "<Plug>(YankyPutAfterFilterJoined)", desc = "Put after", mode = { "n", "x" }
  },
  {
    "=P", "<Plug>(YankyPutBeforeFilterJoined)", desc = "Put before", mode = { "n", "x" }
  }
})
