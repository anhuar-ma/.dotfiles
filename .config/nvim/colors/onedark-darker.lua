-- colors/onedark-darker.lua
-- onedark.nvim "darker" variant. Thin runtime wrapper: `:colorscheme
-- onedark-darker` reconfigures the already-loaded onedark plugin with its
-- built-in "darker" style (the darkest background). The plugin itself is
-- installed by lua/plugins/ui/onedark.lua.
--
-- Note: `:colorscheme onedark` is the customized "bright" variant; these
-- onedark-* files are the plain built-in styles.

local ok, onedark = pcall(require, "onedark")
if not ok then
  return
end

onedark.setup({
  style = "darker",
  term_colors = true,
  code_style = { comments = "italic" },
})
onedark.load()
