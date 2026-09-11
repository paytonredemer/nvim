local pack = require("pack")
local plugin = pack.register(pack.gh("stevearc/conform.nvim"))

local load = pack.once(function()
  pack.load(plugin)

  require("conform").setup({
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "isort", "black" },
      sh = { "shfmt" },
    },
  })
end)

pack.keymap("n", "<leader>cf", load, function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[C]ode [F]ormat" })
