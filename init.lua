require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.autocmds")

local config_dir = vim.env.NVIM_CONFIG_DIR or vim.fn.stdpath("config")

require("lazy").setup("plugins", {
  lockfile = vim.fs.joinpath(config_dir, "lazy-lock.json"),
  performance = {
    rtp = {
      paths = { config_dir, vim.fs.joinpath(config_dir, "after") },
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
