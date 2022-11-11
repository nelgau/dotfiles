local Alacritty = require('nelgau.alacritty')
local Apps = require('nelgau.apps')

local HS_PATH = os.getenv("HOME") .. "/.hammerspoon"

hs.window.animationDuration = 0 -- disable animations

ext = {
  watchers = {},
}

--
-- Key bindings
--

local bindings = {
  [{'cmd'}] = {
    ['`'] = Alacritty.toggleVisibility,
  },
  [{'cmd', 'alt'}] = {
    ['`'] = Alacritty.toggleFullscreen,
  },
  [{'cmd', 'alt', 'ctrl'}] = {
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
  -- stop watchers to avoid leaks
  hs.fnutils.each(ext.watchers, function(watcher) watcher:stop() end)

  hs.reload()

  hs.notify.new({
    title           = 'Hammerspoon',
    informativeText = 'Configuration reloaded',
  }):send()
end

ext.watchers.pathwatcher = hs.pathwatcher.new(HS_PATH, reloadConfig):start()
