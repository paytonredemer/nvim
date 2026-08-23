vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  once = true,
  callback = function()
    vim.cmd.packadd("nvim-bqf")
    require("bqf").setup()
  end,
})
