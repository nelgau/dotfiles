local Alacritty = {}

local APP_NAME = 'Alacritty'

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

  windowFrame = appWindow:frame()
  screenFrame = primaryScreen:frame()

  windowFrame.w = screenFrame.w
  windowFrame.y = screenFrame.y
  windowFrame.x = screenFrame.x

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

Alacritty.toggle = function()
  local alacritty = hs.application.get(APP_NAME)

  if alacritty ~= nil then
    if alacritty:isFrontmost() then
      alacritty:hide()
    else
      presentApp(alacritty)
    end
  else
    launchApp()
  end
end

return Alacritty
