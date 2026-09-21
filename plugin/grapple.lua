local pack = require("pack")
local plugin = pack.register(pack.gh("cbochs/grapple.nvim"))

local load = pack.once(function()
  pack.load(plugin)
  require("grapple").setup({ scope = "git_branch" })
end)

-- stylua: ignore start
pack.keymap("n", "<leader>m", load, function() require("grapple").toggle() end, { desc = "Grapple toggle tag" })
pack.keymap("n", "<leader>k", load, function() require("grapple").toggle_tags() end, { desc = "Grapple toggle tags" })
pack.keymap("n", "<leader>K", load, function() require("grapple").toggle_scopes() end, { desc = "Grapple toggle scopes" })
pack.keymap("n", "<leader>j", load, function() require("grapple").cycle_tags("next") end, { desc = "Grapple cycle forward" })
pack.keymap("n", "<leader>J", load, function() require("grapple").cycle_tags("prev") end, { desc = "Grapple cycle backward" })
-- stylua: ignore end

for index = 1, 10 do
  pack.keymap("n", "<leader>" .. (index % 10), load, function()
    require("grapple").select({ index = index })
  end, { desc = "Grapple select " .. index })
end
