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
local maskImage
local maskShader

function love.load()
    love.window.setMode(1200,800)
    image = love.graphics.newImage("map.png")
    maskImage = love.graphics.newImage("overlay1.png")
    maskShader = love.graphics.newShader(shader_code2)
end


function love.update(dt)
end


function love.draw()
    love.graphics.setShader(maskShader)

    maskShader:send("mask",maskImage)

    
    love.graphics.draw(image,love.graphics.getWidth()/2 - image:getWidth()/2,love.graphics.getHeight()/2 - image:getHeight()/2)
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