if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end




local image


function love.load()

    image = love.graphics.newImage("carpathianSprites.png")

end


function love.update(dt)
end


function love.draw()
    love.graphics.draw(image,0,0)
end


function love.keypressed(key)

    if key == "r" then love.event.quit "restart" end

end



--sits at the bottom of our script
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end