-- lua/plugins/extras/project.lua
-- project.nvim: superior project detection. Auto-sets cwd to the project
-- root (via LSP/patterns) and adds a Telescope picker for recent projects.

return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
    opts = {
      -- Detect root by LSP first, then fall back to these marker files.
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "pyproject.toml",
        "Cargo.toml",
        "go.mod",
        "pom.xml",
        "build.gradle",
        ".root",
      },
      -- Don't change directory automatically inside these special buffers.
      exclude_dirs = { "~/.cargo/*" },
      show_hidden = false,
      silent_chdir = true, -- don't print a message on cwd change
      scope_chdir = "global", -- change cwd globally (matches session expectations)
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      -- Register the Telescope extension if Telescope is available.
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("projects")
      end
    end,
  },
}
