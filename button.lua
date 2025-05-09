local Object = require "classic"
local Button = Object:extend()


function Button:new(text, x, y, w, h, action, font, fontColor, backColor)
    self.text = text
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.action = action
    self.font = font
    self.backColor = backColor
    self. fontColor = fontColor
end

function Button:render()
    love.graphics.setColor(self.backColor)
    love.graphics.rectangle("fill", self.x,self.y,self.w,self.h)
    love.graphics.setColor(self.fontColor)
    love.graphics.setFont(self.font)
    local textWidth = self.font:getWidth(self.text)
    local textHeight = self.font:getHeight(self.text)
    love.graphics.print(self.text, self.x + (self.w / 2) - (textWidth / 2),
    self.y + (self.h / 2) - (textHeight / 2))
end

function Button:CheckPressed(x,y)
    if x >= self.x and x <= self.x + self.w and
           y >= self.y and y <= self.y + self.h then
            self.action()
            return
        end
end

return Button