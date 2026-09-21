-- Overseer defines lightweight commands which load the task UI on demand.
local pack = require("pack")
pack.load(pack.gh("stevearc/overseer.nvim"))
require("overseer").setup()

vim.keymap.set("n", "<leader>cb", "<cmd>OverseerRun<cr>", { desc = "[C]ode [B]uild" })
vim.keymap.set("n", "<leader>ct", "<cmd>OverseerToggle!<cr>", { desc = "[C]ode [T]asks" })
