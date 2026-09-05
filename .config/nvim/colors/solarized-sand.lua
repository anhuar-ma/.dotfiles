-- colors/solarized-sand.lua
-- Sandy warm light theme inspired by solarized's selenized palette.
-- Standalone runtime colorscheme: `:colorscheme solarized-sand` works
-- natively. Migrated from the previous config's solarizedLight.lua.f.

if vim.g.colors_name then
  vim.cmd.hi("clear")
end
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.opt.background = "light"
vim.opt.termguicolors = true
vim.g.colors_name = "solarized-sand"

local p = {
  bg = "#f7ecc6",
  bg_alt = "#ecdfb0",
  bg_panel = "#e3d49e",
  bg_dim = "#d8c890",
  bg_sel = "#d8b870",
  bg_sel_dim = "#e6d090",
  border = "#c8a860",

  fg = "#002b36",
  fg_var = "#0e3a48",
  fg_muted = "#586e75",
  fg_dim = "#8a8060",
  fg_dimmest = "#bca878",

  yellow = "#c87a00",
  orange = "#e25822",
  red = "#e53935",
  magenta = "#d81b60",
  violet = "#9c27b0",
  blue = "#1976d2",
  cyan = "#00897b",
  green = "#388e3c",

  diff_add = "#d8e8b8",
  diff_change = "#c8dcec",
  diff_delete = "#f0c8c0",
  diff_text = "#a8d0e8",
}

