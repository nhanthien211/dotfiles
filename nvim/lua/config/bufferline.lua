local wk = require("which-key")
wk.add({
  {
    "<leader>b",
    group = "Bufferline",
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",   desc = "Toggle tab pin" },
    {
      "<leader>bc",
      function()
        Snacks.bufdelete(0)
      end,
      desc = "Close buffer",
    },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other tab" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",  desc = "Close right tab" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",   desc = "Close left tab" },
  },
  {
    "<leader>w",
    function()
      Snacks.bufdelete(0)
    end,
    desc = "Close buffer",
    hidden = true
  },
  { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", group = "Bufferline", desc = "Go to tab 1", hidden = true },
  { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", group = "Bufferline", desc = "Go to tab 2", hidden = true },
  { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", group = "Bufferline", desc = "Go to tab 3", hidden = true },
  { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", group = "Bufferline", desc = "Go to tab 4", hidden = true },
  { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", group = "Bufferline", desc = "Go to tab 5", hidden = true },
  { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", group = "Bufferline", desc = "Go to tab 6", hidden = true },
  { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", group = "Bufferline", desc = "Go to tab 7", hidden = true },
  { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", group = "Bufferline", desc = "Go to tab 8", hidden = true },
  { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", group = "Bufferline", desc = "Go to tab 9", hidden = true },
  { "<Tab>",     "<Cmd>BufferLineCycleNext<CR>",    desc = "Next tab" },
  { "<S-Tab>",   "<Cmd>BufferLineCyclePrev<CR>",    desc = "Previous tab" },
})
