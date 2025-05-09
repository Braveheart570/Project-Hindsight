local Screen = require "screen"
local Level = Screen:extend()

require "Player"

local walls = {}
local Enemies = {}

function Level:new()
    self.super:new()
    self.renderPlayerView = true
    

    self:reset()
    
end

function Level:reset()
    local Wall = require("wall")
    local Enemy = require("enemy")

    Player:reset()

    walls = {}
    Enemies = {}

    table.insert(walls,Wall(CanvasWidth/2 - 300,CanvasHeight/2 - 300,30,800))
    table.insert(walls,Wall(CanvasWidth/2 - 300,CanvasHeight/2 - 300,800,30))
    table.insert(walls,Wall(CanvasWidth/2 + 500,CanvasHeight/2 -300,30,800))

    table.insert(Enemies,Enemy(CanvasWidth/2 + 200,CanvasHeight/2 - 100,0))
    table.insert(Enemies,Enemy(CanvasWidth/2 - 200,CanvasHeight/2 + 150,0))

end

function Level:update(dt)

    -- death check
    if Player.health <= 0 then
        ChangeScreen(3)
    end


    Player:update(dt)

    --wall collisions
    for i,wall in ipairs(walls)do
        if wall:CheckCollisionWithCircle(Player.x,Player.y,Player.size) then
            Player:resolveWallCollision(wall)
        end
        for j,enemy in ipairs(Enemies)do
            if wall:CheckCollisionWithCircle(enemy.x,enemy.y,enemy.size) then
                enemy:resolveWallCollision(wall)
            end
        end
    end

    
   
    for i,enemy in ipairs(Enemies)do

         -- bullet collisions
        for j, bullet in ipairs(Player.Bullets)do
            if CircleCircleCollision(bullet.x,bullet.y,bullet.size,enemy.x,enemy.y,enemy.size)then
                table.remove(Player.Bullets,j)
                enemy.health = enemy.health - 1
                enemy.state = 1
                enemy.pauseTimer = enemy.pauseTime; -- todo this should be done somewhere else
                if enemy.health <= 0 then
                    table.remove(Enemies,i)
                end
            end
        end

        --enemy vs player collisions
        if enemy.state ~= 2 and CircleCircleCollision(Player.x,Player.y,Player.size,enemy.x,enemy.y,enemy.size)then
            Player:takeDamage()
            enemy.state = 2
        end

        -- update
        enemy:update(dt)

    end

    
    
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
end

function Level:drawEntities()
    for i,v in ipairs(Enemies)do
        if v.health > 0 then
            v:draw()
        end
    end
end

function Level:drawUI()
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont(25))
    love.graphics.print("Health: "..Player.health,Player.x - love.graphics.getWidth()/2 + 30,Player.y - love.graphics.getHeight()/2 + 30)
end

function Level:keypressed(key)
    Player:keypressed(key)
    if key == "r"then
        self:reset()
    end
end

function Level:mousepressed(x,y,button)
    Player:mousepressed(x,y,button)
end



return Level