---@diagnostic disable: cast-local-type
local M = {}

M.base46 = {
  theme = "aquarium",
  transparency = true,
  integrations = {
    'defaults',
    'avante',
    'cmp',
    'devicons',
    'git',
    'lsp',
    'mason',
    'syntax',
    'treesitter',
    'statusline',
    'trouble',
    'whichkey',
  },
}

local sep_l = ''
local sep_r = "%#St_sep_r#" .. '' .. " %#ST_EmptySpace#"

local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
  return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r
end

M.ui = {
  tabufline = {
    enabled = false
  },
  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "round",
    order = {
      "mode",
      "custom_file",
      "custom_diagnostics",
      "%=",
      "git",
      "space",
      "custom_lsp"
    },
    modules = {
      space = function()
        return " "
      end,
      custom_file = function()
        local icon = "󰈚"
        local bufnr = vim.api.nvim_get_current_buf()
        local path = vim.api.nvim_buf_get_name(bufnr)
        local name = (path == "" and "Unknown") or path:match "([^/\\]+)[/\\]*$"
        local statusline = require('arrow.statusline')
        local is_arrow_file = statusline.is_on_arrow_file(bufnr)

        if name ~= "Empty" then
          local miniIconAvailable, miniIcons = pcall(require, "mini.icons")
          if miniIconAvailable then
            local ft_icon = miniIcons.get('file', name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end

          local modified = vim.bo.modified and "  " or ""
          local readonly = vim.bo.readonly and " 󰷤 " or ""
          name           = name .. modified .. readonly
          if is_arrow_file then
            name = "󰣉 " .. name
          end
          return gen_block(icon, name, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#")
        end
        return gen_block(icon, name, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#")
      end,
      custom_lsp = function()
        local lsp = ""
        if rawget(vim, "lsp") then
          local bufnr = vim.api.nvim_get_current_buf()

          local buf_client_names = {}
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[bufnr] and client.name ~= 'copilot' then
              table.insert(buf_client_names, client.name)
            end
          end
          if vim.o.columns > 100 and #buf_client_names > 0 then
            lsp = table.concat(buf_client_names, ', ')
            return gen_block("", lsp, "%#St_lsp_sep#", "%#St_lsp_bg#", "%#St_lsp_txt#")
          end
        end
        return lsp
      end,
      custom_diagnostics = function()
        if not rawget(vim, "lsp") then
          return ""
        end
        local bufnr = vim.api.nvim_get_current_buf()
        local icons = require("config.icons")
        local err = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
        local warn = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
        local info = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })

        err = (err and err > 0) and ("%#St_lspError#" .. icons.diagnostics.error .. err .. " ") or ""
        warn = (warn and warn > 0) and ("%#St_lspWarning#" .. icons.diagnostics.warn .. warn .. " ") or ""
        hints = (hints and hints > 0) and ("%#St_lspHints#" .. icons.diagnostics.hint .. hints .. " ") or ""
        info = (info and info > 0) and ("%#St_lspInfo#" .. icons.diagnostics.info .. info .. " ") or ""

        return " " .. err .. warn .. hints .. info
      end
    }
  },
  colorify = { enabled = false },
}

return M
