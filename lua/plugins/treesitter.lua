if vim.env.NVIM_NIX_ENV == "1" then
  vim.opt.runtimepath:prepend(vim.env.NVIM_TREESITTER_RTP)
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = vim.env.NVIM_NIX_ENV ~= "1",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "c",
        "cpp",
        "diff",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>uc",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "[U]i Treesitter [C]ontext toggle",
      },
      {
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        desc = "Jump to context",
      },
    },
  },
}
