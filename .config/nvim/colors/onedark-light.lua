-- colors/onedark-light.lua
-- onedark.nvim "light" variant — the light-background onedark. Thin runtime
-- wrapper around the plugin installed by lua/plugins/ui/onedark.lua.

local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup({
  style = "light",
  term_colors = true,
  code_style = { comments = "italic" },
})
onedark.load()
