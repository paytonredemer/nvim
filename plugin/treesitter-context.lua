local pack = require("pack")
local plugin = pack.register(pack.gh("nvim-treesitter/nvim-treesitter-context"))

local load = pack.once(function()
  pack.load(plugin)
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = load,
})

pack.keymap("n", "<leader>uc", load, function()
  require("treesitter-context").toggle()
end, { desc = "[U]i Treesitter [C]ontext toggle" })
vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ vim.v.count1 .. "[c", bang = true })
  else
    load()
    require("treesitter-context").go_to_context(vim.v.count1)
  end
end, { desc = "Previous diff change or enclosing context" })
