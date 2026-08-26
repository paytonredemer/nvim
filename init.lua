require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.autocmds")

local config_dir = vim.g.packaged_config_dir or vim.fn.stdpath("config")

require("lazy").setup("plugins", {
  lockfile = config_dir .. "/lazy-lock.json",
  performance = {
    rtp = {
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
