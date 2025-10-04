return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.o.showmode = false
  end,
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1 },
      },
      lualine_x = { "" },
      lualine_y = { "diagnostics" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_c = {
        { "filename", path = 1 },
      },
    },
  },
}
