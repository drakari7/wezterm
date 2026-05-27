local wezterm = require('wezterm')
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "Gruvbox Light"
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 12
config.scrollback_lines = 10000
config.default_cursor_style = "BlinkingBar"

-- Tabs
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

--Settings
-- config.window_close_confirmation = "NeverPrompt"

-- Leader key
config.leader = { key = "b", mods = "CTRL" }

config.disable_default_key_bindings = false

config.keys = {
  -- COPY MODE & QuickSelect
  { key = "c",     mods = "LEADER", action = act.ActivateCopyMode },
  { key = "q",     mods = "LEADER", action = act.QuickSelect },

  -- Misc
  { key = "p",     mods = "LEADER", action = act.ActivateCommandPalette },
  { key = "f",     mods = "LEADER", action = act.Search { CaseInSensitiveString = "" } },
  { key = "Enter", mods = "ALT",    action = act.DisableDefaultAssignment },

  -- COPY PASTE
  { key = "c",     mods = "ALT",    action = act.CopyTo "Clipboard", },
  { key = "v",     mods = "ALT",    action = act.PasteFrom "Clipboard", },

  -- Splits
  { key = "=",     mods = "LEADER", action = act.SplitHorizontal { domain = "DefaultDomain" }, },
  { key = "-",     mods = "LEADER", action = act.SplitVertical { domain = "DefaultDomain" }, },

  -- Navigation between panes
  { key = "h",     mods = "LEADER", action = act.ActivatePaneDirection "Left" },
  { key = "l",     mods = "LEADER", action = act.ActivatePaneDirection "Right" },
  { key = "k",     mods = "LEADER", action = act.ActivatePaneDirection "Up" },
  { key = "j",     mods = "LEADER", action = act.ActivatePaneDirection "Down" },

  -- Swap panes
  { key = "s",     mods = "LEADER", action = act.PaneSelect { mode = "SwapWithActiveKeepFocus" } },

  -- Tabs
  { key = "t",     mods = "LEADER", action = act.SpawnTab "DefaultDomain", },
  { key = "d",     mods = "LEADER", action = act.CloseCurrentPane { confirm = true }, },
  { key = "\\",    mods = "LEADER", action = act.CloseCurrentTab { confirm = false }, },
  { key = "]",     mods = "LEADER", action = act.MoveTabRelative(1) },
  { key = "[",     mods = "LEADER", action = act.MoveTabRelative(-1) },

  -- Open nvim
  { key = 'n',     mods = 'LEADER', action = act.Multiple { act.SendString 'nvim', act.SendKey { key = 'Enter' }, } },

  -- Jump to tabs
  { key = "1",     mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2",     mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3",     mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4",     mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5",     mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6",     mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7",     mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8",     mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9",     mods = "LEADER", action = act.ActivateTab(8) },

  -- Resize pane key table
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

}

config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { 'Left', 1 } },
    { key = "l",      action = act.AdjustPaneSize { 'Right', 1 } },
    { key = "j",      action = act.AdjustPaneSize { 'Down', 1 } },
    { key = "k",      action = act.AdjustPaneSize { 'Up', 1 } },
    { key = "Escape", action = 'PopKeyTable' },
  },
}

return config
