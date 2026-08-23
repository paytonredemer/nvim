if not vim.env.NVIM_TREESITTER_RTP then
  require("nvim-treesitter").install({
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "query",
    "regex",
    "rust",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  })
end

local context_loaded = false
local function load_context()
  if context_loaded then
    return
  end
  context_loaded = true
  vim.cmd.packadd("nvim-treesitter-context")
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  once = true,
  callback = load_context,
})

vim.keymap.set("n", "<leader>uc", function()
  load_context()
  require("treesitter-context").toggle()
end, { desc = "[U]i Treesitter [C]ontext toggle" })
vim.keymap.set("n", "[c", function()
  load_context()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Jump to context" })
