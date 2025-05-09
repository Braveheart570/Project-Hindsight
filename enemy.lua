local Object = require "classic"
local Enemy = Object:extend()

function Enemy:new(x,y)
    self.x = x
    self.y = y
    self.size = 40
    self.speed = 100
    self.health = 5
    self.detectionRadius = 150
    self.loseTargetRadius = 450
    self.pauseTime = 6
    self.pauseTimer = self.pauseTime
    --[[
    states:
    0 - wander
    1 - attack
    2 - pause
    ]]
    self.state = 0
end

function Enemy:update(dt)

    if self.state == 0 then
        if CircleCircleCollision(Player.x,Player.y,Player.size,self.x,self.y,self.detectionRadius) == true then
            self.state = 1
        end
    elseif self.state == 1 then

        if CircleCircleCollision(Player.x,Player.y,Player.size,self.x,self.y,self.loseTargetRadius) == false then
            self.state = 0
        end

        local deltaX = Player.x - self.x
        local deltaY = Player.y - self.y
        local deltaMag = math.sqrt(deltaX*deltaX+deltaY*deltaY)
        deltaX = deltaX/deltaMag
        deltaY = deltaY/deltaMag

        self.x = self.x + self.speed * deltaX * dt
        self.y = self.y + self.speed * deltaY * dt
    
    elseif self.state == 2 then
        self.pauseTimer = self.pauseTimer - dt
        if self.pauseTimer <= 0 then
            self.state = 0
            self.pauseTimer = self.pauseTime
        end
    end
end




function Enemy:draw()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",self.x,self.y,self.size)
    --love.graphics.circle("line",self.x,self.y,self.detectionRadius)
    --love.graphics.circle("line",self.x,self.y,self.loseTargetRadius)
end



function Enemy:resolveWallCollision(wall)

    local closestX = math.max(wall.x, math.min(self.x, wall.x + wall.w))
    local closestY = math.max(wall.y, math.min(self.y, wall.y + wall.h))

    local distToClosestX = self.x - closestX
    local distToClosestY = self.y - closestY
    

    if distToClosestX == 0 then
        if closestY > self.y then
            self.y = closestY - self.size
        else
            self.y = closestY + self.size
        end
        
    else
        if closestX > self.x then
            self.x = closestX - self.size
        else
            self.x = closestX + self.size
        end
        
    end

end


return Enemy