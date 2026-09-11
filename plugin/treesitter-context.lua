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
pack.keymap("n", "[c", load, function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Jump to context" })
