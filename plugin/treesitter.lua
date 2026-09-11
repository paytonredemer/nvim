local pack = require("pack")
local plugin = pack.register({
  src = pack.gh("nvim-treesitter/nvim-treesitter"),
  version = "main",
})

if vim.env.NVIM_NIX_ENV == "1" then
  vim.opt.runtimepath:prepend(vim.env.NVIM_TREESITTER_RTP)
else
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("treesitter_update", { clear = true }),
    callback = function(event)
      if event.data.spec.name == "nvim-treesitter" and event.data.kind == "update" then
        vim.cmd.packadd("nvim-treesitter")
        vim.cmd("TSUpdate")
      end
    end,
  })

  pack.load(plugin)
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
end

-- Start native highlighting on demand, including when Nix supplies the parsers.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function(event)
    -- Some filetypes have no installed parser.
    pcall(vim.treesitter.start, event.buf)
  end,
})
