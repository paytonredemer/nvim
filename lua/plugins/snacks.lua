return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "g", desc = "Git", action = ":Neogit" },
          { icon = " ", key = "e", desc = "Explorer", action = ":Oil" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
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
        sqlite3_path = vim.env.SQLITE3_LIB_PATH
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
    words = { enabled = true },
    -- Look into the options more
    zen = { toggles = { dim = false }, win = { backdrop = { transparent = false, blend = 90 } } },
  },
  -- stylua: ignore
  keys = {
    { "<leader>.",        function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
    { "<leader>uz",       function() Snacks.zen() end,                                            desc = "[U]i [Z]en toggle" },
    { "<leader>bd",       function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
    -- General
    { "<leader><leader>", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<C-p>",            function() Snacks.picker.smart() end,                                   desc = "Smart Search" },
    -- find
    { "<leader>fc",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff",       function() Snacks.picker.files() end,                                   desc = "Find Files" },
    { "<leader>fp",       function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fr",       function() Snacks.picker.recent() end,                                  desc = "Recent" },
    { "<leader>fs",       function() Snacks.picker.spelling() end,                                desc = "Find Spelling Options" },
    -- search
    { "<leader>sa",       function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
    { "<leader>sc",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
    { "<leader>sC",       function() Snacks.picker.commands() end,                                desc = "Commands" },
    { "<leader>sd",       function() Snacks.picker.diagnostics_buffer() end,                      desc = "Diagnostics" },
    { "<leader>sD",       function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
    { "<leader>sh",       function() Snacks.picker.help() end,                                    desc = "Help Pages" },
    { "<leader>sH",       function() Snacks.picker.highlights() end,                              desc = "Highlights" },
    { "<leader>si",       function() Snacks.picker.icons() end,                                   desc = "Icons" },
    { "<leader>sj",       function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
    { "<leader>sk",       function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
    { "<leader>sl",       function() Snacks.picker.loclist() end,                                 desc = "Location List" },
    { "<leader>sL",       function() Snacks.picker.lazy() end,                                    desc = "Lazy" },
    { "<leader>sm",       function() Snacks.picker.marks() end,                                   desc = "Marks" },
    { "<leader>sM",       function() Snacks.picker.man() end,                                     desc = "Man Pages" },
    { "<leader>sn",       function() Snacks.picker.notifications() end,                           desc = "Notifications" },
    { "<leader>sq",       function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
    { "<leader>sr",       function() Snacks.picker.resume() end,                                  desc = "Resume" },
    { "<leader>sR",       function() Snacks.picker.registers() end,                               desc = "Registers" },
    { "<leader>su",       function() Snacks.picker.undo() end,                                    desc = "Undo" },
    { "<leader>sz",       function() Snacks.picker.zoxide() end,                                  desc = "Zoxide" },
    { "<leader>qp",       function() Snacks.picker.projects() end,                                desc = "Projects" },
    { "<leader>uC",       function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
    -- Grep
    { "<leader>sb",       function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
    { "<leader>sB",       function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
    { "<leader>sg",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
    { "<leader>sw",       function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
    -- LSP
    { "gd",               function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
    { "gD",               function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
    { "gI",               function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
    { "gy",               function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
    { "<leader>ss",       function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
    { "<leader>sS",       function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
    -- git
    { "<leader>gB",       function() Snacks.picker.git_branches() end,                            desc = "Git Branch" },
    { "<leader>gc",       function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
    { "<leader>gl",       function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
    { "<leader>gL",       function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
    { "<leader>gs",       function() Snacks.picker.git_status() end,                              desc = "Git Status" },
    { "<leader>gS",       function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  },
}
