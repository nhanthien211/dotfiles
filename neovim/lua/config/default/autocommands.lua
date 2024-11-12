-- Auto show diagnostic on hover
_G.LspDiagnosticsPopupHandler = function()
	local current_cursor = vim.api.nvim_win_get_cursor(0)
	local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

	-- Show the popup diagnostics window,
	-- but only once for the current cursor location (unless moved afterwards).
	if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
		vim.w.lsp_diagnostics_last_cursor = current_cursor

		local float_opts = {
			focusable = false,
			border = "rounded",
			source = "always", -- show source in diagnostic popup window
			prefix = " ",
			scope = "cursor",
		}

		vim.diagnostic.open_float(0, float_opts)
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
		if not string.find(vim.api.nvim_buf_get_name(0), "node_modules", 1, true) then
			require("conform").format({
				bufnr = args.buf,
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end
	end,
})

-- Disable diagnostics upon insert mode leave and enter
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { "n:i", "v:s" },
	desc = "Disable diagnostics in insert and select mode",
	callback = function(e)
		vim.diagnostic.disable(e.buf)
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "i:n",
	desc = "Enable diagnostics when leaving insert mode",
	callback = function(e)
		vim.diagnostic.enable(e.buf)
	end,
})
