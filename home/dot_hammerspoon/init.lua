local Alacritty = require('nelgau.alacritty')

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
  [{'cmd'}] = {
    ['`'] = Alacritty.toggle,
  },
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
