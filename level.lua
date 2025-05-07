local Screen = require "screen"
local Level = Screen:extend()

require "Player"

local walls = {}

function Level:new()
    local Wall = require("wall")
    --table.insert(walls,Wall(CanvasWidth/2 - 200,CanvasHeight/2 - 25,30,100))
    table.insert(walls,Wall(CanvasWidth/2 + 200,CanvasHeight/2 + 25,200,200))
end

function Level:update(dt)

    Player:update(dt)

    
    
end

function Level:drawEnv()
    
    love.graphics.setColor(0.3,0,1)
    love.graphics.rectangle("fill",0,0,CanvasWidth,CanvasHeight/2)
    love.graphics.setColor(0,0.7,0.1)
    love.graphics.rectangle("fill",0,CanvasHeight/2,CanvasWidth,CanvasHeight)
    for i,v in ipairs(walls)do
        v:draw()
    end
    Player:draw()

    love.graphics.setColor(0,1,0)
    love.graphics.setFont(love.graphics.newFont(20))
    for i,v in ipairs(walls)do
        love.graphics.print(i .. " : " .. tostring(v:CheckCollisionWithCircle(Player.x,Player.y,Player.size)),Player.x - 300,Player.y - 300 + 25*i)
    end
end

function Level:drawEntities()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",CanvasWidth/2 + 200,CanvasHeight/2 - 100,50)

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