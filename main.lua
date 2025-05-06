if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

function loadFile(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local shader_code2 = loadFile("mask.fs")


local image
local maskCanvas
local maskShader

local mainCanvas

function love.load()
    love.window.setMode(1200,800)
    image = love.graphics.newImage("map.png")
    maskShader = love.graphics.newShader(shader_code2)
    maskCanvas = love.graphics.newCanvas();
    mainCanvas = love.graphics.newCanvas();
end


function love.update(dt)
end


function love.draw()

    love.graphics.setCanvas(maskCanvas)
    love.graphics.setColor({0.2,0.2,0.2})
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",love.graphics.getWidth()/2,love.graphics.getHeight()/2,300)
    love.graphics.setCanvas(mainCanvas)
    love.graphics.draw(image,love.graphics.getWidth()/2 - image:getWidth()/2,love.graphics.getHeight()/2 - image:getHeight()/2)
    love.graphics.setCanvas()
    love.graphics.setShader(maskShader)
    maskShader:send("mask",maskCanvas)
    love.graphics.draw(mainCanvas)



    love.graphics.setShader()
end


function love.keypressed(key)

    if key == "r" then love.event.quit "restart" end

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