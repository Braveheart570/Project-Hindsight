local Screen = require "screen"
local Level = Screen:extend()

require "player"



function Level:new()
    self.super:new()
    self.renderPlayerView = true

    self:reset()
    
end

function Level:reset()
    local Wall = require("wall")
    local Enemy = require("enemy")

    Player:reset()

    self.walls = {}
    self.Enemies = {}

    self.exit = {
        x=CanvasWidth/2 + 1670,
        y=CanvasHeight/2 - 800,
        w=50,
        h=50
    }

    table.insert(self.walls,Wall(CanvasWidth/2 - 300,CanvasHeight/2 - 300,30,800))
    table.insert(self.walls,Wall(CanvasWidth/2 - 300,CanvasHeight/2 - 300,1600,30))
    table.insert(self.walls,Wall(CanvasWidth/2 + 500,CanvasHeight/2 -300,30,600))
    table.insert(self.walls,Wall(CanvasWidth/2 - 300,CanvasHeight/2 + 500,1600,30))
    table.insert(self.walls,Wall(CanvasWidth/2 + 500,CanvasHeight/2 + 300,400,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +1400,CanvasHeight/2 + 500,1200,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +1420,CanvasHeight/2 + 500,30,500))
    table.insert(self.walls,Wall(CanvasWidth/2 +1000,CanvasHeight/2 + 500,30,500))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1100,CanvasHeight/2 + 300,400,30))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1500,CanvasHeight/2 - 70,30,400))

    table.insert(self.walls,Wall(CanvasWidth/2 +1000,CanvasHeight/2 + 1200,1200,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +1800,CanvasHeight/2 + 130,30,400))
    table.insert(self.walls,Wall(CanvasWidth/2 +1800,CanvasHeight/2 - 300,30,250))
    table.insert(self.walls,Wall(CanvasWidth/2 +1500,CanvasHeight/2 - 300,30,250))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1000,CanvasHeight/2 - 500,30,200))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1000,CanvasHeight/2 - 500,600,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +1800,CanvasHeight/2 - 300,100,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +2000,CanvasHeight/2 - 300,600,30))
    table.insert(self.walls,Wall(CanvasWidth/2 +2600,CanvasHeight/2 - 300,30,830))
    table.insert(self.walls,Wall(CanvasWidth/2 +2200,CanvasHeight/2 + 300,100,100))

    table.insert(self.walls,Wall(CanvasWidth/2 +2200,CanvasHeight/2 ,100,100))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1800,CanvasHeight/2 - 500,400,30))
    table.insert(self.walls,Wall(CanvasWidth/2 + 2200,CanvasHeight/2 - 500,30,230))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1570,CanvasHeight/2 - 900,30,400))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1800,CanvasHeight/2 - 900,30,400))
    table.insert(self.walls,Wall(CanvasWidth/2 + 1570,CanvasHeight/2 - 900,230,30))




    table.insert(self.Enemies,Enemy(CanvasWidth/2 + 200,CanvasHeight/2 - 100))
    table.insert(self.Enemies,Enemy(CanvasWidth/2 - 200,CanvasHeight/2 + 150))

    table.insert(self.Enemies,Enemy(4141, 2805))
    table.insert(self.Enemies,Enemy(4952, 2774))
    table.insert(self.Enemies,Enemy(5054, 2845))
    table.insert(self.Enemies,Enemy(4782, 2972))
    table.insert(self.Enemies,Enemy(4939, 3222))
    table.insert(self.Enemies,Enemy(5320, 2800))
    table.insert(self.Enemies,Enemy(5195, 2492))
    table.insert(self.Enemies,Enemy(5183, 2367))
    table.insert(self.Enemies,Enemy(5280, 2346))
    table.insert(self.Enemies,Enemy(5365, 2263))
    table.insert(self.Enemies,Enemy(5231, 2270))
    table.insert(self.Enemies,Enemy(5195, 2177))
    table.insert(self.Enemies,Enemy(5317, 2134))
    table.insert(self.Enemies,Enemy(5607, 2304))
    table.insert(self.Enemies,Enemy(6032, 2432))
    table.insert(self.Enemies,Enemy(6060, 2733))
    table.insert(self.Enemies,Enemy(5723, 2009))
    table.insert(self.Enemies,Enemy(5114, 2035))
    table.insert(self.Enemies,Enemy(4713, 2011))
    table.insert(self.Enemies,Enemy(4735, 2242))
    table.insert(self.Enemies,Enemy(4523, 2317))
    table.insert(self.Enemies,Enemy(4396, 2540))
    table.insert(self.Enemies,Enemy(4208, 2643))
    table.insert(self.Enemies,Enemy(CanvasWidth/2 + 1670, CanvasHeight/2 - 800))

    self.totalEnemies = #self.Enemies

end

function Level:update(dt)

    -- death check
    if Player.health <= 0 then
        ChangeScreen(3)
    end


    Player:update(dt)

    --wall collisions
    for i,wall in ipairs(self.walls)do
        if CheckCollisionWithCircle(wall.x,wall.y,wall.w,wall.h,Player.x,Player.y,Player.size) then
            Player:resolveWallCollision(wall)
        end
        for j,enemy in ipairs(self.Enemies)do
            if CheckCollisionWithCircle(wall.x,wall.y,wall.w,wall.h,enemy.x,enemy.y,enemy.size) then
                enemy:resolveWallCollision(wall)
            end
        end
    end

    
   
    for i,enemy in ipairs(self.Enemies)do

         -- bullet collisions
        for j, bullet in ipairs(Player.Bullets)do
            if CircleCircleCollision(bullet.x,bullet.y,bullet.size,enemy.x,enemy.y,enemy.size)then
                table.remove(Player.Bullets,j)
                enemy.health = enemy.health - 1
                enemy.state = 1
                enemy.pauseTimer = enemy.pauseTime; -- todo this should be done somewhere else
                if enemy.health <= 0 then
                    table.remove(self.Enemies,i)
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

    -- win condition
    if CheckCollisionWithCircle(self.exit.x,self.exit.y,self.exit.w,self.exit.h,Player.x,Player.y,Player.size)then
        ChangeScreen(4)
    end
    
end

function Level:drawEnv()
    
    love.graphics.setColor(0.23,0.13,0.05)
    love.graphics.rectangle("fill",0,0,CanvasWidth,CanvasHeight)
    for i,v in ipairs(self.walls)do
        v:draw()
        love.graphics.setColor(1,1,1)
    end

    --render exit
    love.graphics.setColor(0.7,1,0.7)
    love.graphics.rectangle("fill",self.exit.x,self.exit.y,self.exit.w,self.exit.h)

    Player:draw()


end

function Level:drawEntities()
    for i,v in ipairs(self.Enemies)do
        if v.health > 0 then
            v:draw()
        end
    end
end

function Level:drawUI()
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont(25))
    love.graphics.print("Health: "..Player.health,Player.x - love.graphics.getWidth()/2 + 30,Player.y - love.graphics.getHeight()/2 + 30)
    love.graphics.print("Ammo: "..Player.mag.."/"..Player.magCapacity,Player.x + love.graphics.getWidth()/2 - 170,Player.y - love.graphics.getHeight()/2 + 30)
end

function Level:keypressed(key)
    Player:keypressed(key)
end

function Level:mousepressed(x,y,button)
    Player:mousepressed(x,y,button)
end



return Level