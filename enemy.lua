local Object = require "classic"
local Enemy = Object:extend()

function Enemy:new(x,y,r)
    self.x = x
    self.y = y
    self.r = r
    self.size = 40
    self.health = 5
end

function Enemy:update()
end

function Enemy:draw()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",self.x,self.y,self.size)
end

return Enemy