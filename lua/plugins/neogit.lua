local loaded = false
local function load()
  if loaded then
    return
  end
  loaded = true

  require("plugins.diffview")()
  pcall(vim.api.nvim_del_user_command, "Neogit")
  vim.cmd.packadd("neogit")
  require("neogit").setup()
end

vim.api.nvim_create_user_command("Neogit", function(command)
  load()
  local args = command.args ~= "" and (" " .. command.args) or ""
  vim.cmd("Neogit" .. (command.bang and "!" or "") .. args)
end, { bang = true, nargs = "*" })

vim.keymap.set("n", "<leader>gg", function()
  load()
  vim.cmd.Neogit()
end, { desc = "Neogit" })
