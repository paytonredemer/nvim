local pack = require("pack")
local plugin = pack.register(pack.gh("folke/ts-comments.nvim"))

pack.later(function()
  pack.load(plugin)
  require("ts-comments").setup()
end)
