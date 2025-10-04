return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = "<C-g>",
    direction = "horizontal",
    shade_terminals = true,
  },
  config = function(_, opts)
    if vim.loop.os_uname().sysname == "Windows_NT" then
      vim.opt.shellcmdflag = "-s"
    end
    require("toggleterm").setup(opts)
  end,
  keys = "<C-g>",
}
