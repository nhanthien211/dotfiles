local wk = require("which-key")

local opts = {
	mode = "n",
	prefix = "<leader>",
	silent = true,
}

local mappings = {
	c = {
		name = "Code action",

		-- Conform.nvim
		f = {
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				}, function()
					vim.notify("Formatted", "info", {
						title = "conform.nvim",
					})
				end)
			end,
			"Code format",
		},

		-- Nvim-lint.nvim
		l = {
			function()
				require("lint").try_lint()
				local linters = require("lint").get_running()
				vim.notify("Run linting", "info", {
					title = table.concat(linters, ", "),
				})
			end,
			"Code linting",
		},

		-- LSP related
		a = { vim.lsp.buf.code_action, "Code action" },
		c = { vim.lsp.codelens.run, "Run code lense" },
		C = { vim.lsp.codelens.refresh, "Refresh and run code lense" },
		h = { vim.lsp.buf.hover, "Hover" },
		s = { vim.lsp.buf.signature_help, "Signature help" },
		d = { "<Cmd>lua ToggleLspDiagnostic()<CR>", "Toggle diagnostic" },

		-- Rename
		r = { ":IncRename ", "Rename" },

		-- Trouble
		i = { "<cmd>Trouble document_diagnostics toggle<cr>", "Toggle document issues" },
		I = { "<cmd>Trouble workspace_diagnostics toggle<cr>", "Toggle document issues" },

		-- typescript-tool
		o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
	},
	g = {
		name = "LSP and Git",
		-- LSP
		d = { "<Cmd>Trouble lsp_definitions toggle<CR>", "Go to definition" },
		t = { "<Cmd>Trouble lsp_type_definitions toggle<CR>", "Go to type definition" },
		i = { "<Cmd>Trouble lsp_implementations toggle<CR>", "Go to implementation" },
		r = { "<Cmd>Trouble lsp_references toggle<CR>", "Go to reference" },
		s = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source" },
		D = { vim.lsp.buf.declaration, "Go to declaration" },

		-- Git
		b = { ":Gitsigns toggle_current_line_blame<CR>", "Git blame toggle" },
		p = { ":Gitsigns zopreview_hunk<CR>", "Git preview hunk" },
	},
	h = {
		name = "Haproon",
		-- Haproon
		a = {
			function()
				require("harpoon"):list():add()
			end,
			"Add to Harpoon",
		},
		c = {
			function()
				require("harpoon"):list():clear()
			end,
			"CLear Harpoon",
		},
	},
	l = { "<Cmd>Lazy<CR>", "Display LazyVim" },
	m = { "<Cmd>Mason<CR>", "Display Mason" },
	r = {
		name = "Reload",
		l = { "<Cmd>LspRestart<CR>", "Reload LSP" },
		e = {
			function()
				local tmux_session = "media-hub"
				local handle = io.popen("tmux display-message -p '#S'")
				if handle then
					local current_session = handle:read("*a")
					handle:close()

					-- Remove any trailing newline character from the session name
					current_session = current_session:gsub("\n", "")

					-- Check if the current session matches the desired session
					if current_session ~= tmux_session then
						vim.notify("Current session is not " .. tmux_session, "warn")
						return
					end

					local tmux_panel_id = "1.0"
					local reload_command = "tmux send-keys -t " .. tmux_panel_id .. " r"
					if os.execute(reload_command) then
						vim.notify("Emulator reloaded", "info")
					end
				end
			end,
			"Reload emulator",
		},
	},
	t = {
		name = "Toggle",
		t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
		h = {
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			"Toggle inlay hint",
		},
	},
}

wk.register(mappings, opts)
