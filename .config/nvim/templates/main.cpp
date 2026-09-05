//{{{
#include <bits/stdc++.h>

#ifdef LOCAL
#  include "debugging.h"
#  define divider                                                              \
    cerr << "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=" << '\n'
#else
#  define de(...) ((void)0)
#  define deln(...) ((void)0)
#  define demat(...) ((void)0)
#  define de_details(...) ((void)0)
#  define deln_details(...) ((void)0)
#  define demat_details(...) ((void)0)
#  define divider(...) ((void)0)
#endif

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

constexpr std::array<std::array<int, 2>, 4> d4 = {{
  {-1, 0}, // up
  {0, 1},  // right
  {1, 0},  // down
  {0, -1}  // left
}};

constexpr std::array<std::array<int, 2>, 8> d8 = {{
  {-1, 0}, // up
  {-1, 1}, // up-right
  {0, 1},  // right
  {1, 1},  // down-right
  {1, 0},  // down
  {1, -1}, // down-left
  {0, -1}, // left
  {-1, -1} // up-left
}};

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
#define fod(i, a, b) for (int i = (int)(a), _b = (int)(b); i > _b; --i)
#define foed(i, a, b) for (int(i) = (int)(a), _b = (int)(b); (i) <= _b; ++(i))
#define foei(i, a, b) for (int(i) = (int)(a), _b = (int)(b); (i) >= _b; --(i))
#define foa(x, c) for (auto &(x) : (c))
#define rep(n) for (int _ = 0, _n = (int)(n); _ < _n; ++_)

#define prn(x) cout << (x) << '\n'
#define pr(x) cout << (x) << ' '
#define YES cout << "YES\n"
#define Yes cout << "Yes\n"
#define yes cout << "yes\n"
#define NO cout << "NO\n"
#define No cout << "No\n"
#define no cout << "no\n"
#define YN(b) cout << ((b) ? "YES" : "NO") << '\n'
#define Yn(b) cout << ((b) ? "Yes" : "No") << '\n'
#define yn(b) cout << ((b) ? "yes" : "no") << '\n'

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

#if defined(__cpp_lib_flat_map)
template <class K, class V, class C = less<K>>
using fmap = std::flat_map<K, V, C>;
#endif
#if defined(__cpp_lib_flat_set)
template <class T, class C = less<T>>
using fset = std::flat_set<T, C>;
#endif
#if defined(__cpp_lib_to_underlying)
using std::to_underlying;
#endif

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
  friend std::ostream &operator<<(std::ostream &os, Mint a) {
    return os << a.v;
  }
  friend std::istream &operator>>(std::istream &is, Mint &a) {
    long long x;
    is >> x;
    a = Mint(x);
    return is;
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

template <class T>
istream &operator>>(istream &is, vec<T> &a) {
  for (auto &x : a)
    is >> x;
  return is;
}

template <class A, class B>
istream &operator>>(istream &is, pair<A, B> &p) {
  return is >> p.first >> p.second;
}

template <class... Ts>
istream &operator>>(istream &is, tuple<Ts...> &t) {
  apply([&](auto &...xs) { ((is >> xs), ...); }, t);
  return is;
}

#ifndef LOCAL
template <class A, class B>
ostream &operator<<(ostream &os, const pair<A, B> &p) {
  return os << p.first << ' ' << p.second;
}
template <class T>
ostream &operator<<(ostream &os, const vec<T> &a) {
  for (size_t i = 0; i < a.size(); ++i) {
    if (i)
      os << ' ';
    os << a[i];
  }
  return os;
}
template <class... Ts>
ostream &operator<<(ostream &os, const tuple<Ts...> &t) {
  apply(
    [&](const auto &...xs) {
      size_t i = 0;
      ((os << (i++ ? " " : "") << xs), ...);
    },
    t);
  return os;
}
#endif

template <class... Ts>
void print(const Ts &...xs) {
  size_t i = 0;
  ((cout << (i++ ? " " : "") << xs), ...);
}
template <class... Ts>
void println(const Ts &...xs) {
  print(xs...);
  cout << '\n';
}

template <class T = int>
vec<T> readv(int n) {
  vec<T> v(n);
  for (auto &x : v)
    cin >> x;
  return v;
}

inline vvi read_graph(int n, int m, bool directed = false, int base = 1) {
  vvi g(n);
  fo(i, m) {
    int u, v;
    cin >> u >> v;
    u -= base;
    v -= base;
    g[u].pb(v);
    if (!directed)
      g[v].pb(u);
  }
  return g;
}
//}}}

void solve() {
  int    n, m, e, k, q, u, v;
  vi     elm;
  string s;
}


signed main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int t = 1;
  // cin >> t;
  for (int tc = 1; tc <= t; ++tc) {
    de(tc);
    solve();
  }
  return 0;
}
