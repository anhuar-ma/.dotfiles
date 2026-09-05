-- colors/onedark-warm.lua
-- onedark.nvim "warm" variant — warmer, slightly red-tinted accents. Thin
-- runtime wrapper around the plugin installed by lua/plugins/ui/onedark.lua.

local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup({
  style = "warm",
  term_colors = true,
  code_style = { comments = "italic" },
})
onedark.load()
