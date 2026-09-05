-- colors/onedark-dark.lua
-- onedark.nvim "dark" variant — the standard medium-dark onedark. Thin
-- runtime wrapper around the plugin installed by lua/plugins/ui/onedark.lua.

local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup({
  style = "dark",
  term_colors = true,
  code_style = { comments = "italic" },
})
onedark.load()
