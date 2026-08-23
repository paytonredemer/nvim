vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  once = true,
  callback = function()
    vim.cmd.packadd("render-markdown")
    require("render-markdown").setup()
  end,
})
