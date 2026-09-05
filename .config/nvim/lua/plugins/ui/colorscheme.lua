-- lua/plugins/ui/colorscheme.lua
-- Selects the ACTIVE colorscheme and disables the LazyVim news popups.
--
-- Available themes (switch by changing `colorscheme` below, or live with
-- `:colorscheme <name>`):
--   onedark          ← ACTIVE — high-contrast "bright" onedark
--                       (lua/plugins/ui/onedark.lua)
--   catppuccin        neon-mocha override   (lua/plugins/ui/catppuccin.lua)
--   tokyonight        LazyVim default theme (shipped, no local spec)
--   shades-of-purple  custom runtime theme  (colors/shades-of-purple.lua)
--   solarized-sand    custom light theme    (colors/solarized-sand.lua)
--   black-and-white   grayscale theme       (colors/black-and-white.lua)

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "shades-of-purple",
      -- Suppress the "what's new" popups on startup.
      news = {
        lazyvim = false,
        neovim = false,
      },
    },
  },
}
