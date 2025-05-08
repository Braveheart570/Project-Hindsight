local Object = require "classic"
local Bullet = Object:extend()

function Bullet:new(x,y,vx,vy)
    self.x = x
    self.y = y
    self.vx = vx
    self.vy = vy
    self.speed = 800
    self.lifetime = 10
    self.size = 10
end



function Bullet:update(dt)
    self.x = self.x + self.vx*self.speed*dt
    self.y = self.y + self.vy*self.speed*dt

    self.lifetime = self.lifetime - dt

end

function Bullet:draw()
    love.graphics.setColor(1,1,0)
    love.graphics.circle("fill",self.x,self.y,10)
end


function Bullet:CircleCircleCollision(otherX,otherY,otherSize)

    local deltaX = self.x - otherX
    local deltaY = self.y - otherY

    local dist = math.sqrt(deltaX*deltaX+deltaY*deltaY)

    if dist < otherSize + self.size then
        return true
    else
        return false
    end

end


return Bullet