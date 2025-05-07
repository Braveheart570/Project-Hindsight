
Player = {
    x=love.graphics.getWidth()/2,
    y=love.graphics.getHeight()/2,
    r=math.rad(45),
    speed = 150
}

function Player:drawVisionMask()
    love.graphics.setColor({0.3,0.3,0.4})
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",Player.x,Player.y,50)

    local p1 = {}
    local p2 = {}
    local viewAngle = 40
    local length = 1000

    p1.x = (math.cos(Player.r - math.rad(viewAngle/2)) * length) + Player.x
    p1.y = (math.sin(Player.r - math.rad(viewAngle/2)) * length) + Player.y

    p2.x = (math.cos(Player.r + math.rad(viewAngle/2)) * length) + Player.x
    p2.y = (math.sin(Player.r + math.rad(viewAngle/2)) * length) + Player.y

    love.graphics.polygon("fill",{Player.x,Player.y,p1.x,p1.y,p2.x,p2.y})
end

function Player:draw()

    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",Player.x,Player.y,30)

end

function Player:update(dt)
    -- view control
    local mouseX, mouseY = love.mouse.getPosition()

    local deltaMouseX = mouseX - love.graphics.getWidth()/2
    local deltaMouseY = mouseY - love.graphics.getHeight()/2

    Player.r = math.atan2(deltaMouseY,deltaMouseX)


    if love.keyboard.isDown("w") then
        Player.x = Player.x - math.cos(Player.r) * Player.speed * dt
        Player.y = Player.y - math.sin(Player.r) * Player.speed * dt
    elseif love.keyboard.isDown("s") then
        Player.x = Player.x + math.cos(Player.r) * Player.speed * dt
        Player.y = Player.y + math.sin(Player.r) * Player.speed * dt
    end

end


function Player:keypressed(key)
    
end

function Player:mousepressed(x,y,button)
end
