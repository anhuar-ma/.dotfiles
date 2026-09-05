#pragma once
// =============================================================================
// debugging.h  -  C++23 Optimized Pretty Printer for competitive programming
// =============================================================================
// Uses C++23 <print> and <format> to handle iterables, tuples, strings, and
// primitives natively. Custom formatters are injected ONLY for types that
// C++23 does not natively support (Adapters and Smart Pointers).
// =============================================================================

#include <algorithm>
#include <format>
#include <memory>
#include <print>
#include <queue>
#include <ranges>
#include <stack>
#include <string>
#include <vector>

// =============================================================================
// 1. C++23 Formatter Injections for Unsupported Types
// =============================================================================

namespace std {

// Formatter for std::stack
template <class T, class Container, class CharT>
struct formatter<std::stack<T, Container>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::stack<T, Container> &s, Ctx &ctx) const {
    auto           copy = s;
    std::vector<T> tmp;
    while (!copy.empty()) {
      tmp.push_back(copy.top());
      copy.pop();
    }
    return std::format_to(ctx.out(), "{} (top-first)", tmp);
  }
};

// Formatter for std::queue
template <class T, class Container, class CharT>
struct formatter<std::queue<T, Container>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::queue<T, Container> &q, Ctx &ctx) const {
    auto           copy = q;
    std::vector<T> tmp;
    while (!copy.empty()) {
      tmp.push_back(copy.front());
      copy.pop();
    }
    return std::format_to(ctx.out(), "{}", tmp);
  }
};

// Formatter for std::priority_queue
template <class T, class Container, class Compare, class CharT>
struct formatter<std::priority_queue<T, Container, Compare>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::priority_queue<T, Container, Compare> &q,
              Ctx                                              &ctx) const {
    auto           copy = q;
    std::vector<T> tmp;
    while (!copy.empty()) {
      tmp.push_back(copy.top());
      copy.pop();
    }
    return std::format_to(ctx.out(), "{} (top-first)", tmp);
  }
};

// Formatter for std::unique_ptr
template <class T, class D, class CharT>
struct formatter<std::unique_ptr<T, D>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::unique_ptr<T, D> &p, Ctx &ctx) const {
    if (p)
      return std::format_to(ctx.out(), "Uniq({})", *p);
    return std::format_to(ctx.out(), "Null");
  }
};

// Formatter for std::shared_ptr
template <class T, class CharT>
struct formatter<std::shared_ptr<T>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::shared_ptr<T> &p, Ctx &ctx) const {
    if (p)
      return std::format_to(ctx.out(), "Shr[{}]({})", p.use_count(), *p);
    return std::format_to(ctx.out(), "Null");
  }
};

// Formatter for std::weak_ptr
template <class T, class CharT>
struct formatter<std::weak_ptr<T>, CharT> {
  constexpr auto parse(std::format_parse_context &ctx) {
    return ctx.begin();
  }
  template <class Ctx>
  auto format(const std::weak_ptr<T> &p, Ctx &ctx) const {
    if (auto sp = p.lock())
      return std::format_to(ctx.out(), "Weak({})", *sp);
    return std::format_to(ctx.out(), "Expired");
  }
};

} // namespace std


