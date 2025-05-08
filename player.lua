local Bullet = require("bullet")



Player = {
    x=CanvasWidth/2,
    y=CanvasHeight/2,
    r=math.rad(45),
    size = 30,
    speed = 150,
    health = 10,
    Bullets = {}
}

function Player:drawVisionMask()
    love.graphics.setColor({0.6,0.6,0.7})
    love.graphics.rectangle("fill",0,0,CanvasWidth,CanvasHeight)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",Player.x,Player.y,50)

    local p1 = {}
    local p2 = {}
    local viewAngle = 90
    local length = 1500

    p1.x = (math.cos(math.rad(180) + Player.r - math.rad(viewAngle/2)) * length) + Player.x
    p1.y = (math.sin(math.rad(180) + Player.r - math.rad(viewAngle/2)) * length) + Player.y

    p2.x = (math.cos(math.rad(180) + Player.r + math.rad(viewAngle/2)) * length) + Player.x
    p2.y = (math.sin(math.rad(180) + Player.r + math.rad(viewAngle/2)) * length) + Player.y

    love.graphics.polygon("fill",{Player.x,Player.y,p1.x,p1.y,p2.x,p2.y})
end

function Player:draw()

    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",Player.x,Player.y,Player.size)

    for i,v in ipairs(self.Bullets) do
        v:draw()
    end

end

function Player:update(dt)

    -- view control
    local mouseX, mouseY = love.mouse.getPosition()

    local deltaMouseX = mouseX - love.graphics.getWidth()/2
    local deltaMouseY = mouseY - love.graphics.getHeight()/2

    Player.r = math.atan2(deltaMouseY,deltaMouseX)

    --movement code
    if love.keyboard.isDown("s") then
        Player.x = Player.x - math.cos(Player.r) * Player.speed * dt
        Player.y = Player.y - math.sin(Player.r) * Player.speed * dt
    elseif love.keyboard.isDown("w") then
        Player.x = Player.x + math.cos(Player.r) * Player.speed * dt
        Player.y = Player.y + math.sin(Player.r) * Player.speed * dt
    end

    if love.keyboard.isDown("a") then
        Player.x = Player.x - math.cos(Player.r + math.rad(90)) * Player.speed * dt
        Player.y = Player.y - math.sin(Player.r + math.rad(90)) * Player.speed * dt
    elseif love.keyboard.isDown("d") then
        Player.x = Player.x + math.cos(Player.r + math.rad(90)) * Player.speed * dt
        Player.y = Player.y + math.sin(Player.r + math.rad(90)) * Player.speed * dt
    end

    --bullet code
    for i,v in ipairs(self.Bullets) do
        v:update(dt)
        if v.lifetime <= 0 then
            table.remove(self.Bullets,i)
        end
    end
end


function Player:keypressed(key)
    
end

function Player:mousepressed(x,y,button)
    if(button == 1)then
        local vx = math.cos(Player.r)
        local vy = math.sin(Player.r)
        table.insert(self.Bullets,Bullet(Player.x,Player.y,vx,vy))
    end
end


function Player:resolveWallCollision(wall)

    local closestX = math.max(wall.x, math.min(self.x, wall.x + wall.w))
    local closestY = math.max(wall.y, math.min(self.y, wall.y + wall.h))

    local distToClosestX = Player.x - closestX
    local distToClosestY = Player.y - closestY
    

    if distToClosestX == 0 then
        if closestY > Player.y then
            Player.y = closestY - Player.size
        else
            Player.y = closestY + Player.size
        end
        
    else
        if closestX > Player.x then
            Player.x = closestX - Player.size
        else
            Player.x = closestX + Player.size
        end
        
    end
end

function Player:takeDamage()
    self.health = self.health - 1
end