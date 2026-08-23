return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
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
  end,
}
