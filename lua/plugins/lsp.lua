return {
  "neovim/nvim-lspconfig",
  lazy = true,
  init = function()
    local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"

    -- INFO: `prepend` ensures it is loaded before the user's LSP configs, so
    -- that the user's configs override nvim-lspconfig.
    vim.opt.runtimepath:prepend(lspConfigPath)
  end,
}
