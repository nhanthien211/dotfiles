local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  integrations = {
    'defaults',
    'cmp',
    'devicons',
    'git',
    'lsp',
    'mason',
    'syntax',
    'treesitter',
    'statusline',
    'trouble',
    'whichkey'
  },
}
local sep_l = ''
local sep_r = "%#St_sep_r#" .. '' .. " %#ST_EmptySpace#"

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
      "file",
      "git",
      "diagnostics",
      "%=",
      "lsp"
    },
    modules = {
      custome_file = function()
        local icon = "󰈚"
        local filename = (vim.fn.expand "%" == "" and "Empty ") or vim.fn.expand "%:t"

        if filename ~= "Empty " then
          local modified = vim.bo.modified and " +" or ""
          local readonly = vim.bo.readonly and " 󰌾" or ""
          return { icon, filename .. modified .. readonly .. " " }
        end
        return { icon, filename }
      end,
    }
  },
  cmp = {
    icons = true,
    style = "atom"
  },
  lsp = { signature = true },
  colorify = { enabled = false }
}

return M
