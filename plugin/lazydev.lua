local pack = require("pack")
local plugin = pack.register(pack.gh("folke/lazydev.nvim"))

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  once = true,
  callback = function()
    pack.load(plugin)
    require("lazydev").setup({
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    })
  end,
})
