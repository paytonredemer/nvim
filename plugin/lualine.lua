vim.o.showmode = false

local pack = require("pack")
pack.load(pack.gh("nvim-lualine/lualine.nvim"))

require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1 },
    },
    lualine_x = {},
    lualine_y = { "lsp_status", "diagnostics" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_c = {
      { "filename", path = 1 },
    },
  },
})
