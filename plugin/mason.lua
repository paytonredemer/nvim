local pack = require("pack")
local mason = pack.register(pack.gh("williamboman/mason.nvim"))
local installer = pack.register(pack.gh("WhoIsSethDaniel/mason-tool-installer.nvim"))

if vim.env.NVIM_NIX_ENV == "1" then
  return
end

pack.load(mason)
require("mason").setup()

pack.load(installer)

require("mason-tool-installer").setup({
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
})
