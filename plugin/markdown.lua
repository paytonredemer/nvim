local pack = require("pack")
local plugin = pack.register({
  name = "render-markdown",
  src = pack.gh("MeanderingProgrammer/markdown.nvim"),
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = function()
    pack.load(plugin)
    require("render-markdown").setup()
  end,
})
