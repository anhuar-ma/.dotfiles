-- colors/shades-of-purple.lua
-- High-contrast Neovim port of "Shades of Purple" by Ahmad Awais.
-- Standalone runtime colorscheme: `:colorscheme shades-of-purple` works
-- natively (LazyVim selects it via lua/plugins/ui/colorscheme.lua). Migrated
-- from the previous config's shadesOfPurple.lua.f.

if vim.g.colors_name then
  vim.cmd.hi("clear")
end
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "shades-of-purple"

local p = {
  bg = "#2D2B55",
  bg_alt = "#1F1F41",
  bg_panel = "#1E1E3F",
  bg_dim = "#161633",
  bg_sel = "#6943FF",
  bg_sel_dim = "#3D2A7A",
  border = "#222244",
  border_acc = "#FAD000",

  fg = "#FFFFFF",
  fg_var = "#E1EFFF",
  fg_muted = "#A599E9",
  fg_dim = "#6B5994",
  fg_dimmest = "#494685",

  purple = "#B362FF",
  violet = "#FB94FF",
  pink = "#FF628C",
  orange = "#FF9D00",
  gold = "#FAD000",
  pale_gold = "#FFEE80",
  cyan = "#9EFFFF",
  mint = "#80FFBB",
  green = "#A5FF90",
  green_alt = "#3AD900",

  red = "#EC3A37",
  red_soft = "#F16E6B",
}

