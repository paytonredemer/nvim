return {
  {
    "iamcco/markdown-preview.nvim",
    build = ":call mkdp#util#install()",
    ft = "markdown",
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    opts = {},
  },
}
