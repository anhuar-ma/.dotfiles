-- neo-tree.nvim: reveal dotfiles and hidden files in the tree.
return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
