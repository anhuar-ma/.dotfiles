return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Optional: For pre-made snippets
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt -- For formatted snippets

    -- Add a custom C++ snippet
    -- ls.add_snippets("cpp", {
    --   s("forloop", {
    --     t({ "for (int i = 0; i < " }),
    --     i(1, "n"),
    --     t({ "; i++) {", "\t" }),
    --     i(0),
    --     t({ "", "}" }),
    --   }),
    -- })

    -- Add custom C++ snippets
    ls.add_snippets("cpp", {
      -- Lambda snippet
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

      -- Template snippet
      s(
        "#template",
        fmt(
          [[
#include <bits/stdc++.h>

// #undef DEBUG
#if DEBUG
#include "debugging.h"
#define deb(x) std::cout << #x << "=" << x << std::endl
#define deb2(x, y) std::cout << #x << "=" << x << "," << #y << "=" << y << std::endl
#else
#define deb(x)
#define deb2(x, y)
#endif

using namespace std;
#define gc getchar_unlocked
#define fo(i, n) for (int i = 0; i < n; i++)
#define Foi(i, k, n) for (int i = k; i < n; i++)
#define Fod(i, k, n) for (int i = k; i > n; i--)
#define ll long long
#define printn(x) cout << x << '\n'
#define print(x) cout << x << ' '
#define pb push_back
#define mp make_pair
#define F first
#define S second
#define all(x) x.begin(), x.end()
#define clr(x) memset(x, 0, sizeof(x))
#define sortall(x) sort(all(x))
#define tr(it, a) for (auto it = a.begin(); it != a.end(); it++)
#define PI 3.1415926535897932384626
typedef pair<int, int> pii;
typedef pair<ll, ll> pl;
typedef vector<int> vi;
typedef vector<ll> vl;
typedef vector<pii> vpii;
typedef vector<pl> vpl;
typedef vector<vi> vvi;
typedef vector<vl> vvl;

void solve()
{{
    {}


    return;
}}

int main()
{{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int t = 1;
    cin >> t;
    while (t--)
    {{
        solve();
    }}

    return 0;
}}
            ]],
          {
            i(1),
          }
        )
      ),
    })

    --     -- Enable friendly-snippets (optional)
    --     require("luasnip.loaders.from_vscode").lazy_load()
    --
    --     -- Keybindings for snippet navigation
    --     vim.keymap.set({"i", "s"}, "<Tab>", function()
    --         if ls.expand_or_jumpable() then
    --             ls.expand_or_jump()
    --         else
    --             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
    --         end
    --     end, { silent = true })
    --
    --     vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    --         if ls.jumpable(-1) then
    --             ls.jump(-1)
    --         else
    --             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
    --         end
    --     end, { silent = true })
  end,
}
