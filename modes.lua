local wezterm = require('wezterm')
local act = wezterm.action

local M = {}

-- Clear the pattern on exit, otherwise the next Search/ActivateCopyMode reuses it
local exit = act.Multiple { act.CopyMode 'ClearPattern', 'ScrollToBottom', act.CopyMode 'Close' }

-- Search ignores the type when the pattern is empty, so have a placeholder and clear it immediately
local search = act.Multiple { act.Search { CaseSmartString = 'xxx' }, act.CopyMode 'ClearPattern' }

M.keys = {
  { key = 'c', mods = 'LEADER', action = act.Multiple { act.ActivateCopyMode, act.CopyMode 'ClearPattern' } },
  { key = '/', mods = 'LEADER', action = search },
}

function M.key_tables()
  if not wezterm.gui then return {} end

  local defaults = wezterm.gui.default_key_tables()
  local copy_mode, search_mode = defaults.copy_mode, defaults.search_mode

  for _, k in ipairs({
    { key = 'Escape', mods = 'NONE',  action = exit },
    { key = 'y',      mods = 'NONE',  action = act.Multiple { act.CopyTo 'ClipboardAndPrimarySelection', act.CopyMode 'ClearSelectionMode', exit } },
    { key = 'n',      mods = 'NONE',  action = act.CopyMode 'PriorMatch' },
    { key = 'N',      mods = 'SHIFT', action = act.CopyMode 'NextMatch' },
    { key = '/',      mods = 'NONE',  action = search },
  }) do table.insert(copy_mode, k) end

  for _, k in ipairs({
    { key = 'Enter',  mods = 'NONE', action = act.CopyMode 'AcceptPattern' },
    { key = 'Escape', mods = 'NONE', action = exit },
  }) do table.insert(search_mode, k) end

  return { copy_mode = copy_mode, search_mode = search_mode }
end

return M
