local Bullet = require("bullet")

local hit = love.audio.newSource("sounds/hit.ogg", "static")
local gunShot = love.audio.newSource("sounds/gunshot.ogg", "static")
local gunLoad = love.audio.newSource("sounds/gunload.ogg", "static")


Player = {
    x=CanvasWidth/2,
    y=CanvasHeight/2,
    r=math.rad(45),
    size = 30,
    speed = 150,
    sprintSpeed = 250,
    health = 10,
    Bullets = {},
    tookDamage = false,
    damageTime = 0.5,
    damageTimer = 0
}

function Player:reset()
    self.x=CanvasWidth/2
    self.y=CanvasHeight/2
    self.r=math.rad(45)
    self.size = 30
    self.speed = 150
    self.sprintSpeed = 250
    self.health = 10
    self.magCapacity = 6
    self.mag = self.magCapacity
    self.Bullets = {}
    self.tookDamage = false
    self.damageTime = 0.5
    self.damageTimer = 0
end

function Player:drawVisionMask()
    if self.tookDamage == true then
        love.graphics.setColor({1,0.6,0.6})
    else
        love.graphics.setColor({0.6,0.6,0.7})
    end
    
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
        if(love.keyboard.isDown("lshift"))then
            Player.x = Player.x + math.cos(Player.r) * Player.sprintSpeed * dt
            Player.y = Player.y + math.sin(Player.r) * Player.sprintSpeed * dt
        else
            Player.x = Player.x + math.cos(Player.r) * Player.speed * dt
            Player.y = Player.y + math.sin(Player.r) * Player.speed * dt
        end
        
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

    --damage effect timer
    if self.tookDamage == true then
        self.damageTimer = self.damageTimer - dt
        if self.damageTimer <= 0 then
            self.tookDamage = false
        end
    end


end


function Player:keypressed(key)
    if key == "r" then
        self.mag = self.magCapacity
        restartSound(gunLoad)
    end
end

function Player:mousepressed(x,y,button)
    if button == 1 and self.mag > 0 and gunLoad:isPlaying() == false then
        local vx = math.cos(Player.r)
        local vy = math.sin(Player.r)
        table.insert(self.Bullets,Bullet(Player.x,Player.y,vx,vy))
        self.mag = self.mag - 1
        restartSound(gunShot)
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
    self.tookDamage = true
    self.damageTimer = self.damageTime

    restartSound(hit)

end