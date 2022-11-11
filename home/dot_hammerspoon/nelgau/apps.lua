local Apps = {}

local Alacritty = require('nelgau.alacritty')

Apps.launchOrFocus = function(app)
  return function()
    Alacritty.hide()
    hs.application.launchOrFocus(app)
  end
end

Apps.chromeOpenLocation = function(url)
  return function()
    Apps.launchOrFocus("Google Chrome")()
    if hs.application.find("Google Chrome") then
      hs.applescript.applescript(string.format([[
        tell application "Google Chrome"
            open location "%s"
        end tell
      ]], url))
    end
  end
end

Apps.iTermOpenDefaultTerminal = function()
  Alacritty.hide()
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

return Apps
