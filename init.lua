require("config.lazy")

require("config.keymaps")
require("config.options")
require("config.autocmds")

require("nixCatsUtils.lazyCat").setup(
  nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }),
  "plugins",
  {
    lockfile = nixCats.configDir .. "/lazy-lock.json",
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
  }
)