local set = function(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

set("Normal", { fg = p.fg, bg = p.bg })
set("NormalNC", { fg = p.fg, bg = p.bg })
set("NormalFloat", { fg = p.fg, bg = p.bg_dim })
set("FloatBorder", { fg = p.purple, bg = p.bg_dim })
set("FloatTitle", { fg = p.gold, bg = p.bg_dim, bold = true })

set("Cursor", { fg = p.bg, bg = p.gold })
set("lCursor", { fg = p.bg, bg = p.gold })
set("CursorLine", { bg = p.bg_alt })
set("CursorColumn", { bg = p.bg_alt })
set("ColorColumn", { bg = p.bg_alt })

set("LineNr", { fg = p.fg_dim })
set("CursorLineNr", { fg = p.gold, bold = true })
set("SignColumn", { bg = p.bg })
set("FoldColumn", { fg = p.fg_muted, bg = p.bg })
set("Folded", { fg = p.fg_muted, bg = p.bg_alt, italic = true })

set("Visual", { bg = p.bg_sel })
set("VisualNOS", { bg = p.bg_sel })

set("Search", { fg = p.bg, bg = p.gold, bold = true })
set("IncSearch", { fg = p.bg, bg = p.orange, bold = true })
set("CurSearch", { fg = p.bg, bg = p.orange, bold = true })
set("Substitute", { fg = p.bg, bg = p.pink, bold = true })

set("MatchParen", { fg = p.gold, bg = p.bg_sel_dim, bold = true, underline = true })

set("WinSeparator", { fg = p.border })
set("VertSplit", { fg = p.border })

set("StatusLine", { fg = p.fg_muted, bg = p.bg_panel })
set("StatusLineNC", { fg = p.fg_dim, bg = p.bg_panel })

set("TabLine", { fg = p.fg_muted, bg = p.bg })
set("TabLineSel", { fg = p.fg, bg = p.bg_panel, bold = true })
set("TabLineFill", { bg = p.bg })

set("Pmenu", { fg = p.fg, bg = p.bg_panel })
set("PmenuSel", { fg = p.bg, bg = p.gold, bold = true })
set("PmenuSbar", { bg = p.bg_alt })
set("PmenuThumb", { bg = p.purple })
set("WildMenu", { fg = p.bg, bg = p.gold, bold = true })

set("Whitespace", { fg = p.fg_dimmest })
set("NonText", { fg = p.fg_dimmest })
set("EndOfBuffer", { fg = p.bg })
set("Conceal", { fg = p.fg_muted })
set("SpecialKey", { fg = p.fg_dimmest })

set("Title", { fg = p.gold, bold = true })
set("ErrorMsg", { fg = p.red, bold = true })
set("WarningMsg", { fg = p.gold, bold = true })
set("ModeMsg", { fg = p.gold, bold = true })
set("MoreMsg", { fg = p.green_alt })
set("Question", { fg = p.gold })
set("Directory", { fg = p.cyan })

set("Comment", { fg = p.purple, italic = true })

set("Constant", { fg = p.pink })
set("Number", { fg = p.pink })
set("Float", { fg = p.pink })
set("Boolean", { fg = p.pink })
set("Character", { fg = p.green })

set("String", { fg = p.green })

set("Identifier", { fg = p.fg_var })
set("Function", { fg = p.gold, bold = true })

set("Statement", { fg = p.orange })
set("Conditional", { fg = p.orange, italic = true })
set("Repeat", { fg = p.orange, italic = true })
set("Label", { fg = p.orange })
set("Operator", { fg = p.orange })
set("Keyword", { fg = p.orange })
set("Exception", { fg = p.orange, italic = true })

set("PreProc", { fg = p.gold })
set("Include", { fg = p.orange })
set("Define", { fg = p.orange })
set("Macro", { fg = p.gold })
set("PreCondit", { fg = p.orange })

set("Type", { fg = p.cyan })
set("StorageClass", { fg = p.gold })
set("Structure", { fg = p.cyan })
set("Typedef", { fg = p.cyan })

set("Special", { fg = p.pale_gold })
set("SpecialChar", { fg = p.pale_gold })
set("Tag", { fg = p.cyan })
set("Delimiter", { fg = p.fg_var })
set("SpecialComment", { fg = p.gold, italic = true })
set("Debug", { fg = p.red })

set("Underlined", { underline = true })
set("Ignore", { fg = p.fg_dimmest })
set("Error", { fg = p.red, bold = true })
set("Todo", { fg = p.gold, bg = p.bg_alt, bold = true })

set("@comment", { link = "Comment" })
set("@punctuation", { fg = p.fg_var })
set("@punctuation.bracket", { fg = p.fg_var })
set("@punctuation.delimiter", { fg = p.fg_var })
set("@punctuation.special", { fg = p.pale_gold })

set("@string", { fg = p.green })
set("@string.escape", { fg = p.pale_gold })
set("@string.regex", { fg = p.violet })
set("@string.special", { fg = p.pale_gold })

set("@number", { fg = p.pink })
set("@boolean", { fg = p.pink })
set("@float", { fg = p.pink })
set("@constant", { fg = p.pink })
set("@constant.builtin", { fg = p.pink, italic = true })
set("@constant.macro", { fg = p.gold })

set("@variable", { fg = p.fg_var })
set("@variable.builtin", { fg = p.violet, italic = true })
set("@variable.parameter", { fg = p.cyan, italic = true })
set("@variable.member", { fg = p.pale_gold })
set("@parameter", { fg = p.cyan, italic = true })
set("@field", { fg = p.pale_gold })
set("@property", { fg = p.pale_gold })

set("@function", { fg = p.gold, bold = true })
set("@function.builtin", { fg = p.orange })
set("@function.call", { fg = p.gold })
set("@function.macro", { fg = p.gold })
set("@method", { fg = p.mint })
set("@method.call", { fg = p.mint })
set("@constructor", { fg = p.cyan })

set("@keyword", { fg = p.orange })
set("@keyword.function", { fg = p.violet, italic = true })
set("@keyword.return", { fg = p.orange, italic = true })
set("@keyword.operator", { fg = p.orange })
set("@keyword.import", { fg = p.orange, italic = true })
set("@keyword.exception", { fg = p.orange, italic = true })
set("@conditional", { fg = p.orange, italic = true })
set("@repeat", { fg = p.orange, italic = true })
set("@operator", { fg = p.orange })
set("@label", { fg = p.orange })
set("@include", { fg = p.orange })

set("@type", { fg = p.cyan })
set("@type.builtin", { fg = p.cyan, italic = true })
set("@type.qualifier", { fg = p.gold })
set("@type.definition", { fg = p.cyan })

set("@namespace", { fg = p.cyan })
set("@module", { fg = p.cyan })
set("@symbol", { fg = p.pink })

set("@tag", { fg = p.cyan })
set("@tag.attribute", { fg = p.gold, italic = true })
set("@tag.delimiter", { fg = p.fg_var })

set("@text", { fg = p.fg })
set("@text.strong", { bold = true })
set("@text.emphasis", { italic = true })
set("@text.underline", { underline = true })
set("@text.title", { fg = p.gold, bold = true })
set("@text.literal", { fg = p.cyan })
set("@text.uri", { fg = p.violet, underline = true })
set("@text.reference", { fg = p.cyan })
set("@text.todo", { link = "Todo" })
set("@text.note", { fg = p.cyan, bold = true })
set("@text.warning", { fg = p.gold, bold = true })
set("@text.danger", { fg = p.red, bold = true })
set("@text.diff.add", { fg = p.green_alt })
set("@text.diff.delete", { fg = p.red_soft })

set("DiagnosticError", { fg = p.red, bold = true })
set("DiagnosticWarn", { fg = p.gold, bold = true })
set("DiagnosticInfo", { fg = p.cyan })
set("DiagnosticHint", { fg = p.mint })
set("DiagnosticOk", { fg = p.green_alt })
set("DiagnosticVirtualTextError", { fg = p.red, italic = true })
set("DiagnosticVirtualTextWarn", { fg = p.gold, italic = true })
set("DiagnosticVirtualTextInfo", { fg = p.cyan, italic = true })
set("DiagnosticVirtualTextHint", { fg = p.mint, italic = true })
set("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = p.gold, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = p.cyan, undercurl = true })
set("DiagnosticUnderlineHint", { sp = p.mint, undercurl = true })

set("DiffAdd", { bg = "#1F4030" })
set("DiffChange", { bg = "#1F2F50" })
set("DiffDelete", { bg = "#3F1F2A", fg = p.red_soft })
set("DiffText", { bg = "#2F4F70" })
set("GitSignsAdd", { fg = p.green_alt })
set("GitSignsChange", { fg = p.gold })
set("GitSignsDelete", { fg = p.red })
set("GitSignsAddNr", { fg = p.green_alt })
set("GitSignsChangeNr", { fg = p.gold })
set("GitSignsDeleteNr", { fg = p.red })

set("LspReferenceText", { bg = p.bg_sel_dim })
set("LspReferenceRead", { bg = p.bg_sel_dim })
set("LspReferenceWrite", { bg = p.bg_sel_dim, underline = true })
set("LspSignatureActiveParameter", { fg = p.gold, bold = true })
set("LspInlayHint", { fg = p.fg_dim, italic = true })

set("TelescopeBorder", { fg = p.purple, bg = p.bg_dim })
set("TelescopeNormal", { fg = p.fg, bg = p.bg_dim })
set("TelescopePromptBorder", { fg = p.gold, bg = p.bg_panel })
set("TelescopePromptNormal", { fg = p.fg, bg = p.bg_panel })
set("TelescopePromptPrefix", { fg = p.orange, bg = p.bg_panel })
set("TelescopePromptTitle", { fg = p.bg, bg = p.gold, bold = true })
set("TelescopeResultsTitle", { fg = p.purple, bg = p.bg_dim })
set("TelescopePreviewTitle", { fg = p.green_alt, bg = p.bg_dim })
set("TelescopeSelection", { fg = p.fg, bg = p.bg_sel, bold = true })
set("TelescopeSelectionCaret", { fg = p.gold, bg = p.bg_sel })
set("TelescopeMultiSelection", { fg = p.gold, bg = p.bg_sel_dim })
set("TelescopeMatching", { fg = p.gold, bold = true })

set("TreesitterContext", { bg = p.bg_alt })
set("TreesitterContextLineNumber", { fg = p.gold, bold = true })

set("NeoTreeNormal", { fg = p.fg_muted, bg = p.bg_panel })
set("NeoTreeNormalNC", { fg = p.fg_muted, bg = p.bg_panel })
set("NeoTreeDirectoryName", { fg = p.cyan })
set("NeoTreeRootName", { fg = p.gold, bold = true })
set("NeoTreeGitModified", { fg = p.gold })
set("NeoTreeGitAdded", { fg = p.green_alt })
set("NeoTreeGitDeleted", { fg = p.red })

set("WhichKey", { fg = p.gold })
set("WhichKeyGroup", { fg = p.cyan })
set("WhichKeyDesc", { fg = p.fg })
set("WhichKeySeparator", { fg = p.fg_dim })
set("WhichKeyFloat", { bg = p.bg_dim })

set("IndentBlanklineChar", { fg = p.fg_dimmest })
set("IndentBlanklineContextChar", { fg = p.gold })
set("IblIndent", { fg = "#2A2855" })
set("IblScope", { fg = p.purple })

set("SnippetTabstop", { bg = p.bg_sel_dim })

set("@markup.heading.1.markdown", { fg = p.gold, bold = true })
set("@markup.heading.2.markdown", { fg = p.cyan, bold = true })
set("@markup.heading.3.markdown", { fg = p.mint, bold = true })
set("@markup.heading.4.markdown", { fg = p.gold, bold = true })
set("@markup.heading.5.markdown", { fg = p.cyan, bold = true })
set("@markup.heading.6.markdown", { fg = p.mint, bold = true })
set("@markup.link.label", { fg = p.gold, underline = true })
set("@markup.link.url", { fg = p.fg_muted, underline = true })
set("@markup.list", { fg = p.gold })
set("@markup.raw", { fg = p.cyan })
set("@markup.raw.block", { fg = p.cyan })
set("@markup.quote", { fg = p.fg_muted, italic = true })
set("@markup.strong", { bold = true })
set("@markup.italic", { italic = true })
