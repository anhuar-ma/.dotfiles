-- colors/black-and-white.lua
-- Pure grayscale typography-first theme. `:colorscheme black-and-white`
-- works natively. Migrated from the previous config's grayscale ColorScheme
-- autocmd (onedark.lua.bak). Relies on bold/italic/underline/undercurl for
-- emphasis since no hues are used.

if vim.g.colors_name then
  vim.cmd.hi("clear")
end
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "black-and-white"

local bg = "#000000"
local ui_bg = "#1a1a1a"
local guide = "#444444"
local comment = "#777777"
local text = "#c0c0c0"
local bright = "#ffffff"

local set = function(g, o)
  vim.api.nvim_set_hl(0, g, o)
end

-- Base editor
set("Normal", { fg = text, bg = bg })
set("NormalNC", { fg = text, bg = bg })
set("NormalFloat", { fg = text, bg = ui_bg })
set("FloatBorder", { fg = guide, bg = ui_bg })
set("LineNr", { fg = guide })
set("CursorLineNr", { fg = bright, bold = true })
set("CursorLine", { bg = ui_bg })
set("ColorColumn", { bg = ui_bg })
set("SignColumn", { bg = bg })
set("EndOfBuffer", { fg = bg })

-- UI elements & highlighting
set("Visual", { reverse = true })
set("Search", { reverse = true, bold = true })
set("IncSearch", { reverse = true, bold = true })
set("CurSearch", { reverse = true, bold = true })
set("MatchParen", { fg = bright, bg = guide, bold = true })
set("Pmenu", { fg = text, bg = ui_bg })
set("PmenuSel", { fg = bg, bg = bright, bold = true })
set("StatusLine", { fg = bright, bg = ui_bg, bold = true })
set("StatusLineNC", { fg = comment, bg = bg })
set("WinSeparator", { fg = guide })
set("VertSplit", { fg = guide })

-- Core syntax (typography is king here)
set("Comment", { fg = comment, italic = true })
set("String", { fg = text, italic = true })
set("Number", { fg = bright })
set("Boolean", { fg = bright, bold = true })

set("Identifier", { fg = text })
set("Function", { fg = bright, bold = true })
set("Statement", { fg = bright, bold = true })
set("Conditional", { fg = bright, bold = true })
set("Repeat", { fg = bright, bold = true })
set("Operator", { fg = text })
set("Keyword", { fg = bright, bold = true })

set("Type", { fg = bright, underline = true })
set("Constant", { fg = bright })
set("Special", { fg = bright })

-- TreeSitter overrides
set("@variable", { fg = text })
set("@function.builtin", { fg = bright, bold = true, italic = true })
set("@constructor", { fg = bright, bold = true, underline = true })
set("@keyword", { fg = bright, bold = true })
set("@string", { fg = text, italic = true })
set("@type", { fg = bright, underline = true })

-- Diagnostics (no hues -> use text styles)
set("DiagnosticError", { fg = bright, bold = true, undercurl = true })
set("DiagnosticWarn", { fg = text, bold = true, underline = true })
set("DiagnosticInfo", { fg = text, italic = true })
set("DiagnosticHint", { fg = comment, italic = true })
set("DiagnosticUnderlineError", { undercurl = true, sp = bright })
set("DiagnosticUnderlineWarn", { underline = true, sp = text })