local set = function(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

set("Normal", { fg = p.fg, bg = p.bg })
set("NormalNC", { fg = p.fg, bg = p.bg })
set("NormalFloat", { fg = p.fg, bg = p.bg_dim })
set("FloatBorder", { fg = p.violet, bg = p.bg_dim })
set("FloatTitle", { fg = p.orange, bg = p.bg_dim, bold = true })

set("Cursor", { fg = p.bg, bg = p.fg })
set("lCursor", { fg = p.bg, bg = p.fg })
set("CursorLine", { bg = p.bg_alt })
set("CursorColumn", { bg = p.bg_alt })
set("ColorColumn", { bg = p.bg_alt })

set("LineNr", { fg = p.fg_dim })
set("CursorLineNr", { fg = p.orange, bold = true })
set("SignColumn", { bg = p.bg })
set("FoldColumn", { fg = p.fg_muted, bg = p.bg })
set("Folded", { fg = p.fg_muted, bg = p.bg_alt, italic = true })

set("Visual", { bg = p.bg_sel })
set("VisualNOS", { bg = p.bg_sel })

set("Search", { fg = p.bg, bg = p.yellow, bold = true })
set("IncSearch", { fg = p.bg, bg = p.orange, bold = true })
set("CurSearch", { fg = p.bg, bg = p.orange, bold = true })
set("Substitute", { fg = p.bg, bg = p.red, bold = true })

set("MatchParen", { fg = p.red, bg = p.bg_sel_dim, bold = true, underline = true })

set("WinSeparator", { fg = p.border })
set("VertSplit", { fg = p.border })

set("StatusLine", { fg = p.fg, bg = p.bg_panel })
set("StatusLineNC", { fg = p.fg_muted, bg = p.bg_alt })

set("TabLine", { fg = p.fg_muted, bg = p.bg_alt })
set("TabLineSel", { fg = p.bg, bg = p.blue, bold = true })
set("TabLineFill", { bg = p.bg_alt })

set("Pmenu", { fg = p.fg, bg = p.bg_panel })
set("PmenuSel", { fg = p.bg, bg = p.blue, bold = true })
set("PmenuSbar", { bg = p.bg_dim })
set("PmenuThumb", { bg = p.violet })
set("WildMenu", { fg = p.bg, bg = p.blue, bold = true })

set("Whitespace", { fg = p.fg_dimmest })
set("NonText", { fg = p.fg_dimmest })
set("EndOfBuffer", { fg = p.bg_alt })
set("Conceal", { fg = p.fg_muted })
set("SpecialKey", { fg = p.fg_dimmest })

set("Title", { fg = p.orange, bold = true })
set("ErrorMsg", { fg = p.red, bold = true })
set("WarningMsg", { fg = p.yellow, bold = true })
set("ModeMsg", { fg = p.green, bold = true })
set("MoreMsg", { fg = p.green })
set("Question", { fg = p.cyan })
set("Directory", { fg = p.blue, bold = true })

set("Comment", { fg = p.fg_muted, italic = true })

set("Constant", { fg = p.magenta })
set("Number", { fg = p.magenta })
set("Float", { fg = p.magenta })
set("Boolean", { fg = p.magenta })
set("Character", { fg = p.cyan })

set("String", { fg = p.cyan })

set("Identifier", { fg = p.fg })
set("Function", { fg = p.blue, bold = true })

set("Statement", { fg = p.green })
set("Conditional", { fg = p.green, italic = true })
set("Repeat", { fg = p.green, italic = true })
set("Label", { fg = p.green })
set("Operator", { fg = p.red })
set("Keyword", { fg = p.green })
set("Exception", { fg = p.red, italic = true })

set("PreProc", { fg = p.orange })
set("Include", { fg = p.orange })
set("Define", { fg = p.orange })
set("Macro", { fg = p.orange })
set("PreCondit", { fg = p.orange })

set("Type", { fg = p.yellow })
set("StorageClass", { fg = p.yellow })
set("Structure", { fg = p.yellow })
set("Typedef", { fg = p.yellow })

set("Special", { fg = p.orange })
set("SpecialChar", { fg = p.orange })
set("Tag", { fg = p.blue })
set("Delimiter", { fg = p.fg })
set("SpecialComment", { fg = p.green, italic = true })
set("Debug", { fg = p.red })

set("Underlined", { underline = true })
set("Ignore", { fg = p.fg_dim })
set("Error", { fg = p.red, bold = true })
set("Todo", { fg = p.magenta, bg = p.bg_alt, bold = true })

set("@comment", { link = "Comment" })
set("@punctuation", { fg = p.fg })
set("@punctuation.bracket", { fg = p.fg })
set("@punctuation.delimiter", { fg = p.fg })
set("@punctuation.special", { fg = p.orange })

set("@string", { fg = p.cyan })
set("@string.escape", { fg = p.orange })
set("@string.regex", { fg = p.violet })
set("@string.special", { fg = p.orange })

set("@number", { fg = p.magenta })
set("@boolean", { fg = p.magenta })
set("@float", { fg = p.magenta })
set("@constant", { fg = p.magenta })
set("@constant.builtin", { fg = p.magenta, italic = true })
set("@constant.macro", { fg = p.orange })

set("@variable", { fg = p.fg })
set("@variable.builtin", { fg = p.violet, italic = true })
set("@variable.parameter", { fg = p.fg_var, italic = true })
set("@variable.member", { fg = p.cyan })
set("@parameter", { fg = p.fg_var, italic = true })
set("@field", { fg = p.cyan })
set("@property", { fg = p.cyan })

set("@function", { fg = p.blue, bold = true })
set("@function.builtin", { fg = p.blue })
set("@function.call", { fg = p.blue })
set("@function.macro", { fg = p.orange })
set("@method", { fg = p.blue })
set("@method.call", { fg = p.blue })
set("@constructor", { fg = p.yellow })

set("@keyword", { fg = p.green })
set("@keyword.function", { fg = p.green, italic = true })
set("@keyword.return", { fg = p.green, italic = true })
set("@keyword.operator", { fg = p.red })
set("@keyword.import", { fg = p.orange, italic = true })
set("@keyword.exception", { fg = p.red, italic = true })
set("@conditional", { fg = p.green, italic = true })
set("@repeat", { fg = p.green, italic = true })
set("@operator", { fg = p.red })
set("@label", { fg = p.green })
set("@include", { fg = p.orange })

set("@type", { fg = p.yellow })
set("@type.builtin", { fg = p.yellow, italic = true })
set("@type.qualifier", { fg = p.green })
set("@type.definition", { fg = p.yellow })

set("@namespace", { fg = p.yellow })
set("@module", { fg = p.yellow })
set("@symbol", { fg = p.magenta })

set("@tag", { fg = p.blue })
set("@tag.attribute", { fg = p.yellow, italic = true })
set("@tag.delimiter", { fg = p.fg })

set("@text", { fg = p.fg })
set("@text.strong", { bold = true })
set("@text.emphasis", { italic = true })
set("@text.underline", { underline = true })
set("@text.title", { fg = p.orange, bold = true })
set("@text.literal", { fg = p.cyan })
set("@text.uri", { fg = p.violet, underline = true })
set("@text.reference", { fg = p.cyan })
set("@text.todo", { link = "Todo" })
set("@text.note", { fg = p.blue, bold = true })
set("@text.warning", { fg = p.yellow, bold = true })
set("@text.danger", { fg = p.red, bold = true })
set("@text.diff.add", { fg = p.green })
set("@text.diff.delete", { fg = p.red })

set("DiagnosticError", { fg = p.red, bold = true })
set("DiagnosticWarn", { fg = p.yellow, bold = true })
set("DiagnosticInfo", { fg = p.blue })
set("DiagnosticHint", { fg = p.cyan })
set("DiagnosticOk", { fg = p.green })
set("DiagnosticVirtualTextError", { fg = p.red, italic = true })
set("DiagnosticVirtualTextWarn", { fg = p.yellow, italic = true })
set("DiagnosticVirtualTextInfo", { fg = p.blue, italic = true })
set("DiagnosticVirtualTextHint", { fg = p.cyan, italic = true })
set("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = p.yellow, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = p.blue, undercurl = true })
set("DiagnosticUnderlineHint", { sp = p.cyan, undercurl = true })

set("DiffAdd", { bg = p.diff_add })
set("DiffChange", { bg = p.diff_change })
set("DiffDelete", { bg = p.diff_delete, fg = p.red })
set("DiffText", { bg = p.diff_text })
set("GitSignsAdd", { fg = p.green })
set("GitSignsChange", { fg = p.yellow })
set("GitSignsDelete", { fg = p.red })
set("GitSignsAddNr", { fg = p.green })
set("GitSignsChangeNr", { fg = p.yellow })
set("GitSignsDeleteNr", { fg = p.red })

set("LspReferenceText", { bg = p.bg_sel_dim })
set("LspReferenceRead", { bg = p.bg_sel_dim })
set("LspReferenceWrite", { bg = p.bg_sel_dim, underline = true })
set("LspSignatureActiveParameter", { fg = p.orange, bold = true })
set("LspInlayHint", { fg = p.fg_dim, italic = true })

set("TelescopeBorder", { fg = p.violet, bg = p.bg_dim })
set("TelescopeNormal", { fg = p.fg, bg = p.bg_dim })
set("TelescopePromptBorder", { fg = p.orange, bg = p.bg_panel })
set("TelescopePromptNormal", { fg = p.fg, bg = p.bg_panel })
set("TelescopePromptPrefix", { fg = p.orange, bg = p.bg_panel })
set("TelescopePromptTitle", { fg = p.bg, bg = p.orange, bold = true })
set("TelescopeResultsTitle", { fg = p.violet, bg = p.bg_dim })
set("TelescopePreviewTitle", { fg = p.green, bg = p.bg_dim })
set("TelescopeSelection", { fg = p.fg, bg = p.bg_sel, bold = true })
set("TelescopeSelectionCaret", { fg = p.red, bg = p.bg_sel })
set("TelescopeMultiSelection", { fg = p.red, bg = p.bg_sel_dim })
set("TelescopeMatching", { fg = p.orange, bold = true })

set("TreesitterContext", { bg = p.bg_alt })
set("TreesitterContextLineNumber", { fg = p.orange, bold = true })

set("NeoTreeNormal", { fg = p.fg, bg = p.bg_panel })
set("NeoTreeNormalNC", { fg = p.fg, bg = p.bg_panel })
set("NeoTreeDirectoryName", { fg = p.blue })
set("NeoTreeRootName", { fg = p.orange, bold = true })
set("NeoTreeGitModified", { fg = p.yellow })
set("NeoTreeGitAdded", { fg = p.green })
set("NeoTreeGitDeleted", { fg = p.red })

set("WhichKey", { fg = p.orange })
set("WhichKeyGroup", { fg = p.blue })
set("WhichKeyDesc", { fg = p.fg })
set("WhichKeySeparator", { fg = p.fg_muted })
set("WhichKeyFloat", { bg = p.bg_dim })

set("IndentBlanklineChar", { fg = p.fg_dimmest })
set("IndentBlanklineContextChar", { fg = p.orange })
set("IblIndent", { fg = p.fg_dimmest })
set("IblScope", { fg = p.orange })

set("@markup.heading.1.markdown", { fg = p.orange, bold = true })
set("@markup.heading.2.markdown", { fg = p.blue, bold = true })
set("@markup.heading.3.markdown", { fg = p.green, bold = true })
set("@markup.heading.4.markdown", { fg = p.violet, bold = true })
set("@markup.heading.5.markdown", { fg = p.cyan, bold = true })
set("@markup.heading.6.markdown", { fg = p.magenta, bold = true })
set("@markup.link.label", { fg = p.blue, underline = true })
set("@markup.link.url", { fg = p.violet, underline = true })
set("@markup.list", { fg = p.orange })
set("@markup.raw", { fg = p.cyan })
set("@markup.raw.block", { fg = p.cyan })
set("@markup.quote", { fg = p.fg_muted, italic = true })
set("@markup.strong", { bold = true })
set("@markup.italic", { italic = true })
