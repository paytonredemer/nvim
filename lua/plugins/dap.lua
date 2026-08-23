local loaded = false
local function load()
  if loaded then
    return
  end
  loaded = true

  vim.cmd.packadd("nvim-dap")
  vim.cmd.packadd("nvim-dap-virtual-text")
  vim.cmd.packadd("nvim-dap-view")

  require("dap-view").setup({
    winbar = { controls = { enabled = true } },
    windows = { terminal = { hide = { "lldb" } } },
  })
  require("nvim-dap-virtual-text").setup()

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

  dap.configurations.cpp = {
    {
      name = "Current Build",
      type = "lldb",
      request = "launch",
      program = "${workspaceFolder}/out/current/WX",
      args = { "-fs" },
      cwd = "${workspaceFolder}/out/current",
    },
  }
  dap.configurations.c = dap.configurations.cpp
end

local keys = {
  -- stylua: ignore
    { "<F5>",       function() require("dap").continue() end,                                             desc = "Continue" },
  {
    "<F10>",
    function()
      require("dap").step_over()
    end,
    desc = "Step Over",
  },
  {
    "<F11>",
    function()
      require("dap").step_into()
    end,
    desc = "Step Into",
  },
  {
    "<S-F11>",
    function()
      require("dap").step_out()
    end,
    desc = "Step Out",
  },
  {
    "<leader>dc",
    function()
      require("dap").continue()
    end,
    desc = "Continue",
  },
  {
    "<leader>dh",
    function()
      require("dap").step_back()
    end,
    desc = "Step Back",
  },
  {
    "<leader>dj",
    function()
      require("dap").step_into()
    end,
    desc = "Step Into",
  },
  {
    "<leader>dk",
    function()
      require("dap").step_out()
    end,
    desc = "Step Out",
  },
  {
    "<leader>dl",
    function()
      require("dap").step_over()
    end,
    desc = "Step Over",
  },
  {
    "<leader>db",
    function()
      require("dap").toggle_breakpoint()
    end,
    desc = "Toggle Breakpoint",
  },
  {
    "<leader>dB",
    function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "Breakpoint Condition",
  },
  {
    "<leader>dg",
    function()
      require("dap").goto_()
    end,
    desc = "Go to line (no execute)",
  },
  {
    "<leader>dC",
    function()
      require("dap").run_to_cursor()
    end,
    desc = "Run to Cursor",
  },
  {
    "<leader>dH",
    function()
      require("dap.ui.widgets").hover()
    end,
    desc = "View Expression",
  },
  {
    "<leader>dJ",
    function()
      require("dap").down()
    end,
    desc = "Down",
  },
  {
    "<leader>dK",
    function()
      require("dap").up()
    end,
    desc = "Up",
  },
  {
    "<leader>dL",
    function()
      require("dap").run_last()
    end,
    desc = "Run Last",
  },
  {
    "<leader>dp",
    function()
      require("dap").pause()
    end,
    desc = "Pause",
  },
  {
    "<leader>dr",
    function()
      require("dap").repl.toggle()
    end,
    desc = "Toggle REPL",
  },
  {
    "<leader>ds",
    function()
      require("dap").session()
    end,
    desc = "Session",
  },
  {
    "<leader>dt",
    function()
      require("dap").terminate()
    end,
    desc = "Terminate",
  },
  {
    "<leader>du",
    function()
      require("dap-view").toggle()
    end,
    desc = "Toggle dap-view",
  },
}

for _, key in ipairs(keys) do
  local action = key[2]
  vim.keymap.set("n", key[1], function()
    load()
    action()
  end, { desc = key.desc })
end
