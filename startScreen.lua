local Screen = require "screen"
local Button = require "button"
local VSlider = require "volumeSlider"

local StartScreen = Screen:extend()

--start screen code goes here
local titleBox = {x = 150, y = 100, width = 500, height = 100}



local startButton = Button("Start",250,500,300,50,function() ChangeScreen(2) end,love.graphics.newFont(25),{1,1,1},{0.8,0.1,0.1})
local tutorialbutton = Button("Tutorial",250,300,300,50,function() ChangeScreen(4) end, love.graphics.newFont(25),{1,1,1},{0.6,0.1,152})

local creditsButton = Button("Credits",20,20,100,50,function() ChangeScreen(5) end, love.graphics.newFont(20),{1,1,1},{0.3,0.7,0.3})

local vSlider = VSlider(SCREEN_WIDTH/2,SCREEN_HEIGHT - 160,0.75)


function StartScreen:new()
    self.super.new()
end

function StartScreen:Update (dt)
    vSlider:Update(dt)
end

function StartScreen:DrawScreen()
   


    love.graphics.setBackgroundColor(.1,.1,.1)


    startButton:render()

    love.graphics.setColor(0.6,0.1,0.6)
    love.graphics.rectangle("fill", titleBox.x,titleBox.y, titleBox.width,titleBox.height)
    love.graphics.setColor(1,1,1)
    local titleFont = love.graphics.newFont(70)
    love.graphics.setFont(titleFont)
    local titleText = "Recall Rush!"
    local titleTextWidth = titleFont:getWidth(titleText)
    local titleTextHeight = titleFont:getHeight(titleText)
    love.graphics.print(titleText, titleBox.x + (titleBox.width / 2) - (titleTextWidth / 2),
    titleBox.y + (titleBox.height / 2) - (titleTextHeight / 2))


    tutorialbutton:render()
    creditsButton:render()
    vSlider:render()


end
   


function StartScreen:MousePressed(x, y, button)
    if button == 1 then
        startButton:CheckPressed(x,y)
        tutorialbutton:CheckPressed(x,y)
        creditsButton:CheckPressed(x,y)
    end
end







return StartScreen