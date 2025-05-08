local Object = require "classic"
local Enemy = Object:extend()

function Enemy:new(x,y,r)
    self.x = x
    self.y = y
    self.r = r
    self.size = 40
    self.speed = 120
    self.health = 5
    self.detectionRadius = 200
    self.lossTargetRadius = 600
    --[[
    states:
    0 - wander
    1 - attack
    ]]
    self.state = 0
end

function Enemy:update(dt)

    if self.state == 0 then
        if CircleCircleCollision(Player.x,Player.y,Player.size,self.x,self.y,self.detectionRadius) == true then
            self.state = 1
        end
    elseif self.state == 1 then

        if CircleCircleCollision(Player.x,Player.y,Player.size,self.x,self.y,self.lossTargetRadius) == true then
            self.state = 1
        end

        local deltaX = Player.x - self.x
        local deltaY = Player.y - self.y
        local deltaMag = math.sqrt(deltaX*deltaX+deltaY*deltaY)
        deltaX = deltaX/deltaMag
        deltaY = deltaY/deltaMag

        self.x = self.x + self.speed * deltaX * dt
        self.y = self.y + self.speed * deltaY * dt
    
    end
end




function Enemy:draw()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",self.x,self.y,self.size)
end

return Enemy