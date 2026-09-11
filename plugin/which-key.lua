vim.o.timeout = true
vim.o.timeoutlen = 300

local pack = require("pack")
local plugin = pack.register(pack.gh("folke/which-key.nvim"))

pack.later(function()
  pack.load(plugin)
  require("which-key").setup({ preset = "modern" })
end)
