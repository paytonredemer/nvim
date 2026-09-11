local pack = require("pack")
local plugin = pack.register(pack.gh("folke/persistence.nvim"))

local load = pack.once(function()
  pack.load(plugin)
  require("persistence").setup()
end)

vim.api.nvim_create_autocmd("BufReadPre", {
  once = true,
  callback = load,
})

vim.api.nvim_create_user_command("RestoreSession", function()
  load()
  require("persistence").load()
end, { desc = "Restore the session for the current directory" })
