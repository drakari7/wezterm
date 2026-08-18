-- Machine-local settings from ~/.theme.toml (flat "key = value" lines).
local wezterm = require('wezterm')

local path = os.getenv('HOME') .. '/.theme.toml'
wezterm.add_to_config_reload_watch_list(path)

local schemes = { light = 'Gruvbox Light', dark = 'Tokyo Night' }

local cfg = {}
local f = io.open(path, 'r')
if f then
  for line in f:lines() do
    local k, v = line:gsub('%s*#.*$', ''):match('^%s*([%w_]+)%s*=%s*(.-)%s*$')
    if k then cfg[k] = v:match('^"(.*)"$') or v:match("^'(.*)'$") or v end
  end
  f:close()
end

local mode = cfg.mode
if not schemes[mode] then
  wezterm.log_error("theme.lua: no valid mode in ~/.theme.toml (got '" .. tostring(mode) .. "'), using dark")
  mode = 'dark'
end

return {
  color_scheme = schemes[mode],
  font_size = tonumber(cfg.font_size) or 18,
}
