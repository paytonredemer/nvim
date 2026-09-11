local pack = require("pack")
local plugins = pack.register({
  pack.gh("rafamadriz/friendly-snippets"),
  { src = pack.gh("saghen/blink.cmp"), version = vim.version.range("*") },
})

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    pack.load(plugins)

    require("blink.cmp").setup({
      keymap = { preset = "default" },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    })
  end,
})
