-- Auto show diagnostic on hover
local function show_diagnostics_on_hover()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

  if current_cursor[1] ~= last_popup_cursor[1] or current_cursor[2] ~= last_popup_cursor[2] then
    vim.w.lsp_diagnostics_last_cursor = current_cursor

    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    })
  end
end

vim.api.nvim_create_augroup("LSPDiagnosticsOnHover", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  group = "LSPDiagnosticsOnHover",
  pattern = "*",
  callback = show_diagnostics_on_hover,
})

-- Auto linting
local lint = require("lint")
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Auto format on save (except node_modules)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname:match("/node_modules/") then
      vim.notify("Never format node modules", vim.log.levels.WARN)
      return
    end
    require("conform").format({
      bufnr = args.buf,
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end,
})

-- Disable diagnostics upon insert mode leave and enter
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "n:i", "v:s" },
  desc = "Disable diagnostics in insert and select mode",
  callback = function(e)
    vim.diagnostic.enable(false, { e.buf })
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:n",
  desc = "Enable diagnostics when leaving insert mode",
  callback = function(e)
    vim.diagnostic.enable(true, { e.buf })
  end,
})

-- Restore cursor to last edition session position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Dim inactive windows
-- local last_win_id = nil
-- vim.cmd("highlight default DimInactiveWindows guifg=#666666")
--
-- -- When leaving a window, set all highlight groups to a "dimmed" hl_group
-- vim.api.nvim_create_autocmd({ "WinLeave" }, {
--   callback = function()
--     local highlights = {}
--     for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
--       table.insert(highlights, hl .. ":DimInactiveWindows")
--     end
--     vim.wo.winhighlight = table.concat(highlights, ",")
--     -- last_win_id = vim.api.nvim_get_current_win()
--   end,
-- })
--
-- -- When entering a window, restore all highlight groups to original
-- vim.api.nvim_create_autocmd({ "WinEnter" }, {
--   callback = function()
--     vim.wo.winhighlight = ""
--
--     -- if last_win_id then
--     --   local lastBuf = vim.api.nvim_win_get_buf(last_win_id)
--     --   local lastBufType = vim.bo[lastBuf].buftype
--     --   local currentBufType = vim.bo.buftype
--     --   vim.notify(currentBufType)
--     --   if lastBufType == "" and currentBufType == 'prompt' then
--     --     vim.wo[last_win_id].winhighlight = ""
--     --   end
--     --   last_win_id = nil
--     -- end
--   end,
-- })

-- Close on "q" for some popup
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "lspinfo", "checkhealth", "lazy", "mason", "AvanteInput" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<ESC>", ":close<CR>", { noremap = true, silent = true })

    -- for win with input
    -- vim.api.nvim_buf_set_keymap(0, "i", "<ESC>", "<C-o>:close<CR>", { noremap = true, silent = true })
    vim.bo.buflisted = false
  end,
})

-- Help split auto to right
vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically Split help Buffers to the right with 30% width",
  pattern = "help",
  callback = function()
    vim.cmd("wincmd L")                                             -- Move the help buffer to the right
    vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.35)) -- Resize to 30% of total width
  end,
})
