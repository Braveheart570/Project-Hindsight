local Object = require "classic"
local Wall = Object:extend()

function Wall:new(x,y,w,h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
end

function Wall:draw()
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)

    local closestX = math.max(self.x, math.min(Player.x, self.x + self.w))
    local closestY = math.max(self.y, math.min(Player.y, self.y + self.h))
    love.graphics.setColor(1,0.5,0)
    love.graphics.circle("fill",closestX,closestY,10)

end

function Wall:CheckCollisionWithCircle(cx,cy,cr)

    local closestX = math.max(self.x, math.min(cx, self.x + self.w))
    local closestY = math.max(self.y, math.min(cy, self.y + self.h))


    --print(closestX.." - "..closestY)

    local dx = cx - closestX
    local dy = cy - closestY


    return (dx * dx + dy * dy) < (cr * cr)

end


return Wall