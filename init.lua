if vim.fn.has("nvim-0.13") ~= 1 then
  error("This configuration requires Neovim 0.13 nightly (vim.pack)")
end

for _, plugin in ipairs({
  "loaded_gzip",
  "loaded_netrw",
  "loaded_netrwPlugin",
  "loaded_nvim_dir_plugin",
  "loaded_nvim_net_plugin",
  "loaded_nvim_zip_plugin",
  "loaded_remote_plugins",
  "loaded_tarPlugin",
  "loaded_tutor_mode_plugin",
}) do
  vim.g[plugin] = 1
end

require("config.keymaps")
require("config.options")
require("config.autocmds")

require("plugins")

require("plugins.treesitter")
require("plugins.blink")
require("plugins.colorscheme")
require("plugins.conform")
require("plugins.dap")
require("plugins.diffview")
require("plugins.gitsigns")
require("plugins.lazydev")
require("plugins.lint")
require("plugins.lualine")
require("plugins.markdown")
require("plugins.mason")
require("plugins.mini")
require("plugins.neogit")
require("plugins.oil")
require("plugins.overseer")
require("plugins.quickfix")
require("plugins.snacks")
require("plugins.todo-comments")
require("plugins.trouble")
require("plugins.which-key")

require("config.lsp")
