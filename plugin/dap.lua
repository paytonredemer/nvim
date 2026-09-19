local pack = require("pack")
local plugins = pack.register({
  pack.gh("mfussenegger/nvim-dap"),
  pack.gh("igorlfs/nvim-dap-view"),
})

local load = pack.once(function()
  pack.load(plugins)
  require("dap-view").setup({
    virtual_text = { enabled = true },
    winbar = { controls = { enabled = true } },
    windows = { terminal = { hide = { "lldb" } } },
  })

  local dap, dv = require("dap"), require("dap-view")
  dap.listeners.before.attach["dap-view-config"] = function()
    dv.open()
  end
  dap.listeners.before.launch["dap-view-config"] = function()
    dv.open()
  end
  dap.listeners.before.event_terminated["dap-view-config"] = function()
    dv.close()
  end
  dap.listeners.before.event_exited["dap-view-config"] = function()
    dv.close()
  end

  dap.adapters.lldb = {
    type = "executable",
    command = vim.fn.exepath("lldb-dap"),
    name = "lldb",
  }
end)

-- Native command retry also preserves arguments, bangs and modifiers.
vim.api.nvim_create_autocmd("CmdUndefined", {
  pattern = "Dap*",
  once = true,
  callback = load,
})

-- stylua: ignore start
pack.keymap("n", "<F5>", load, function() require("dap").continue() end, { desc = "Continue" })
pack.keymap("n", "<F10>", load, function() require("dap").step_over() end, { desc = "Step Over" })
pack.keymap("n", "<F11>", load, function() require("dap").step_into() end, { desc = "Step Into" })
pack.keymap("n", "<S-F11>", load, function() require("dap").step_out() end, { desc = "Step Out" })
pack.keymap("n", "<leader>dc", load, function() require("dap").continue() end, { desc = "Continue" })
pack.keymap("n", "<leader>dh", load, function() require("dap").step_back() end, { desc = "Step Back" })
pack.keymap("n", "<leader>dj", load, function() require("dap").step_into() end, { desc = "Step Into" })
pack.keymap("n", "<leader>dk", load, function() require("dap").step_out() end, { desc = "Step Out" })
pack.keymap("n", "<leader>dl", load, function() require("dap").step_over() end, { desc = "Step Over" })
pack.keymap("n", "<leader>db", load, function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
pack.keymap("n", "<leader>dB", load, function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Breakpoint Condition" })
pack.keymap("n", "<leader>dg", load, function() require("dap").goto_() end, { desc = "Go to line (no execute)" })
pack.keymap("n", "<leader>dC", load, function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
pack.keymap("n", "<leader>dH", load, function() require("dap.ui.widgets").hover() end, { desc = "View Expression" })
pack.keymap("n", "<leader>dJ", load, function() require("dap").down() end, { desc = "Down" })
pack.keymap("n", "<leader>dK", load, function() require("dap").up() end, { desc = "Up" })
pack.keymap("n", "<leader>dL", load, function() require("dap").run_last() end, { desc = "Run Last" })
pack.keymap("n", "<leader>dp", load, function() require("dap").pause() end, { desc = "Pause" })
pack.keymap("n", "<leader>dr", load, function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
pack.keymap("n", "<leader>ds", load, function() require("dap").session() end, { desc = "Session" })
pack.keymap("n", "<leader>dt", load, function() require("dap").terminate() end, { desc = "Terminate" })
pack.keymap("n", "<leader>du", load, function() require("dap-view").toggle() end, { desc = "Toggle dap-view" })
-- stylua: ignore end
