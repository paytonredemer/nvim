vim.loader.enable()

local config_dir = vim.env.NVIM_CONFIG_DIR or vim.fn.stdpath("config")
vim.opt.runtimepath:prepend(config_dir)
vim.opt.runtimepath:append(vim.fs.joinpath(config_dir, "after"))
vim.o.packlockfile = vim.fs.joinpath(config_dir, "nvim-pack-lock.json")

vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_nvim_zip_plugin = 1

require("pack")
require("options")
require("keymaps")
require("autocmds")
