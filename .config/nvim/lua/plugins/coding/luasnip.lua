-- lua/plugins/coding/luasnip.lua
-- LuaSnip: snippet engine. LazyVim already depends on LuaSnip; this spec
-- extends it with friendly-snippets and loads the user's competitive-
-- programming C++ snippets. Migrated from the previous config.
--
-- Improvement over the old config: the custom snippets were stored under
-- lua/plugins/snippets/, which lazy.nvim treats as plugin spec files (it
-- imports everything under lua/plugins/). They are now relocated to
-- lua/snippets/cpp/ — outside the plugin import path — and loaded explicitly
-- via an absolute path built from stdpath("config"), so they load reliably
-- regardless of the current working directory.

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- pre-made snippets for many languages
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Load the relocated Lua snippets (lua/snippets/<ft>/*.lua).
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })

      -- Enable friendly-snippets (VSCode-style).
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Inline C++ snippets, matching the macros defined in
      -- templates/main.cpp (fo/foi/fod/foe/foa/rep and the de/deln debug
      -- macros). Each loop snippet expands to the macro invocation plus a
      -- braced body so it reads the same as the template helpers.
      ls.add_snippets("cpp", {
        -- Lambda expression scaffold.
        s("lambda", {
          t({ "auto " }),
          i(1, "lambda"),
          t({ " = [" }),
          i(2, "capture"),
          t({ "](" }),
          i(3, "args"),
          t({ ") {" }),
          t({ "", "\t" }),
          i(0),
          t({ "", "};" }),
        }),

        -- fo(i, n) -> for i in [0, n)
        s("fo", {
          t("fo("),
          i(1, "i"),
          t(", "),
          i(2, "n"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- foi(i, a, b) -> for i in [a, b)
        s("foi", {
          t("foi("),
          i(1, "i"),
          t(", "),
          i(2, "a"),
          t(", "),
          i(3, "b"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- fod(i, a, b) -> for i from a down to b (exclusive)
        s("fod", {
          t("fod("),
          i(1, "i"),
          t(", "),
          i(2, "a"),
          t(", "),
          i(3, "b"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- foe(i, a, b) -> for i in [a, b]
        s("foe", {
          t("foe("),
          i(1, "i"),
          t(", "),
          i(2, "a"),
          t(", "),
          i(3, "b"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- foa(x, c) -> range-for over container c
        s("foa", {
          t("foa("),
          i(1, "x"),
          t(", "),
          i(2, "c"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- rep(n) -> repeat n times
        s("rep", {
          t("rep("),
          i(1, "n"),
          t({ ") {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),

        -- de(...) -> debug-print variables (no-op unless compiled with -DLOCAL)
        s("de", {
          t("de("),
          i(1, "x"),
          t(");"),
        }),

        -- deln(x) -> debug-print a container, one element per line
        s("deln", {
          t("deln("),
          i(1, "x"),
          t(");"),
        }),
      })
    end,
  },
}
