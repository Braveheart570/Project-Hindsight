local Screen = require "screen"
local Level = Screen:extend()

require "Player"

function Level:new()
    
end

function Level:update(dt)

    Player:update(dt)
    
end

function Level:drawEnv()
    love.graphics.setColor(0.3,0,1)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight()/2)
    love.graphics.setColor(0,0.7,0.1)
    love.graphics.rectangle("fill",0,love.graphics.getHeight()/2,love.graphics.getWidth(),love.graphics.getHeight())
    Player:draw()
end

function Level:drawEntities()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",100,100,50)

end

function Level:keypressed(key)
    Player:keypressed(key)
end

function Level:mousepressed(x,y,button)
    Player:mousepressed(x,y,button)
end

function Level:reset()
end



return Level