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

local player = {
    x=love.graphics.getWidth()/2,
    y=love.graphics.getHeight()/2,
    r=math.rad(45),
    speed = 50
}

function love.load()
    love.window.setMode(1200,800)
    image = love.graphics.newImage("map.png")
    maskShader = love.graphics.newShader(shader_code2)
    maskCanvas = love.graphics.newCanvas();
    mainCanvas = love.graphics.newCanvas();
end


function love.update(dt)

    if love.keyboard.isDown("d") then
        player.r = player.r + math.rad(player.speed)*dt
    elseif love.keyboard.isDown("a") then
        player.r = player.r - math.rad(player.speed)*dt
    end


    player.vx = math.sin(player.r)
    player.vy = math.cos(player.r)
end


function love.draw()

    --mask canvas
    love.graphics.setCanvas(maskCanvas)
    love.graphics.setColor({0.2,0.2,0.2})
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",player.x,player.y,50)

    local p1 = {}
    local p2 = {}
    local viewAngle = 40

    p1.x = (math.sin(player.r - math.rad(viewAngle/2)) * 500) + player.x
    p1.y = (math.cos(player.r - math.rad(viewAngle/2)) * 500) + player.y

    p2.x = (math.sin(player.r + math.rad(viewAngle/2)) * 500) + player.x
    p2.y = (math.cos(player.r + math.rad(viewAngle/2)) * 500) + player.y

    love.graphics.polygon("fill",{player.x,player.y,p1.x,p1.y,p2.x,p2.y})

    --scene canvas
    love.graphics.setCanvas(mainCanvas)
    love.graphics.draw(image,love.graphics.getWidth()/2 - image:getWidth()/2,love.graphics.getHeight()/2 - image:getHeight()/2)


    -- rendering
    love.graphics.setCanvas()
    love.graphics.setShader(maskShader)
    maskShader:send("mask",maskCanvas)
    love.graphics.draw(mainCanvas)
    love.graphics.setShader()



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