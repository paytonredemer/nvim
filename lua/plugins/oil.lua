return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  },
  keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
}
