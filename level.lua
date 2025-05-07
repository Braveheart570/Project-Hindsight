local Screen = require "screen"
local Level = Screen:extend()

require "Player"

function Level:new()
    
end

function Level:update(dt)
    if love.keyboard.isDown("d") then
        Player.r = Player.r + math.rad(Player.speed)*dt
    elseif love.keyboard.isDown("a") then
        Player.r = Player.r - math.rad(Player.speed)*dt
    end


    Player.vx = math.sin(Player.r)
    Player.vy = math.cos(Player.r)
end

function Level:drawEnv()
    love.graphics.setColor(0.3,0,1)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
end

function Level:drawEntities()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",100,100,50)

end

function Level:keypressed(key)
    
end

function Level:mousepressed(x,y,button)
end

function Level:reset()
end



return Level