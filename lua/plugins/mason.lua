if vim.fn.executable("nix") == 1 then
  return
end

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "bash-language-server",
    "clangd",
    "copilot-language-server",
    "eslint-lsp",
    "harper-ls",
    "lua-language-server",
    "pyright",
    "rust-analyzer",
    "typescript-language-server",
    "clang-format",
    "black",
    "isort",
    "shfmt",
    "stylua",
    "codespell",
    "gitlint",
    "mypy",
    "proselint",
  },
})
