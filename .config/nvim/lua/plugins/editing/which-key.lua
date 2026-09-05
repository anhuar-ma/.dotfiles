-- lua/plugins/editing/which-key.lua
-- which-key is shipped by LazyVim, which already registers groups for
-- c/d/f/g/gh/q/s/u/x and the [ ] g gs z b w prefixes, plus the <leader>?
-- and <c-w><space> keymaps. LazyVim uses `opts_extend = { "spec" }`, so the
-- entries below are APPENDED to its spec rather than replacing it.
--
-- Only the group labels that LazyVim does not define are declared here:
--   <leader>a  ai/avante      <leader>h  harpoon
--   <leader>t  terminal/test  <leader>z  zen/focus

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>h", group = "harpoon" },
          { "<leader>t", group = "terminal/test", icon = "" },
          { "<leader>z", group = "zen/focus" },
        },
      },
    },
  },
}
