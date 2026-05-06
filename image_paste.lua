local wezterm = require('wezterm')

local M = {}

local SCREENSHOT_DIR = os.getenv("HOME") .. "/Screenshots"
local MAX_AGE_SECS = 120

-- Find the latest screenshot and verify it's fresh.
-- stdout: "OK:<full_path>", "STALE:<age>", or "NONE".
local SCRIPT = [[
  DIR="$1"; MAX_AGE="$2"
  f=$(ls -t "$DIR"/*.png 2>/dev/null | head -1)
  if [ -z "$f" ]; then printf 'NONE'; exit 1; fi
  age=$(( $(date +%s) - $(stat -c %Y "$f") ))
  if [ "$age" -gt "$MAX_AGE" ]; then printf 'STALE:%s' "$age"; exit 1; fi
  printf 'OK:%s' "$f"
]]

function M.paste_latest_screenshot(window, pane)
  local ok, stdout, _ = wezterm.run_child_process({
    "sh", "-c", SCRIPT, "sh", SCREENSHOT_DIR, tostring(MAX_AGE_SECS),
  })
  local out = (stdout or ""):gsub("%s+$", "")
  local kind, payload = out:match("^(%w+):(.*)$")

  if ok and kind == "OK" then
    pane:send_text("\x1b[200~ @" .. payload .. " \x1b[201~")
    -- window:toast_notification("wezterm", "Attached " .. payload:match("([^/]+)$"), nil, 3000)
  elseif kind == "STALE" then
    window:toast_notification(
      "wezterm",
      "Latest screenshot is " .. payload .. "s old (max " .. MAX_AGE_SECS .. "s)",
      nil, 3000
    )
  else
    window:toast_notification("wezterm", "No screenshot found in " .. SCREENSHOT_DIR, nil, 3000)
  end
end

return M
