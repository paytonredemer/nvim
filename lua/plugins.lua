local treesitter_changed = false
local nix_treesitter = vim.env.NVIM_TREESITTER_RTP
if nix_treesitter then
  vim.opt.runtimepath:prepend(nix_treesitter)
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and (event.data.kind == "install" or event.data.kind == "update") then
      treesitter_changed = true
    end
  end,
})

local plugins = {
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/kevinhwang91/nvim-bqf",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/overseer.nvim",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/tpope/vim-sleuth",
  { src = "https://github.com/MeanderingProgrammer/markdown.nvim", name = "render-markdown" },
  -- TODO: Update to v2 when it becomes stable.
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
}

if not nix_treesitter then
  table.insert(plugins, "https://github.com/nvim-treesitter/nvim-treesitter")
end

if vim.fn.executable("nix") ~= 1 then
  table.insert(plugins, "https://github.com/williamboman/mason.nvim")
  table.insert(plugins, "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim")
end

local deferred = {
  ["blink.cmp"] = true,
  ["diffview.nvim"] = true,
  ["lazydev.nvim"] = true,
  ["neogit"] = true,
  ["nvim-bqf"] = true,
  ["nvim-dap"] = true,
  ["nvim-dap-view"] = true,
  ["nvim-dap-virtual-text"] = true,
  ["nvim-treesitter-context"] = true,
  ["oil.nvim"] = true,
  ["overseer.nvim"] = true,
  ["render-markdown"] = true,
  ["trouble.nvim"] = true,
}

vim.pack.add(plugins, {
  confirm = false,
  load = function(plugin)
    if not deferred[plugin.spec.name] then
      vim.cmd.packadd(plugin.spec.name)
    end
  end,
})

if treesitter_changed then
  vim.cmd.TSUpdate()
end
