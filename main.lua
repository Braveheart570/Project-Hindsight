if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

require("utils")




local maskShader

local visionMaskCanvas
local envCanvas
local entityCanvas

local Screens = {}

local SCREEN_INDEX = 1

function ChangeScreen(index)

    if index > #Screens then
        print("invalid index")
        return
    end

    SCREEN_INDEX = index

    Screens[SCREEN_INDEX]:reset()

end


function love.load()
    love.window.setMode(1200,800)
    --shaders
    maskShader = love.graphics.newShader(LoadFile("mask.fs"))
    --canvases
    CanvasWidth, CanvasHeight = love.window.getMode()
    CanvasWidth = CanvasWidth*6
    CanvasHeight = CanvasHeight*6

    visionMaskCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);
    envCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);
    entityCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);

    local Level = require "level"
    local StartScreen = require "startScreen"
    local GameOverScreen = require "gameOverScreen"
    local WinScreen = require "winScreen"

    table.insert(Screens,StartScreen())
    table.insert(Screens,Level())
    table.insert(Screens,GameOverScreen())
    table.insert(Screens,WinScreen())

    

end


function love.update(dt)

    Screens[SCREEN_INDEX]:update(dt)


end


function love.draw()
    
    --mask canvas
    love.graphics.setCanvas(visionMaskCanvas)
    if Screens[SCREEN_INDEX].renderPlayerView == true then
        Player:drawVisionMask()
    else
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill",0,0,CanvasWidth,CanvasHeight)
    end
    


    --scene canvas
    love.graphics.setCanvas(envCanvas)
    Screens[SCREEN_INDEX]:drawEnv()


    --hidden canvas
    love.graphics.setCanvas(entityCanvas)
    love.graphics.clear()
    Screens[SCREEN_INDEX]:drawEntities()


    -- rendering
    love.graphics.setCanvas()

    love.graphics.clear()
    love.graphics.push()
    if SCREEN_INDEX == 2 then
        love.graphics.translate(-Player.x + love.graphics.getWidth()/2,-Player.y + love.graphics.getHeight()/2)
    else
        love.graphics.translate(-CanvasWidth/2 + love.graphics.getWidth()/2,-CanvasHeight/2 + love.graphics.getHeight()/2)
    end

    love.graphics.setShader(maskShader)
    maskShader:send("mask",visionMaskCanvas)
    maskShader:send("entities",entityCanvas)
    love.graphics.setColor({1,1,1})
    love.graphics.draw(envCanvas)
    love.graphics.setShader()
    Screens[SCREEN_INDEX]:drawUI()

    love.graphics.pop()

    


end


function love.keypressed(key)

    Screens[SCREEN_INDEX]:keypressed(key)

end



function love.mousepressed(x,y,button)
    
    Screens[SCREEN_INDEX]:mousepressed(x,y,button)

end

--sits at the bottom of our script
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end