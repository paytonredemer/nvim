vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
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
})
