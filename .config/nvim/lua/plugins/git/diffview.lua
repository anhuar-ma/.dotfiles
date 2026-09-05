-- lua/plugins/git/diffview.lua
-- diffview.nvim: tabbed diff of the working tree, single-commit review,
-- file history, and a 3-way merge-conflict resolution UI.

return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "", desc = "+hunks" },
      { "<leader>gv", "<cmd>DiffviewFileHistory<cr>", desc = "File History (Branch)" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (Current File)" },
      {
        "<leader>gm",
        "<cmd>DiffviewOpen --merge<cr>",
        desc = "Diffview Merge Conflicts",
      },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
        file_history = { layout = "diff2_horizontal" },
      },
      file_panel = {
        listing_style = "tree",
        win_config = { position = "left", width = 35 },
      },
      keymaps = {
        view = {
          { "n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
    },
  },
}
