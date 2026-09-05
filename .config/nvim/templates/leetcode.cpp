//{{{
#include <bits/stdc++.h>
namespace dbg_lc {
template <class T>
void print(std::ostream &os, const T &v);
template <class A, class B>
void        print(std::ostream &os, const std::pair<A, B> &p);
template <class T, class C>
void print(std::ostream &os, std::stack<T, C> s);
template <class T, class C>
void print(std::ostream &os, std::queue<T, C> q);
template <class T, class C, class Comp>
void print(std::ostream &os, std::priority_queue<T, C, Comp> pq);
inline void print(std::ostream &os, const std::string &s) {
  os << '"' << s << '"';
}
inline void print(std::ostream &os, const char *s) {
  os << '"' << s << '"';
}
template <class A, class B>
void print(std::ostream &os, const std::pair<A, B> &p) {
  os << '(';
  print(os, p.first);
  os << ", ";
  print(os, p.second);
  os << ')';
}
template <class T, class C>
void print(std::ostream &os, std::stack<T, C> s) {
  os << '[';
  bool first = true;
  while (!s.empty()) {
    if (!first)
      os << ", ";
    first = false;
    print(os, s.top());
    s.pop();
  }
  os << "] (top-first)";
}
template <class T, class C>
void print(std::ostream &os, std::queue<T, C> q) {
  os << '[';
  bool first = true;
  while (!q.empty()) {
    if (!first)
      os << ", ";
    first = false;
    print(os, q.front());
    q.pop();
  }
  os << ']';
}
template <class T, class C, class Comp>
void print(std::ostream &os, std::priority_queue<T, C, Comp> pq) {
  os << '[';
  bool first = true;
  while (!pq.empty()) {
    if (!first)
      os << ", ";
    first = false;
    print(os, pq.top());
    pq.pop();
  }
  os << "] (top-first)";
}
template <class T>
void print(std::ostream &os, const T &v) {
  if constexpr (requires {
                  std::begin(v);
                  std::end(v);
                }) {
    os << '[';
    bool first = true;
    for (const auto &x : v) {
      if (!first)
        os << ", ";
      first = false;
      print(os, x);
    }
    os << ']';
  } else {
    os << v;
  }
}

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


template <class... Ts>
void dump(const char *names_raw, const Ts &...vals) {
  auto names = split_names(names_raw);
  std::cout << "[ ";
  std::size_t i   = 0;
  auto        one = [&](const auto &v) {
    if (i)
      std::cout << " | ";
    if (i < names.size())
      std::cout << names[i] << " = ";
    print(std::cout, v);
    ++i;
  };
  (one(vals), ...);
  std::cout << " ]\n";
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
} // namespace dbg_lc

#define de(...) ::dbg_lc::dump(#__VA_ARGS__, __VA_ARGS__)
#define deln(x) ::dbg_lc::dump_ln(#x, x)
#define divider cerr << "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=" << '\n'

using namespace std;

using ll  = long long;
using ull = unsigned long long;
using ld  = long double;
using pii = pair<int, int>;
using pll = pair<ll, ll>;
using pil = pair<int, ll>;
using pli = pair<ll, int>;

template <class T>
using vec = vector<T>;
template <class T>
using vvec = vector<vector<T>>;
template <class T>
using minpq = priority_queue<T, vector<T>, greater<T>>;

using vi    = vector<int>;
using vl    = vector<ll>;
using vb    = vector<bool>;
using vs    = vector<string>;
using vpii  = vector<pii>;
using vpll  = vector<pll>;
using vvi   = vector<vi>;
using vvl   = vector<vl>;
using vvb   = vector<vb>;
using vvpii = vector<vpii>;

constexpr int INF  = 1'000'000'000;
constexpr ll  LINF = (ll)4e18;
constexpr int MOD  = 1'000'000'007;

constexpr ld EPS = 1e-9L;
constexpr ld PI  = 3.14159265358979323846264338327950288L;

constexpr array<int, 4> dx4 = {-1, 0, 1, 0};
constexpr array<int, 4> dy4 = {0, 1, 0, -1};
constexpr array<int, 8> dx8 = {-1, -1, -1, 0, 0, 1, 1, 1};
constexpr array<int, 8> dy8 = {-1, 0, 1, -1, 1, -1, 0, 1};

#define all(x) begin(x), end(x)
#define rall(x) rbegin(x), rend(x)
#define clr(x) memset((x), 0, sizeof(x))
#define sortall(x) sort(all(x))
#define len(x) ((ll)(x).size())
#define pb push_back
#define eb emplace_back
#define F first
#define S second
#define mp make_pair
#define mt make_tuple

#define fo(i, n) for (int i = 0, _n = (int)(n); i < _n; ++i)
#define foi(i, a, b) for (int i = (int)(a), _b = (int)(b); i < _b; ++i)
#define fod(i, a, b) for (int(i) = (int)(a); (i) > (int)(b); --(i))
#define foe(i, a, b) for (int(i) = (int)(a), _b = (int)(b); (i) <= _b; ++(i))
#define foa(x, c) for (auto &(x) : (c))
#define rep(n) for (int _ = 0, _n = (int)(n); _ < _n; ++_)

template <class T, class U>
bool chmin(T &a, const U &b) {
  if (b < a) {
    a = b;
    return true;
  }
  return false;
}
template <class T, class U>
bool chmax(T &a, const U &b) {
  if (a < b) {
    a = b;
    return true;
  }
  return false;
}

inline ll mod(ll x, ll m = MOD) {
  x %= m;
  if (x < 0)
    x += m;
  return x;
}
ll power(ll a, ll b, ll m = MOD) {
  a    = mod(a, m);
  ll r = 1 % m;
  while (b > 0) {
    if (b & 1)
      r = r * a % m;
    a = a * a % m;
    b >>= 1;
  }
  return r;
}
inline ll modinv(ll a, ll m = MOD) {
  return power(a, m - 2, m);
}

template <class T>
T floordiv(T a, T b) {
  T q = a / b;
  if (((a < 0) != (b < 0)) && q * b != a)
    --q;
  return q;
}
template <class T>
T ceildiv(T a, T b) {
  T q = a / b;
  if (((a < 0) == (b < 0)) && q * b != a)
    ++q;
  return q;
}

template <class T>
void unique_sort(vector<T> &v) {
  sort(all(v));
  v.erase(unique(all(v)), v.end());
}
template <class T, class U>
int lb_idx(const vector<T> &v, const U &x) {
  return int(lower_bound(all(v), x) - v.begin());
}
template <class T, class U>
int ub_idx(const vector<T> &v, const U &x) {
  return int(upper_bound(all(v), x) - v.begin());
}

template <int M>
struct Mint {
  int v;
  Mint() : v(0) {
  }
  Mint(long long x) {
    v = int(x % M);
    if (v < 0)
      v += M;
  }
  explicit operator int() const {
    return v;
  }
  Mint &operator+=(Mint o) {
    v += o.v;
    if (v >= M)
      v -= M;
    return *this;
  }
  Mint &operator-=(Mint o) {
    v -= o.v;
    if (v < 0)
      v += M;
    return *this;
  }
  Mint &operator*=(Mint o) {
    v = int((long long)v * o.v % M);
    return *this;
  }
  Mint &operator/=(Mint o) {
    return *this *= o.inv();
  }
  friend Mint operator+(Mint a, Mint b) {
    return a += b;
  }
  friend Mint operator-(Mint a, Mint b) {
    return a -= b;
  }
  friend Mint operator*(Mint a, Mint b) {
    return a *= b;
  }
  friend Mint operator/(Mint a, Mint b) {
    return a /= b;
  }
  Mint operator-() const {
    return Mint(0) - *this;
  }
  Mint pow(long long e) const {
    Mint b = *this, r = 1;
    if (e < 0) {
      b = b.inv();
      e = -e;
    }
    while (e) {
      if (e & 1)
        r *= b;
      b *= b;
      e >>= 1;
    }
    return r;
  }
  Mint inv() const {
    return pow(M - 2);
  }
  friend bool operator==(Mint a, Mint b) {
    return a.v == b.v;
  }
  friend bool operator!=(Mint a, Mint b) {
    return a.v != b.v;
  }
  friend bool operator<(Mint a, Mint b) {
    return a.v < b.v;
  }
  friend ostream &operator<<(ostream &os, Mint a) {
    return os << a.v;
  }
};
using mint  = Mint<MOD>;
using mint9 = Mint<998244353>;

template <int M = MOD>
struct Comb {
  vector<Mint<M>> fac, ifac;
  Comb(int n) : fac(n + 1), ifac(n + 1) {
    fac[0] = 1;
    for (int i = 1; i <= n; ++i)
      fac[i] = fac[i - 1] * Mint<M>(i);
    ifac[n] = fac[n].inv();
    for (int i = n - 1; i >= 0; --i)
      ifac[i] = ifac[i + 1] * Mint<M>(i + 1);
  }
  Mint<M> C(int n, int r) const {
    if (r < 0 || r > n)
      return 0;
    return fac[n] * ifac[r] * ifac[n - r];
  }
  Mint<M> P(int n, int r) const {
    if (r < 0 || r > n)
      return 0;
    return fac[n] * ifac[n - r];
  }
  Mint<M> catalan(int n) const {
    return C(2 * n, n) - C(2 * n, n + 1);
  }
  Mint<M> H(int n, int r) const {
    return C(n + r - 1, r);
  }
};

#if defined(__cpp_lib_flat_map)
template <class K, class V, class C = less<K>>
using fmap = flat_map<K, V, C>;
#endif
#if defined(__cpp_lib_flat_set)
template <class T, class C = less<T>>
using fset = flat_set<T, C>;
#endif
#if defined(__cpp_lib_to_underlying)
using std::to_underlying;
#endif
// }}}

// #  define de(...) ((void)0)
// #  define deln(...) ((void)0)
// #  define divider(...) ((void)0)
