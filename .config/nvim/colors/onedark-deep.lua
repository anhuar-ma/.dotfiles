-- colors/onedark-deep.lua
-- onedark.nvim "deep" variant — darker, blue-tinted background. Thin runtime
-- wrapper around the plugin installed by lua/plugins/ui/onedark.lua.

local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup({
  style = "deep",
  term_colors = true,
  code_style = { comments = "italic" },
})
onedark.load()
