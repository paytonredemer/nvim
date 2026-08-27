require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.autocmds")

local config_dir = vim.env.NVIM_CONFIG_DIR

require("lazy").setup("plugins", {
  lockfile = config_dir .. "/lazy-lock.json",
  performance = {
    rtp = {
      paths = { config_dir },
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
