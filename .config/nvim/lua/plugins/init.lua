-- lua/plugins/init.lua
-- Top-level spec for the `plugins` module imported by lua/config/lazy.lua
-- (`{ import = "plugins" }`).
--
-- IMPORTANT: lazy.nvim's import does NOT recurse. `{ import = "plugins" }`
-- only loads top-level `lua/plugins/*.lua` files and any subdirectory that
-- contains its own `init.lua`. Our plugin specs live one-per-file inside
-- category subdirectories (navigation/, ui/, lsp/, lsp/servers/, dap/, ...)
-- with NO per-directory init.lua, so they would never be loaded.
--
-- This file fixes that by scanning the plugins/ tree at startup and returning
-- an `{ import = "plugins.<sub>" }` spec for every subdirectory (recursively).
-- Drop a new category folder in and it is picked up automatically — no need to
-- edit lua/config/lazy.lua.

local uv = vim.uv or vim.loop
local plugins_root = vim.fn.stdpath("config") .. "/lua/plugins"

---@type LazySpec[]
local imports = {}

local function scan(dir, mod)
  local handle = uv.fs_scandir(dir)
  if not handle then
    return
  end
  while true do
    local name, t = uv.fs_scandir_next(handle)
    if not name then
      break
    end
    local path = dir .. "/" .. name
    t = t or (uv.fs_stat(path) or {}).type
    if t == "directory" then
      local submod = mod .. "." .. name
      imports[#imports + 1] = { import = submod }
      scan(path, submod) -- recurse for nested dirs (e.g. lsp/servers)
    end
  end
end

scan(plugins_root, "plugins")

return imports
