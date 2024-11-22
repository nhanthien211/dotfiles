local wk = require("which-key")

wk.add({
  {
    "<C-c>",
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    desc = "Toggle comment",
    mode = { "n", "i" },
  },
  {
    "<C-c>",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    desc = "Toggle block comment",
    mode = "v",
  },
})
