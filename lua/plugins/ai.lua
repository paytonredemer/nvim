return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
  opts = {},
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Toggle" },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>",        desc = "Code Companion New Chat" },
    { "<leader>am", "<cmd>CodeCompanionActions<cr>",     desc = "Code Companion More" },
  }
}
