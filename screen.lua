
local Object = require "classic"
local Screen = Object:extend()

function Screen:new()
    self.renderPlayerView = false
end

function Screen:update(dt)
end

function Screen:drawEnv()
end

function Screen:drawEntities()
end

function Screen:drawUI()
end

function Screen:keypressed(key)
end

function Screen:mousepressed(x,y,button)
end

function Screen:reset()
end



return Screen