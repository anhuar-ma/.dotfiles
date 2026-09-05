-- lua/plugins/ui/onedark.lua
-- onedark.nvim — "bright" variant: high-contrast, medium-dark slate background
-- with vivid saturated accents. This is the ACTIVE theme (selected in
-- lua/plugins/ui/colorscheme.lua). Migrated from the previous config's
-- onedark_bright.lua. Only the colorscheme selection was moved out; the full
-- palette/highlight customization (including the Snacks picker/explorer fix)
-- is kept here.

return {
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = false,
    priority = 1000,
    opts = function()
      local bg0 = "#262d3c"
      local bg_alt = "#313847"
      local sel_bg = "#6076a8"
      local border_fg = "#525c75"

      local c = {
        bg0 = bg0,
        bg1 = bg_alt,
        bg2 = "#3b4358",
        bg3 = "#454e63",
        bg_d = bg0,
        bg_blue = "#68aee8",
        bg_yellow = "#fad07a",

        fg = "#ffffff",
        light_grey = "#dde4f1",
        grey = "#a0acc0",

        red = "#ff5c77",
        green = "#6cf09b",
        yellow = "#ffe26b",
        blue = "#52a5ff",
        purple = "#d99df8",
        cyan = "#5ce2ff",
        orange = "#ffbd5e",

        dark_red = "#c84e63",
        dark_yellow = "#d4b859",
        dark_purple = "#a87bc4",
      }

      return {
        style = "deep",
        transparent = false,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,

        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "bold",
          strings = "none",
          variables = "none",
        },

        diagnostics = {
          darker = false,
          undercurl = true,
          background = false,
        },

        colors = c,

        highlights = {
          Normal = { fg = "$fg", bg = bg0 },
          NormalNC = { fg = "$fg", bg = bg0 },
          NormalFloat = { fg = "$fg", bg = bg0 },
          EndOfBuffer = { fg = bg0, bg = bg0 },
          MsgArea = { fg = "$fg", bg = bg0 },
          WinBar = { fg = "$fg", bg = bg0, fmt = "bold" },
          WinBarNC = { fg = "$grey", bg = bg0 },

          Visual = { bg = sel_bg },
          VisualNOS = { bg = sel_bg },

          Search = { fg = bg0, bg = "$yellow", fmt = "bold" },
          IncSearch = { fg = bg0, bg = "$orange", fmt = "bold" },
          CurSearch = { fg = bg0, bg = "$orange", fmt = "bold" },
          Substitute = { fg = bg0, bg = "$red", fmt = "bold" },

          CursorLine = { bg = bg_alt },
          CursorLineNr = { fg = "$yellow", fmt = "bold" },
          LineNr = { fg = "#7c8aa0" },
          SignColumn = { bg = bg0 },

          MatchParen = { fg = "$orange", bg = sel_bg, fmt = "bold,underline" },

          Comment = { fg = "#b6c1d6", fmt = "italic" },

          Pmenu = { fg = "$fg", bg = bg_alt },
          PmenuSel = { fg = bg0, bg = "$blue", fmt = "bold" },
          PmenuSbar = { bg = "#404758" },
          PmenuThumb = { bg = "$blue" },

          WinSeparator = { fg = border_fg },
          VertSplit = { fg = border_fg },
          FloatBorder = { fg = "$blue", bg = bg0 },

          StatusLine = { fg = "$fg", bg = bg_alt },
          StatusLineNC = { fg = "$grey", bg = bg0 },
          TabLine = { fg = "$grey", bg = bg0 },
          TabLineSel = { fg = bg0, bg = "$blue", fmt = "bold" },
          TabLineFill = { bg = bg0 },

          Folded = { fg = "$light_grey", bg = bg_alt, fmt = "italic" },
          FoldColumn = { fg = "$grey", bg = bg0 },

          DiagnosticError = { fg = "$red", fmt = "bold" },
          DiagnosticWarn = { fg = "$yellow", fmt = "bold" },
          DiagnosticInfo = { fg = "$cyan" },
          DiagnosticHint = { fg = "$green" },
          DiagnosticVirtualTextError = { fg = "$red", fmt = "italic" },
          DiagnosticVirtualTextWarn = { fg = "$yellow", fmt = "italic" },
          DiagnosticVirtualTextInfo = { fg = "$cyan", fmt = "italic" },
          DiagnosticVirtualTextHint = { fg = "$green", fmt = "italic" },
          DiagnosticUnderlineError = { sp = "$red", fmt = "undercurl" },
          DiagnosticUnderlineWarn = { sp = "$yellow", fmt = "undercurl" },
          DiagnosticUnderlineInfo = { sp = "$cyan", fmt = "undercurl" },
          DiagnosticUnderlineHint = { sp = "$green", fmt = "undercurl" },

          LspReferenceText = { bg = bg_alt },
          LspReferenceRead = { bg = bg_alt },
          LspReferenceWrite = { bg = bg_alt, fmt = "underline" },
          LspSignatureActiveParameter = { fg = "$orange", fmt = "bold" },
          LspInlayHint = { fg = "$grey", fmt = "italic" },

          GitSignsAdd = { fg = "$green" },
          GitSignsChange = { fg = "$yellow" },
          GitSignsDelete = { fg = "$red" },
          GitSignsAddNr = { fg = "$green" },
          GitSignsChangeNr = { fg = "$yellow" },
          GitSignsDeleteNr = { fg = "$red" },
          GitSignsAddInline = { bg = "#1f3a28" },
          GitSignsChangeInline = { bg = "#3a3320" },
          GitSignsDeleteInline = { bg = "#3a1f24" },

          TelescopeBorder = { fg = "$blue", bg = bg0 },
          TelescopeNormal = { fg = "$fg", bg = bg0 },
          TelescopePromptBorder = { fg = "$blue", bg = bg_alt },
          TelescopePromptNormal = { fg = "$fg", bg = bg_alt },
          TelescopePromptPrefix = { fg = "$orange", bg = bg_alt },
          TelescopePromptTitle = { fg = bg0, bg = "$orange", fmt = "bold" },
          TelescopeResultsTitle = { fg = "$blue", bg = bg0 },
          TelescopePreviewTitle = { fg = "$green", bg = bg0 },
          TelescopeSelection = { fg = "$fg", bg = sel_bg, fmt = "bold" },
          TelescopeSelectionCaret = { fg = "$orange", bg = sel_bg },
          TelescopeMatching = { fg = "$yellow", fmt = "bold" },

          ["@variable"] = { fg = "$fg" },
          ["@variable.builtin"] = { fg = "$red", fmt = "italic" },
          ["@variable.parameter"] = { fg = "$light_grey", fmt = "italic" },
          ["@parameter"] = { fg = "$light_grey", fmt = "italic" },
          ["@field"] = { fg = "$cyan" },
          ["@property"] = { fg = "$cyan" },

          ["@string"] = { fg = "$green" },
          ["@string.escape"] = { fg = "$orange", fmt = "bold" },
          ["@string.regex"] = { fg = "$purple" },

          ["@number"] = { fg = "$purple" },
          ["@boolean"] = { fg = "$purple", fmt = "bold" },
          ["@float"] = { fg = "$purple" },

          ["@constant"] = { fg = "$purple" },
          ["@constant.builtin"] = { fg = "$purple", fmt = "bold,italic" },
          ["@constant.macro"] = { fg = "$orange" },

          ["@function"] = { fg = "$blue", fmt = "bold" },
          ["@function.builtin"] = { fg = "$blue", fmt = "bold,italic" },
          ["@function.macro"] = { fg = "$orange", fmt = "bold" },
          ["@method"] = { fg = "$blue" },
          ["@constructor"] = { fg = "$yellow", fmt = "bold" },

          ["@keyword"] = { fg = "$purple", fmt = "bold" },
          ["@keyword.function"] = { fg = "$purple", fmt = "bold,italic" },
          ["@keyword.return"] = { fg = "$red", fmt = "bold,italic" },
          ["@keyword.operator"] = { fg = "$red" },
          ["@keyword.import"] = { fg = "$orange", fmt = "italic" },
          ["@conditional"] = { fg = "$purple", fmt = "italic" },
          ["@repeat"] = { fg = "$purple", fmt = "italic" },
          ["@operator"] = { fg = "$red" },
          ["@type"] = { fg = "$yellow" },
          ["@type.builtin"] = { fg = "$yellow", fmt = "italic" },
          ["@namespace"] = { fg = "$yellow" },
          ["@module"] = { fg = "$yellow" },

          ["@tag"] = { fg = "$blue" },
          ["@tag.attribute"] = { fg = "$yellow", fmt = "italic" },
          ["@tag.delimiter"] = { fg = "$grey" },

          ["@punctuation.special"] = { fg = "$orange" },

          Whitespace = { fg = "#464f64" },
          NonText = { fg = "#464f64" },
          IndentBlanklineChar = { fg = "#464f64" },
          IblIndent = { fg = "#464f64" },
          IblScope = { fg = "$orange" },

          ColorColumn = { bg = bg_alt },
          Cursor = { fg = bg0, bg = "$fg" },

          ["@markup.heading.1.markdown"] = { fg = "$orange", fmt = "bold" },
          ["@markup.heading.2.markdown"] = { fg = "$blue", fmt = "bold" },
          ["@markup.heading.3.markdown"] = { fg = "$green", fmt = "bold" },
          ["@markup.heading.4.markdown"] = { fg = "$purple", fmt = "bold" },
          ["@markup.heading.5.markdown"] = { fg = "$cyan", fmt = "bold" },
          ["@markup.heading.6.markdown"] = { fg = "$red", fmt = "bold" },
          ["@markup.link.label"] = { fg = "$blue", fmt = "underline" },
          ["@markup.link.url"] = { fg = "$purple", fmt = "underline" },
          ["@markup.list"] = { fg = "$orange" },
          ["@markup.raw"] = { fg = "$cyan" },
          ["@markup.quote"] = { fg = "$grey", fmt = "italic" },
        },
      }
    end,

    config = function(_, opts)
      require("onedark").setup(opts)
      if vim.g.colors_name == nil or vim.g.colors_name:match("^onedark") then
        require("onedark").load()
      end

      local light_grey = "#dde4f1"
      local grey = "#a0acc0"
      local red = "#ff5c77"
      local green = "#6cf09b"
      local yellow = "#ffe26b"
      local blue = "#52a5ff"
      local purple = "#d99df8"
      local cyan = "#5ce2ff"
      local orange = "#ffbd5e"
      local bg0 = "#262d3c"
      local bg_alt = "#313847"
      local sel_bg = "#6076a8"

      local set = vim.api.nvim_set_hl

      local function hex(group, attr)
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
        if ok and hl and hl[attr] then
          return string.format("#%06x", hl[attr])
        end
      end

      local function apply_explorer_hl()
        local normal_bg = hex("Normal", "bg") or bg0
        local normal_fg = hex("Normal", "fg") or "#ffffff"

        set(0, "SnacksPicker", { fg = normal_fg, bg = normal_bg })
        set(0, "SnacksPickerBorder", { fg = blue, bg = normal_bg })
        set(0, "SnacksPickerTitle", { fg = normal_bg, bg = orange, bold = true })

        set(0, "SnacksPickerInput", { fg = normal_fg, bg = bg_alt })
        set(0, "SnacksPickerInputBorder", { fg = orange, bg = bg_alt })
        set(0, "SnacksPickerInputTitle", { fg = normal_bg, bg = orange, bold = true })

        set(0, "SnacksPickerList", { fg = normal_fg, bg = normal_bg })
        set(0, "SnacksPickerListBorder", { fg = blue, bg = normal_bg })
        set(0, "SnacksPickerListTitle", { fg = blue, bg = normal_bg, bold = true })

        set(0, "SnacksPickerPreview", { fg = normal_fg, bg = normal_bg })
        set(0, "SnacksPickerPreviewBorder", { fg = blue, bg = normal_bg })
        set(0, "SnacksPickerPreviewTitle", { fg = green, bg = normal_bg, bold = true })

        set(0, "SnacksPickerCursorLine", { bg = sel_bg })
        set(0, "SnacksPickerSelected", { fg = orange, bold = true })
        set(0, "SnacksPickerMatch", { fg = yellow, bold = true })

        set(0, "SnacksPickerDir", { fg = blue, bold = true })
        set(0, "SnacksPickerFile", { fg = normal_fg })
        set(0, "SnacksPickerPathHidden", { fg = light_grey, italic = true })
        set(0, "SnacksPickerPathIgnored", { fg = light_grey, italic = true })
        set(0, "SnacksPickerDimmed", { fg = light_grey })
        set(0, "SnacksPickerTree", { fg = grey })
        set(0, "SnacksPickerDelim", { fg = grey })
        set(0, "SnacksPickerSpecial", { fg = orange })
        set(0, "SnacksPickerKey", { fg = orange, bold = true })
        set(0, "SnacksPickerLabel", { fg = purple })
        set(0, "SnacksPickerDesc", { fg = light_grey })
        set(0, "SnacksPickerLineNr", { fg = grey })
        set(0, "SnacksPickerTotals", { fg = grey })
        set(0, "SnacksPickerToggle", { fg = orange })
        set(0, "SnacksPickerKeymap", { fg = cyan })
        set(0, "SnacksPickerBufFlags", { fg = orange })

        set(0, "SnacksPickerGitStatusUntracked", { fg = green, italic = true })
        set(0, "SnacksPickerGitStatusIgnored", { fg = light_grey, italic = true })
        set(0, "SnacksPickerGitStatusModified", { fg = yellow })
        set(0, "SnacksPickerGitStatusAdded", { fg = green })
        set(0, "SnacksPickerGitStatusDeleted", { fg = red })
        set(0, "SnacksPickerGitStatusRenamed", { fg = purple })
        set(0, "SnacksPickerGitStatusStaged", { fg = green, bold = true })
        set(0, "SnacksPickerGitStatusUnmerged", { fg = red, bold = true })

        set(0, "SnacksPickerGitBranch", { fg = orange, bold = true })
        set(0, "SnacksPickerGitCommit", { fg = yellow })
        set(0, "SnacksPickerGitDate", { fg = grey })

        set(0, "SnacksDashboard", { fg = normal_fg, bg = normal_bg })
        set(0, "SnacksDashboardHeader", { fg = orange, bold = true })
        set(0, "SnacksDashboardTitle", { fg = blue, bold = true })
        set(0, "SnacksDashboardKey", { fg = orange, bold = true })
        set(0, "SnacksDashboardDesc", { fg = normal_fg })
        set(0, "SnacksDashboardIcon", { fg = cyan })
        set(0, "SnacksDashboardFooter", { fg = grey, italic = true })
      end

      apply_explorer_hl()

      local grp = vim.api.nvim_create_augroup("OnedarkBrightExplorerFix", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = grp,
        callback = function()
          vim.schedule(apply_explorer_hl)
        end,
      })

      vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
        group = grp,
        pattern = {
          "snacks_picker_list",
          "snacks_picker_input",
          "snacks_picker_preview",
          "snacks_dashboard",
        },
        callback = function()
          vim.schedule(apply_explorer_hl)
        end,
      })
    end,
  },
}
