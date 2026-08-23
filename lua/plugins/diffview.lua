local commands = {
  "DiffviewClose",
  "DiffviewFileHistory",
  "DiffviewFocusFiles",
  "DiffviewLog",
  "DiffviewOpen",
  "DiffviewRefresh",
  "DiffviewToggleFiles",
}

local loaded = false
local function load()
  if loaded then
    return
  end
  loaded = true

  for _, command in ipairs(commands) do
    pcall(vim.api.nvim_del_user_command, command)
  end
  vim.cmd.packadd("diffview.nvim")
end

for _, name in ipairs(commands) do
  vim.api.nvim_create_user_command(name, function(command)
    load()
    local args = command.args ~= "" and (" " .. command.args) or ""
    vim.cmd(name .. (command.bang and "!" or "") .. args)
  end, { bang = true, nargs = "*" })
end

return load
