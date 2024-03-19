local map = vim.keymap.set
local silent = { silent = true }

-- traditional save
map("n", "<C-s>", ":w<CR>", silent)
map("i", "<C-s>", "<ESC>:w<CR>a", silent)

-- Notify
map({ "n", "v" }, "<leader>un", function()
	require("notify").dismiss(silent)
end, { desc = "Dimiss all notifcation" })

-- neotree
map("n", "<c-e>", "<cmd>Neotree toggle<cr>", { desc = "toggle file explorer" })
