-- Auto show diagnostic on hover
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		local float_opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always", -- show source in diagnostic popup window
			prefix = " ",
		}
		vim.diagnostic.open_float(nil, float_opts)
	end,
})

-- Auto linting
local lint = require("lint")

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint(nil, { ignore_errors = true })
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
			}, function()
				vim.notify("Auto format on save", "info", {
					title = "conform.nvim",
				})
			end)
		end
	end,
})
