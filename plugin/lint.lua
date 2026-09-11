local pack = require("pack")
local plugin = pack.register(pack.gh("mfussenegger/nvim-lint"))

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = pack.once(function()
    pack.load(plugin)
    local lint = require("lint")

    lint.linters_by_ft = {
      gitcommit = { "codespell", "gitlint" },
      markdown = { "codespell", "proselint" },
      python = { "mypy" },
      sh = { "shellcheck" },
      tex = { "codespell", "proselint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        -- Skip unmodifiable buffers such as LSP pop-ups.
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end),
})
