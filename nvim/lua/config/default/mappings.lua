local map = vim.keymap.set
local silent = { silent = true }

------TRADITIONAL KEYBINDING--------

map({ "i", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "i", "n" }, "<C-z>", "<cmd>u<cr>", { desc = "Undo" })
map({ "i", "n" }, "<C-r>", "<cmd>redo<cr>", { desc = "Redo" })

-- Start new line from any cursor position
map("i", "<S-CR>", "<C-o>o", { silent = true, desc = "Insert line under" })
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

-- Pane
map("n", "<leader>:", ":vsplit<CR>", { silent = true, desc = "which_key_ignore" })
map("n", "<leader>%", ":split<CR>", { silent = true, desc = "which_key_ignore" })
map("n", "<leader>x", ":close<CR>", { silent = true, desc = "which_key_ignore" })

-- Delete without yanking
map({ 'n', 'v' }, 'd', '"_d', { noremap = true })
map('n', 'dd', '"_dd', { noremap = true })

------------------------------------
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "which_key_ignore" })
