if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

  -- loads files as a string
local function loadFile(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local maskShader

local visionMaskCanvas
local envCanvas
local entityCanvas

local Screens = {}



function love.load()
    love.window.setMode(1200,800)
    --shaders
    maskShader = love.graphics.newShader(loadFile("mask.fs"))
    --canvases
    CanvasWidth, CanvasHeight = love.window.getMode()
    CanvasWidth = CanvasWidth*6
    CanvasHeight = CanvasHeight*6

    visionMaskCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);
    envCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);
    entityCanvas = love.graphics.newCanvas(CanvasWidth, CanvasHeight);

    local Level = require "level"

    table.insert(Screens,Level())

    

end


function love.update(dt)

    Screens[1]:update(dt)


end


function love.draw()
    
    --mask canvas
    love.graphics.setCanvas(visionMaskCanvas)
    Player:drawVisionMask()


    --scene canvas
    love.graphics.setCanvas(envCanvas)
    Screens[1]:drawEnv()


    --hidden canvas
    love.graphics.setCanvas(entityCanvas)
    love.graphics.clear()
    Screens[1]:drawEntities()


    -- rendering
    love.graphics.setCanvas()

    love.graphics.clear()
    love.graphics.push()
    love.graphics.translate(-Player.x + love.graphics.getWidth()/2,-Player.y + love.graphics.getHeight()/2)

    love.graphics.setShader(maskShader)
    maskShader:send("mask",visionMaskCanvas)
    maskShader:send("entities",entityCanvas)
    love.graphics.setColor({1,1,1})
    love.graphics.draw(envCanvas)

    love.graphics.pop()

    love.graphics.setShader()


end


function love.keypressed(key)

    Screens[1]:keypressed(key)

end



function love.mousepressed(x,y,button)
    
    Screens[1]:mousepressed(x,y,button)

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