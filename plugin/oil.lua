local pack = require("pack")
local plugin = pack.register(pack.gh("stevearc/oil.nvim"))

pack.later(function()
  pack.load(plugin)

  require("oil").setup({
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  })
end)

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
