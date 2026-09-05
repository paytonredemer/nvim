vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.exrc = true

require("vim._core.ui2").enable()

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.colorcolumn = "80"
vim.o.cursorline = true
vim.o.scrolloff = 999
vim.o.signcolumn = "yes"

vim.o.list = true
-- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
vim.opt.listchars = { eol = "↵", trail = "~", tab = ">-", nbsp = "␣" }

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- spelling
vim.o.spelllang = "en_us"
vim.o.spelloptions = "camel"
