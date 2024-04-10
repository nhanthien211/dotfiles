local map = vim.keymap.set
local silent = { silent = true }

------TRADITIONAL KEYBINDING--------

map({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "i", "n" }, "<C-z>", "<cmd>u<cr>", { desc = "Undo" })
map({ "i", "n" }, "<C-r>", "<cmd>redo<cr>", { desc = "Redo" })

-- Start new line from any cursor position in insert-mode
map("i", "<S-CR>", "<C-o>o", { desc = "Start Newline" })
map("n", "]<Leader>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { silent = true, desc = "Insert line under" })
map("n", "[<Leader>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { silent = true, desc = "Insert line above" })

-- Move lines
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move line up" })
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move line down" })

map("n", "H", "^", { silent = true, desc = "Move to begnning" })
map("n", "L", "$", { silent = true, desc = "Move to end" })
map("n", "J", "+", { silent = true, desc = "Move to next line first char" })
map("n", "K", "-", { silent = true, desc = "Move to prev line first char" })

-- Easy select text in edit mode
map("i", "<S-Up>", "<left><C-o>vk", silent)
map("i", "<S-Down>", "<C-o>vj", silent)
map("i", "<S-left>", "<left><C-o>v", silent)
map("i", "<S-right>", "<C-o>v", silent)

map("v", "<S-Up>", "k", silent)
map("v", "<S-Down>", "j", silent)
map("v", "<S-left>", "h", silent)
map("v", "<S-right>", "l", silent)

-- Select all
map("n", "<C-a>", "ggVG", silent)

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Use tab for indenting in visual/select mode
map("v", "<Tab>", ">gv|", { desc = "Indent Left" })
map("v", "<S-Tab>", "<gv", { desc = "Indent Right" })

------------------------------------

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Notify
map({ "n", "v" }, "<leader>un", function()
	require("notify").dismiss(silent)
end, { desc = "Dimiss all notifcation" })

-- neotree
map("n", "<c-e>", "<cmd>Neotree toggle<cr>", { desc = "toggle file explorer" })
