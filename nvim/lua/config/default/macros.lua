-- Function to insert console.log of word under cursor
local function insert_console_log()
  local ft = vim.bo.filetype
  if not (ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact") then
    print("Not a JS/TS buffer")
    return
  end

  local var = vim.fn.expand("<cword>")
  local line = string.format('console.log("%s: ", %s);', var, var)

  vim.api.nvim_feedkeys("o" .. line, "n", true) -- add new line below and insert
end

-- Map it to <leader>cl (you can change this)
vim.keymap.set("n", "<leader>p", insert_console_log, { desc = "Log current variable" })
