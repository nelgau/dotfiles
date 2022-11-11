local Alacritty = require('nelgau.alacritty')
local Apps = require('nelgau.apps')

hs.window.animationDuration = 0 -- disable animations

--
-- Key bindings
--

local bindings = {
  [{'cmd'}] = {
    ['`'] = Alacritty.toggle,
  },
  [{'alt', 'cmd', 'ctrl'}] = {
    c = Apps.launchOrFocus('Google Chrome'),
    e = Apps.launchOrFocus('Evernote'),
    f = Apps.launchOrFocus('Finder'),
    g = Apps.chromeOpenLocation("https://www.github.com/nelgau"),
    i = Apps.launchOrFocus('Visual Studio Code'),
    o = Apps.launchOrFocus('Sublime Text'),
    t = Apps.iTermOpenDefaultTerminal,
    y = Apps.launchOrFocus('System Preferences'),
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

local hsPath = os.getenv("HOME") .. "/.hammerspoon"
hs.pathwatcher.new(hsPath, reloadConfig):start()
