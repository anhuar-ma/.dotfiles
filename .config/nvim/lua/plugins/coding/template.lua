-- lua/plugins/coding/template.lua
-- template.nvim: insert file templates by name (:Template / :TemProject).
-- Migrated from the previous config.
--
-- Improvement over the old config: temp_dir is resolved via
-- vim.fn.stdpath("config") instead of a hardcoded "~/.config/nvim", and it
-- points at the shared <config>/templates directory (the same place
-- competitest.nvim reads main.cpp from) so there is a single source of truth
-- for file templates.

return {
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup({
        temp_dir = vim.fn.stdpath("config") .. "/templates",
      })
    end,
  },
}
