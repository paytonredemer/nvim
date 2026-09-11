local pack = require("pack")
local plugin = pack.register(pack.gh("folke/trouble.nvim"))

vim.api.nvim_create_autocmd("CmdUndefined", {
  pattern = "Trouble",
  once = true,
  callback = function()
    pack.load(plugin)
    require("trouble").setup()
  end,
})
