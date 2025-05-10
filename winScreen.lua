local Screen = require "screen"
local Button = require "button"

local GameOverScreen = Screen:extend()

local screenRelative = {
    x = Player.x - love.graphics.getWidth()/2;
    y = Player.y - love.graphics.getHeight()/2
}

--start screen code goes here
local titleBox = {x = screenRelative.x + love.graphics.getWidth()/2 - 400, y = screenRelative.y + 100, width = 800, height = 100}



local startButton = Button("Main Menu",CanvasWidth/2 - 150,CanvasHeight/2 - 25,300,50,function() ChangeScreen(1) end,love.graphics.newFont(25),{1,1,1},{0.8,0.1,0.1})


function GameOverScreen:new()
    self.super:new()
end

function GameOverScreen:Update (dt)
end

function GameOverScreen:drawUI()
   


    love.graphics.setColor(.2,.2,.2)
    love.graphics.rectangle("fill",0,0,CanvasWidth,CanvasHeight)


    startButton:render()

    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill", titleBox.x,titleBox.y, titleBox.width,titleBox.height)
    love.graphics.setColor(1,1,1)
    local titleFont = love.graphics.newFont(70)
    love.graphics.setFont(titleFont)
    local titleText = "WIN!"
    local titleTextWidth = titleFont:getWidth(titleText)
    local titleTextHeight = titleFont:getHeight(titleText)
    love.graphics.print(titleText, titleBox.x + (titleBox.width / 2) - (titleTextWidth / 2),
    titleBox.y + (titleBox.height / 2) - (titleTextHeight / 2))

    local scoreFont = love.graphics.newFont(20)
    love.graphics.setFont(scoreFont)
    local scoreText = "you killed " .. Screens[2].totalEnemies - #Screens[2].Enemies .."/"..Screens[2].totalEnemies .. " enemies."
    local scoreTextWidth = scoreFont:getWidth(scoreText)
    local scoreTextHeight = scoreFont:getHeight(scoreText)
    love.graphics.print(scoreText, titleBox.x + (titleBox.width / 2) - (scoreTextWidth / 2),
    titleBox.y + 100 + (titleBox.height / 2) - (scoreTextHeight / 2))


end
   


function GameOverScreen:mousepressed(x, y, button)
    if button == 1 then
        startButton:CheckPressed(x+ screenRelative.x, y + screenRelative.y)
    end
end







return GameOverScreen