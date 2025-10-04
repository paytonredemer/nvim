return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      local gs = package.loaded.gitsigns
      -- stylua: ignore start
      map("n", "[h", gs.prev_hunk, "Previous hunk")
      map("n", "]h", gs.next_hunk, "Next hunk")
      map("n", "<leader>hs", gs.stage_hunk, "[H]unk [S]tage")
      map("n", "<leader>hr", gs.reset_hunk, "[H]unk [R]eset")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[H]unk [S]tage")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[H]unk [R]eset")
      map("n", "<leader>hS", gs.stage_buffer, "[H]unk [S]tage Buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "[H]unk [U]ndo Stage")
      map("n", "<leader>hR", gs.reset_buffer, "[H]unk [R]eset Buffer")
      map("n", "<leader>hp", gs.preview_hunk, "[H]unk [P]review")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "[G]it [B]lame")
      map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff this")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "[G]it [D]iff this ~")
      map("n", "<leader>ub", gs.toggle_current_line_blame, "[U]i [B]lame line")
      map("n", "<leader>us", gs.toggle_signs, "[U]i toggle git [S]igns")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "inner hunk")
      -- stylua: ignore end
    end,
  },
}
