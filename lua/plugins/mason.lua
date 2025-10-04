return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- Only load if not using nix
  cond = not (vim.fn.executable("nix") == 1),
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {},
    },
  },
  opts = {
    ensure_installed = {
      -- lsp
      "bash-language-server",
      "clangd",
      "copilot-language-server",
      "eslint-lsp",
      "harper-ls",
      "lua-language-server",
      "pyright",
      "rust-analyzer",
      "typescript-language-server",
      -- format
      "clang-format",
      "black",
      "isort",
      "shfmt",
      "stylua",
      -- lint
      "alex",
      "codespell",
      "gitlint",
      "mypy",
      "proselint",
    },
  },
}
