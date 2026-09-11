local pack = require("pack")
local plugins = pack.register({
  pack.gh("nvim-lua/plenary.nvim"),
  pack.gh("folke/todo-comments.nvim"),
})

local load = pack.once(function()
  pack.load(plugins)
  require("todo-comments").setup()
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = load,
})

pack.keymap("n", "]t", load, function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
pack.keymap("n", "[t", load, function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
