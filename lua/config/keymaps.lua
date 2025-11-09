vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- move to windows using one less key stroke
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

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

-- tab navigation
-- vim.keymap.set("n", "<Tab>", ":tabnext<cr>")
-- vim.keymap.set("n", "<S-Tab>", ":tabprevious<cr>")

-- toggle cursorline
vim.keymap.set("n", "<leader>ul", "<cmd>set cursorline!<cr>", { desc = "[U]i Cursor[L]ine" })

-- better macros
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("x", "Q", ":norm @q<CR>")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-T>", "<C-W>-")

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
    vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol, { desc = "[G]oto document [S]ymbol" })
    vim.keymap.set("n", "gS", vim.lsp.buf.workspace_symbol, { desc = "[G]oto workspace [S]ymbol" })
    vim.keymap.set("n", "<leader>ch", vim.lsp.buf.signature_help, { desc = "[C]ode signature [H]elp" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
    vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "[C]ode [T]ype definition" })
  end,
})

-- TODO: move functions to another file
-- diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
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

-- TODO: Add this to neorg plugin file and lazy load
local get_neorg_link = function()
  local lnum = vim.fn.getcurpos()[2]

  local file = vim.fn.expand("%:p")
  file = file:gsub("\\", "/")
  file = file:gsub("C:", "")

  local link = "{/ " .. file .. ":" .. lnum .. "}"

  vim.fn.setreg('"', link)
  vim.notify("Copied " .. link .. " to vim clipboard")
end
vim.keymap.set("n", "<leader>nl", get_neorg_link, { desc = "[N]eorg [L]ink" })
