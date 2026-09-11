local config_dir = vim.env.NVIM_CONFIG_DIR or vim.fn.stdpath("config")
local pack = require("pack")

pack.load(pack.gh("folke/snacks.nvim"))

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    -- Snacks' default startup section depends on lazy.nvim's statistics API.
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
    },
    preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "g", desc = "Git", action = ":Neogit" },
          { icon = " ", key = "e", desc = "Explorer", action = ":Oil" },
          { icon = " ", key = "c", desc = "Config", action = function() Snacks.picker.files({ cwd = config_dir }) end },
          { icon = " ", key = "s", desc = "Restore Session", action = ":RestoreSession" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
    },
  },
  image = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  lazygit = {},
  notifier = { enabled = true },
  picker = {
    db = {
      sqlite3_path = vim.env.SQLITE3_LIB_PATH,
    },
    ui_select = true,
    formatters = {
      file = { truncate = 100 },
    },
    previewers = {
      file = { max_size = 3 * 1024 * 1024 }, -- 3MB
    },
  },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  terminal = { win = { wo = { winbar = "" } } },
  words = { enabled = true },
  zen = { toggles = { dim = false }, win = { backdrop = { transparent = false, blend = 90 } } },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set({ "n", "t" }, "<C-g>", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>uz", function() Snacks.zen() end, { desc = "[U]i [Z]en toggle" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
-- General
vim.keymap.set("n", "<leader><leader>", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<C-p>", function() Snacks.picker.smart() end, { desc = "Smart Search" })
-- find
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = config_dir }) end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", "<leader>fs", function() Snacks.picker.spelling() end, { desc = "Find Spelling Options" })
-- search
vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sn", function() Snacks.picker.notifications() end, { desc = "Notifications" })
vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set("n", "<leader>sR", function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo" })
vim.keymap.set("n", "<leader>sz", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })
vim.keymap.set("n", "<leader>qp", function() Snacks.picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
-- Grep
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
-- git
vim.keymap.set("n", "<leader>gB", function() Snacks.picker.git_branches() end, { desc = "Git Branch" })
vim.keymap.set("n", "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
-- stylua: ignore end
