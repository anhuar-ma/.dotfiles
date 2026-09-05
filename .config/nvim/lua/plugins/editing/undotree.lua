-- lua/plugins/editing/undotree.lua
-- undotree: visualize and navigate the undo history tree.

return {
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeFocus" },
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree (Toggle)" },
    },
    init = function()
      -- Layout: 2 = tree + diff on the left, focus the tree on open.
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_DiffpanelHeight = 12
      vim.g.undotree_SplitWidth = 36
    end,
  },
}
