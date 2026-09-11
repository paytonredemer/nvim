vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "L", "$")

-- centered actions
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- yanking and deleting
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]])

-- toggle cursorline
vim.keymap.set("n", "<leader>ul", "<cmd>set cursorline!<cr>", { desc = "[U]i Cursor[L]ine" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-T>", "<C-W>-")

-- Neovim's default LSP mappings include <C-S> for signature help in Insert mode.

-- diagnostics
local diagnostic_goto = function(forward, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = forward and 1 or -1, severity = severity })
  end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

vim.keymap.set("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set("n", "<leader>cc", function()
  vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
end, { desc = "Toggle inline completion" })

vim.keymap.set("i", "<Tab>", function()
  if not vim.lsp.inline_completion.get() then
    return "<Tab>"
  end
end, {
  expr = true,
  replace_keycodes = true,
  desc = "Get the current inline completion",
})

vim.keymap.set("n", "<leader>ci", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
