if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

function loadFile(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local shader_code = loadFile("phong.fs")


local image
local shader

function love.load()
    love.window.setMode(1200,800)
    image = love.graphics.newImage("map.png")
    shader = love.graphics.newShader(shader_code)
end


function love.update(dt)
end


function love.draw()
    love.graphics.setShader(shader)

    shader:send("screen",{
        love.graphics.getWidth(),
        love.graphics.getHeight()
    })

    shader:send("num_lights",1)

    shader:send("lights[0].position",{love.graphics.getWidth()/2.0,love.graphics.getHeight()/2.0})
    shader:send("lights[0].diffuse",{1.0,1.0,1.0})
    shader:send("lights[0].power",64)
    
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