local M = {}
local declared = {}
local loaded = {}
local specs_by_name = {}

local function plugin_name(src)
  local name = src:match("/([^/]+)/?$")
  return name and name:gsub("%.git$", "")
end

local function register_one(spec)
  spec = type(spec) == "string" and { src = spec } or spec
  spec.name = spec.name or plugin_name(spec.src)

  if not spec.name then
    error("Could not infer a plugin name from: " .. vim.inspect(spec.src))
  end

  local existing = specs_by_name[spec.name]
  if existing then
    if existing.src ~= spec.src then
      error(("Plugin %s has conflicting sources"):format(spec.name))
    end
    return existing
  end

  declared[#declared + 1] = spec
  specs_by_name[spec.name] = spec
  return spec
end

function M.gh(repo)
  return "https://github.com/" .. repo
end

-- Remember one plugin or an ordered list without installing or loading them.
function M.register(plugins)
  local single = type(plugins) == "string" or plugins.src ~= nil
  plugins = single and { plugins } or plugins

  local result = {}
  for _, plugin in ipairs(plugins) do
    result[#result + 1] = register_one(plugin)
  end

  return single and result[1] or result
end

-- Install and lock every declared plugin without loading its runtime files.
-- This is intentionally manual so lazy plugins add no work during startup.
function M.install()
  vim.pack.add(declared, { load = function() end })
end

function M.load(plugins)
  plugins = M.register(plugins)
  plugins = plugins.src and { plugins } or plugins
  for _, plugin in ipairs(plugins) do
    local name = plugin.name
    if not loaded[name] then
      -- Adding here installs a new lazy plugin when it is first used. The
      -- explicit packadd also works after :PackInstall's no-op loader.
      vim.pack.add({ plugin }, { load = function() end })
      vim.cmd.packadd(name)
      loaded[name] = true
    end
  end
end

function M.prune()
  local stale = {}
  for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
    if not specs_by_name[plugin.spec.name] then
      stale[#stale + 1] = plugin.spec.name
    end
  end
  table.sort(stale)

  if #stale == 0 then
    vim.notify("No undeclared plugins to remove")
    return
  end

  local message = "Remove these undeclared plugins?\n\n" .. table.concat(stale, "\n")
  if vim.fn.confirm(message, "&Remove\n&Cancel", 2) == 1 then
    vim.pack.del(stale)
  end
end

-- Share initialization between a plugin's mappings and commands.
function M.once(callback)
  local loaded = false
  return function()
    if not loaded then
      callback()
      loaded = true
    end
  end
end

-- Defer nonessential setup until Neovim has finished starting.
function M.later(callback)
  vim.schedule(callback)
end

-- These mappings call Lua actions directly, preserving counts and selections.
function M.keymap(mode, lhs, load, action, options)
  vim.keymap.set(mode, lhs, function()
    load()
    vim.keymap.set(mode, lhs, action, options)
    return action()
  end, options)
end

vim.api.nvim_create_user_command("PackInstall", M.install, {
  desc = "Install and lock every plugin declared in the config",
})

vim.api.nvim_create_user_command("PackPrune", M.prune, {
  desc = "Remove installed plugins no longer declared in the config",
})

return M
