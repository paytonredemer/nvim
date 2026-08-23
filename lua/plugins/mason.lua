return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  -- Only load if not using nix
  cond = vim.env.NVIM_NIX_ENV ~= "1",
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
      "nixfmt",
      "shfmt",
      "stylua",
      -- lint
      "codespell",
      "gitlint",
      "mypy",
      "proselint",
      "shellcheck",
    },
  },
}
