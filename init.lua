vim.loader.enable()

local config_dir = vim.fn.stdpath("config")
if vim.env.NVIM_NIX_ENV == "1" then
  config_dir = assert(vim.env.NVIM_CONFIG_DIR, "NVIM_CONFIG_DIR is required in the Nix environment")
  vim.opt.runtimepath:prepend(config_dir)
  vim.opt.runtimepath:append(vim.fs.joinpath(config_dir, "after"))
end

vim.o.packlockfile = vim.fs.joinpath(config_dir, "nvim-pack-lock.json")

require("pack")

require("options")
require("keymaps")
require("autocmds")
