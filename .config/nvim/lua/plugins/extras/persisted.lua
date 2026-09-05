-- lua/plugins/extras/persisted.lua
-- persisted.nvim: lightweight, automatic session save/restore scoped per
-- working directory + git branch. Complements project.nvim: switch project,
-- restore its layout. Disabled in special/no-file buffers automatically.

return {
  {
    "olimorris/persisted.nvim",
    lazy = false, -- load early so autoload of the last session works
    keys = {
      { "<leader>qs", "<cmd>SessionSave<cr>", desc = "Session Save" },
      { "<leader>ql", "<cmd>SessionLoad<cr>", desc = "Session Load (cwd)" },
      { "<leader>qL", "<cmd>SessionLoadLast<cr>", desc = "Session Load Last" },
      { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Session Delete" },
      { "<leader>qS", "<cmd>Telescope persisted<cr>", desc = "Session Select" },
    },
    opts = {
      use_git_branch = true, -- separate sessions per git branch
      autosave = true, -- save on exit
      autoload = false, -- let the user pick; auto-loading can surprise
      follow_cwd = true,
      should_autosave = function()
        -- Skip autosave for dashboards / scratch buffers.
        local ft = vim.bo.filetype
        local skip = { "alpha", "dashboard", "lazy", "oil", "" }
        return not vim.tbl_contains(skip, ft)
      end,
      ignored_dirs = {
        "~/.config",
        "/tmp",
        "~/.local/share",
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      local ok, telescope = pcall(require, "telescope")
      if ok then
        pcall(telescope.load_extension, "persisted")
      end
    end,
  },
}
