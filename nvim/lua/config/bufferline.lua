local wk = require("which-key")
local Snacks = require('snacks')
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
    group = "Bufferline",
    desc = "Close buffer",
  },
  { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", group = "Bufferline", desc = "Go to tab 1" },
  { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", group = "Bufferline", desc = "Go to tab 2" },
  { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", group = "Bufferline", desc = "Go to tab 3" },
  { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", group = "Bufferline", desc = "Go to tab 4" },
  { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", group = "Bufferline", desc = "Go to tab 5" },
  { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", group = "Bufferline", desc = "Go to tab 6" },
  { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", group = "Bufferline", desc = "Go to tab 7" },
  { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", group = "Bufferline", desc = "Go to tab 8" },
  { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", group = "Bufferline", desc = "Go to tab 9" },
  { "<Tab>",     "<Cmd>BufferLineCycleNext<CR>",    desc = "Next tab" },
  { "<S-Tab>",   "<Cmd>BufferLineCyclePrev<CR>",    desc = "Previous tab" },
})
