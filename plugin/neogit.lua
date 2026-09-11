local pack = require("pack")
local plugins = pack.register({
  pack.gh("nvim-lua/plenary.nvim"),
  pack.gh("sindrets/diffview.nvim"),
  pack.gh("NeogitOrg/neogit"),
})

vim.api.nvim_create_autocmd("CmdUndefined", {
  pattern = "Neogit",
  once = true,
  callback = function()
    pack.load(plugins)
    require("neogit").setup()
  end,
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
