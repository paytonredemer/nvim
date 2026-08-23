local loaded = false
local function load()
  if loaded then
    return
  end
  loaded = true

  pcall(vim.api.nvim_del_user_command, "Oil")
  vim.cmd.packadd("oil.nvim")
  require("oil").setup({
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
    view_options = { show_hidden = true },
  })
end

vim.api.nvim_create_user_command("Oil", function(command)
  load()
  local args = command.args ~= "" and (" " .. vim.fn.fnameescape(command.args)) or ""
  vim.cmd("Oil" .. (command.bang and "!" or "") .. args)
end, { bang = true, complete = "dir", nargs = "?" })

vim.keymap.set("n", "-", function()
  load()
  vim.cmd.Oil()
end, { desc = "Open parent directory" })
