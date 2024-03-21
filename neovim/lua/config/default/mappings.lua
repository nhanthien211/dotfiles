local map = vim.keymap.set
local silent = { silent = true }

------TRADITIONAL KEYBINDING--------

map({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "i", "n" }, "<C-z>", "<cmd>u<cr>", { desc = "Undo" })
map({ "i", "n" }, "<C-r>", "<cmd>redo<cr>", { desc = "Redo" })
-- map({ "i", "n" }, "<C-d>", "<esc>yypi", { desc = "Duplicate line" })

-- Start new line from any cursor position in insert-mode
map("i", "<S-CR>", "<C-o>o", { desc = "Start Newline" })
map("n", "]<Leader>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { silent = true, desc = "Newline" })
map("n", "[<Leader>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { silent = true, desc = "Newline" })

-- Move line
map("n", "<S-j>", "<cmd>move-2<CR>==", { silent = true, desc = "Move line up" })
map("n", "<S-k>", "<cmd>move+<CR>==", { silent = true, desc = "Move line down" })

map("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Easy select text in edit mode
map("i", "<S-Up>", "<left><C-o>vk", silent)
map("i", "<S-Down>", "<C-o>vj", silent)
map("i", "<S-left>", "<left><C-o>v", silent)
map("i", "<S-right>", "<C-o>v", silent)

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Use tab for indenting in visual/select mode
map("v", '<Tab>', '>gv|', { desc = 'Indent Left' })
map("v", '<S-Tab>', '<gv', { desc = 'Indent Right' })
------------------------------------

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })


-- Notify
map({ "n", "v" }, "<leader>un", function()
	require("notify").dismiss(silent)
end, { desc = "Dimiss all notifcation" })

-- neotree
map("n", "<c-e>", "<cmd>Neotree toggle<cr>", { desc = "toggle file explorer" })
