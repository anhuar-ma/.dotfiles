-- lua/plugins/ui/catppuccin.lua
-- catppuccin is shipped and pre-configured by LazyVim (integrations already
-- enabled there). This spec overrides the flavour + a high-contrast "neon"
-- mocha palette (migrated from the previous config's mocha.lua). Kept as an
-- available theme; the active colorscheme is selected in
-- lua/plugins/ui/colorscheme.lua.

return {
  {
    "catppuccin/nvim",
    opts = {
      flavour = "mocha", -- latte | frappe | macchiato | mocha
      background = { light = "latte", dark = "mocha" },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "bold" },
      },
      -- High-contrast neon mocha overrides.
      color_overrides = {
        mocha = {
          base = "#1e1e2e",
          mantle = "#181825",
          crust = "#11111b",

          text = "#ffffff",
          subtext1 = "#e2e7f4",
          subtext0 = "#cdd6f4",

          overlay2 = "#a8b0cc",
          overlay1 = "#9098b5",
          overlay0 = "#787f9c",
          surface2 = "#606782",
          surface1 = "#4f556d",
          surface0 = "#3e4359",

          rosewater = "#ffc8d6",
          flamingo = "#ff9eb1",
          pink = "#ff8ce2",
          mauve = "#dd8eff",
          red = "#ff4f79",
          maroon = "#ff7a93",
          peach = "#ff964f",
          yellow = "#ffe55c",
          green = "#6df298",
          teal = "#40ead2",
          sky = "#6be0ff",
          sapphire = "#45bfff",
          blue = "#5298ff",
          lavender = "#b5c1ff",
        },
      },
    },
  },
}
