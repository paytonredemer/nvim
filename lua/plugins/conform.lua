return {
  "stevearc/conform.nvim",
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    lua = { "stylua" },
    python = { "isort", "black" },
    sh = { "shfmt" },
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
