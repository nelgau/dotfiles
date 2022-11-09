hs.window.animationDuration = 0 -- disable animations

--
-- Applications
--

function chromeOpenLocation(url)
  return function()
    launchOrFocus("Google Chrome")()
    if hs.application.find("Google Chrome") then
      hs.applescript.applescript(string.format([[
        tell application "Google Chrome"
            open location "%s"
        end tell
      ]], url))
    end
  end
end

function iTermOpenDefaultTerminal()
  if hs.application.find("iTerm") then
    hs.applescript.applescript([[
      tell application "iTerm"
          create window with default profile
      end tell
    ]])
  else
    hs.application.open("iTerm")
  end
end

function iTermHideHotkeyWindow()
  if hs.application.find("iTerm") then
    hs.applescript.applescript([[
      tell application "iTerm"
          tell current window
              hide hotkey window
          end tell
      end tell
    ]])
  end
end

--
-- Key bindings
--

function launchOrFocus(app)
  return function()
    iTermHideHotkeyWindow()
    hs.application.launchOrFocus(app)
  end
end

local bindings = {
  [{'alt', 'cmd', 'ctrl'}] = {
    c = launchOrFocus('Google Chrome'),
    e = launchOrFocus('Evernote'),
    f = launchOrFocus('Finder'),
    g = chromeOpenLocation("https://www.github.com/nelgau"),
    i = launchOrFocus('Visual Studio Code'),
    o = launchOrFocus('Sublime Text'),
    t = iTermOpenDefaultTerminal,
    y = launchOrFocus('System Preferences'),
  },
}

for modifier, keyActions in pairs(bindings) do
  for key, action in pairs(keyActions) do
    hs.hotkey.bind(modifier, tostring(key), action)
  end
end

--
-- Autoreload config on change
--

function reloadConfig(files)
  for _, file in pairs(files) do
    if file:sub(-4) == '.lua' then
      hs.reload()
    end
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--
-- WIP Alacritty
--

local spaces = require "hs.spaces"
local screen = require "hs.screen"

function toggleAlacritty()
  local APP_NAME = 'Alacritty'
  local alacritty = hs.application.get(APP_NAME)

  function awaitWindow(app)
    local win = nil
    while win == nil do
      win = app:mainWindow()
    end
    return win
  end

  function presentApp(app)
    local space = spaces.activeSpaceOnScreen()
    local win = awaitWindow(app)

    winFrame = win:frame()
    scrFrame = screen.mainScreen():frame()

    winFrame.w = scrFrame.w
    winFrame.y = scrFrame.y
    winFrame.x = scrFrame.x

    spaces.moveWindowToSpace(win, space)
    win:setFrame(winFrame, 0)
    win:focus()
  end

  if alacritty ~= nil then
    if alacritty:isFrontmost() then
      alacritty:hide()
    else
      presentApp(alacritty)
    end
  else
    if hs.application.launchOrFocus(APP_NAME) then
      local appWatcher = nil

      appWatcher = hs.application.watcher.new(function(name, event, app)
        if event == hs.application.watcher.launched and name == APP_NAME then
          presentApp(app)
          appWatcher:stop()
        end
      end)

      appWatcher:start()
    end
  end
end

-- Switch alacritty
hs.hotkey.bind({'cmd'}, '`', toggleAlacritty)
