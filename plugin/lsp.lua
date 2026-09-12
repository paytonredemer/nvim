local pack = require("pack")
local plugin = pack.register(pack.gh("neovim/nvim-lspconfig"))

pack.load(plugin)
vim.lsp.enable({
  "bashls",
  "clangd",
  "copilot",
  "eslint",
  "harper_ls",
  "lua_ls",
  "nixd",
  "pyright",
  "rust_analyzer",
  "ts_ls",
})
