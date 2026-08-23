return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "isort", "black" },
      sh = { "shfmt" },
    },
  },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "[C]ode [F]ormat",
    },
  },
}
