-- lua/plugins/extras/neorg.lua
-- Neorg: structured note-taking / org-mode for Neovim. Migrated from the
-- previous config. The .norg treesitter folding/indent autocmd lives in
-- lua/config/autocmds.lua (neorg_treesitter group).

return {
  {
    "nvim-neorg/neorg",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = false, -- track the latest commit
    ft = "norg", -- lazy-load on filetype
    cmd = "Neorg", -- and on the :Neorg command
    priority = 30, -- load after treesitter (default priority 50)
    opts = {
      load = {
        ["core.defaults"] = {}, -- load all the default modules
      },
    },
  },
}
