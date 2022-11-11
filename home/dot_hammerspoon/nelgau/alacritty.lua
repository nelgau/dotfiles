local Alacritty = {}

local APP_NAME = 'Alacritty'
local MINIMIZED_WIDTH = 2400
local MINIMIZED_HEIGHT = 1200

local shouldFullscreen = true

function canMinimize()
  local screenFrame = hs.screen.primaryScreen():frame()
  return (screenFrame.w > MINIMIZED_WIDTH
      and screenFrame.h > MINIMIZED_HEIGHT)
end

function findApp()
  return hs.application.get(APP_NAME)
end

function awaitWindow(app)
  local appWindow = nil
  while appWindow == nil do
    appWindow = app:mainWindow()
  end
  return appWindow
end

function presentApp(app)
  local primaryScreen = hs.screen.primaryScreen()
  local primarySpace = hs.spaces.activeSpaceOnScreen(primaryScreen)
  local appWindow = awaitWindow(app)

  local windowFrame = appWindow:frame()
  local screenFrame = primaryScreen:frame()

  if shouldFullscreen then
    windowFrame.w = screenFrame.w
    windowFrame.h = screenFrame.h
  else
    windowFrame.w = MINIMIZED_WIDTH
    windowFrame.h = MINIMIZED_HEIGHT
  end

  windowFrame.x = (screenFrame.w - windowFrame.w) / 2
  windowFrame.y = 0

  hs.spaces.moveWindowToSpace(appWindow, primarySpace)
  appWindow:setFrame(windowFrame, 0)
  appWindow:focus()
end

function launchApp()
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

Alacritty.toggleVisibility = function()
  local app = findApp()

  if app ~= nil then
    if app:isFrontmost() then
      app:hide()
    else
      presentApp(app)
    end
  else
    launchApp()
  end
end

Alacritty.toggleFullscreen = function()
  if canMinimize() then
    local app = findApp()

    if app ~= nil then
      if app:isFrontmost() then
        shouldFullscreen = not shouldFullscreen
        presentApp(app)
      end
    end
  end
end

Alacritty.hide = function()
  local app = findApp()

  if app ~= nil then
    app:hide()
  end
end

return Alacritty
