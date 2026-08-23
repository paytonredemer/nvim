local loaded = false
local function load()
  if loaded then
    return
  end
  loaded = true

  pcall(vim.api.nvim_del_user_command, "Trouble")
  vim.cmd.packadd("trouble.nvim")
  require("trouble").setup()
end

vim.api.nvim_create_user_command("Trouble", function(command)
  load()
  local args = command.args ~= "" and (" " .. command.args) or ""
  vim.cmd("Trouble" .. (command.bang and "!" or "") .. args)
end, { bang = true, nargs = "*" })