namespace dbg {

// =============================================================================
// 2. Name splitter
// =============================================================================

inline std::vector<std::string> split_names(const char *s) {
  std::vector<std::string> out;
  std::string              cur;
  int                      paren = 0, brack = 0, brace = 0, angle = 0;
  bool                     in_str = false, in_chr = false;

  for (const char *p = s; *p; ++p) {
    char c = *p;
    if (in_str) {
      cur += c;
      if (c == '\\' && p[1])
        cur += *++p;
      else if (c == '"')
        in_str = false;
      continue;
    }
    if (in_chr) {
      cur += c;
      if (c == '\\' && p[1])
        cur += *++p;
      else if (c == '\'')
        in_chr = false;
      continue;
    }
    if (c == '"') {
      in_str = true;
      cur += c;
      continue;
    }
    if (c == '\'') {
      in_chr = true;
      cur += c;
      continue;
    }

    if (c == '(')
      paren++;
    else if (c == ')')
      paren--;
    else if (c == '[')
      brack++;
    else if (c == ']')
      brack--;
    else if (c == '{')
      brace++;
    else if (c == '}')
      brace--;
    else if (c == '<')
      angle++;
    else if (c == '>' && angle > 0)
      angle--;

    if (c == ',' && paren == 0 && brack == 0 && brace == 0 && angle == 0) {
      size_t a = cur.find_first_not_of(" \t");
      size_t b = cur.find_last_not_of(" \t");
      out.push_back(a == std::string::npos ? "" : cur.substr(a, b - a + 1));
      cur.clear();
    } else {
      cur += c;
    }
  }
  size_t a = cur.find_first_not_of(" \t");
  size_t b = cur.find_last_not_of(" \t");
  if (a != std::string::npos)
    out.push_back(cur.substr(a, b - a + 1));
  return out;
}

// =============================================================================
// 3. Dump engines
// =============================================================================

template <class... Ts>
void dump(const char *names_raw, const Ts &...vals) {
  auto names = split_names(names_raw);
  std::print(stderr, "[ ");
  std::size_t i = 0;

  auto print_one = [&](const auto &v) {
    if (i > 0)
      std::print(stderr, " | ");
    if (i < names.size())
      std::print(stderr, "{} = ", names[i]);
    std::print(stderr, "{}", v);
    ++i;
  };

  (print_one(vals), ...);
  std::println(stderr, " ]");
}

template <class T>
void dump_ln(const char *name, const T &c) {
  std::println(stderr, "{} =", name);
  // Use std::ranges to check if it's iterable, excluding string views/strings
  if constexpr (std::ranges::range<T>
                && !std::is_convertible_v<T, std::string_view>) {
    std::size_t n = 0;
    for (auto it = std::ranges::begin(c); it != std::ranges::end(c); ++it)
      ++n;
    int         idx_w = (int)std::to_string(n == 0 ? 0 : n - 1).size();
    std::size_t i     = 0;
    for (const auto &x : c) {
      std::println(stderr, "  [{:>{}}] - {}", i++, idx_w, x);
    }
  } else {
    std::println(stderr, "  {}", c);
  }
}

template <class Mat>
void dump_mat(const char *name, const Mat &m) {
  std::println(stderr, "{} =", name);
  std::vector<std::vector<std::string>> s;
  std::size_t                           cols = 0;

  for (const auto &row : m) {
    std::vector<std::string> r;
    for (const auto &v : row) {
      r.push_back(std::format("{}", v));
    }
    cols = std::max(cols, r.size());
    s.push_back(std::move(r));
  }

  std::vector<std::size_t> w(cols, 0);
  for (const auto &r : s)
    for (std::size_t j = 0; j < r.size(); ++j)
      w[j] = std::max(w[j], r[j].size());

  int idx_w = (int)std::to_string(s.empty() ? 0 : s.size() - 1).size();
  for (std::size_t i = 0; i < s.size(); ++i) {
    std::print(stderr, "  [{:>{}}] - [", i, idx_w);
    for (std::size_t j = 0; j < s[i].size(); ++j) {
      if (j)
        std::print(stderr, ", ");
      std::print(stderr, "{:>{}}", s[i][j], w[j]);
    }
    std::println(stderr, "]");
  }
}

// Detailed variants
template <class... Ts>
void dump_details(const char *file,
                  int         line,
                  const char *fn,
                  const char *names_raw,
                  const Ts &...vals) {
  std::print(stderr, "[dbg {}:{} {}] ", file, line, fn);
  dump(names_raw, vals...);
}

template <class T>
void dump_ln_details(
  const char *file, int line, const char *fn, const char *name, const T &c) {
  std::print(stderr, "[dbg {}:{} {}] ", file, line, fn);
  dump_ln(name, c);
}

template <class Mat>
void dump_mat_details(
  const char *file, int line, const char *fn, const char *name, const Mat &m) {
  std::print(stderr, "[dbg {}:{} {}] ", file, line, fn);
  dump_mat(name, m);
}

} // namespace dbg

// =============================================================================
// 4. Public macros
// =============================================================================

#define de(...) ::dbg::dump(#__VA_ARGS__, __VA_ARGS__)
#define deln(x) ::dbg::dump_ln(#x, x)
#define demat(x) ::dbg::dump_mat(#x, x)

#define de_details(...)                                                        \
  ::dbg::dump_details(__FILE__, __LINE__, __func__, #__VA_ARGS__, __VA_ARGS__)
#define deln_details(x)                                                        \
  ::dbg::dump_ln_details(__FILE__, __LINE__, __func__, #x, x)
#define demat_details(x)                                                       \
  ::dbg::dump_mat_details(__FILE__, __LINE__, __func__, #x, x)
