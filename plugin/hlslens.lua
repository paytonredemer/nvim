local pack = require("pack")
local plugin = pack.register(pack.gh("kevinhwang91/nvim-hlslens"))

pack.later(function()
  pack.load(plugin)
  require("hlslens").setup()
end)
