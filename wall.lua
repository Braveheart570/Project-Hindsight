local Object = require "classic"
local Wall = Object:extend()

function Wall:new(x,y,w,h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    
end

function Wall:draw()
    love.graphics.setColor(0.69,0.53,0.41)
    love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end




return Wall