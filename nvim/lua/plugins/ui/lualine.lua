local colors = require("catppuccin.palettes.frappe")
local icons = require("config.icons")

local space = {

  function()
    return " "
  end,
  color = { bg = "NONE" }
}

local filename = {
  "filename",
  color = { bg = colors.rosewater, fg = "#000000", gui = "bold" },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  icon = "",
  separator = { left = "", right = "" },
  color = { bg = colors.surface0, fg = colors.subtext1, guid = "bold" }
}

local diff = {
  "diff",
  separator = { left = "", right = "" },
  symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
  color = { bg = colors.base, guid = "bold" }
}

local modes = {
  "mode",
  separator = { left = "", right = "" },
}

local dia = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = icons.diagnostics.error, warn = icons.diagnostics.warn, info = icons.diagnostics.info, hint = icons.diagnostics.hint },
  separator = { left = "", right = "" },
  color = { bg = colors.surface0, fg = "NONE" }
}

local lsp = {
  icon = " ",
  function()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })

    if next(buf_clients) == nil then
      return ""
    end


    local buf_client_names = {}
    for _, client in ipairs(buf_clients) do
      table.insert(buf_client_names, client.name)
    end

    return table.concat(buf_client_names, ', ')
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.surface0, fg = colors.subtext1 }
}

local linter = {
  icon = "󰄭 ",
  function()
    local buf_ft = vim.bo.filetype
    local lint_s, lint = pcall(require, "lint")
    if lint_s then
      for ft_k, ft_v in pairs(lint.linters_by_ft) do
        if type(ft_v) == "table" then
          for _, linter in ipairs(ft_v) do
            if buf_ft == ft_k then
              return linter
            end
          end
        elseif type(ft_v) == "string" then
          if buf_ft == ft_k then
            return ft_v
          end
        end
      end
    end
    return ""
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.surface0, fg = colors.subtext1 }

}

local formatter = {
  icon = "󰷈 ",
  function()
    local ok, conform = pcall(require, "conform")
    if next(conform.list_formatters_for_buffer()) == nil then
      return ""
    end

    local formatters = table.concat(conform.list_formatters_for_buffer(), " ")

    if ok then
      for formatter in formatters:gmatch("%w+") do
        if formatter then
          return formatter
        end
      end
    end
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.surface0, fg = colors.subtext1 }
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          -- theme = ,
          globalstatus = true,
          disabled_filetypes = { statusline = { "snacks_dashboard" } },
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },

        },

        sections = {
          lualine_a = { modes },
          lualine_b = { space },
          lualine_c = { filename, space, branch, diff, space, dia },
          lualine_x = { space },
          lualine_y = { space },
          lualine_z = { formatter, space, linter, space, lsp }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = {
          'mason', "trouble", "lazy",
        }
      })
    end,
  },
}
