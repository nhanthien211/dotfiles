-- Auto show diagnostic on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor

    vim.diagnostic.open_float({
      bufnr = 0,
      focusable = false,
      border = "rounded",
      source = true,
      prefix = " ",
      scope = "cursor",
    })
  end
end
vim.cmd([[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]])

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

    -- if not string.find(vim.api.nvim_buf_get_name(0), "node_modules", 1, true) then
    --       end
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
