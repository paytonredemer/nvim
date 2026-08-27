require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.autocmds")

require("lazy").setup("plugins", {
  lockfile = vim.fs.joinpath(vim.env.NVIM_CONFIG_DIR or vim.fn.stdpath("config"), "lazy-lock.json"),
  performance = {
    rtp = {
      paths = { vim.env.NVIM_CONFIG_DIR },
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
