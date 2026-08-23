local lint = require("lint")
lint.linters_by_ft = {
  gitcommit = { "codespell", "gitlint" },
  markdown = { "codespell", "proselint" },
  python = { "mypy" },
  tex = { "codespell", "proselint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
  callback = function()
    if vim.opt_local.modifiable:get() then
      lint.try_lint()
    end
  end,
})
