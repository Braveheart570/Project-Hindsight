if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
  end

local shader_code = [[

vec4 effect(vec4 color,Image image, vec2 uvs, vec2 screen_coords){

  vec4 pixel = Texel(image, uvs);

  return pixel * color;
}

]]


local image
local shader

function love.load()

    image = love.graphics.newImage("carpathianSprites.png")
    shader = love.graphics.newShader(shader_code)
end


function love.update(dt)
end


function love.draw()
    love.graphics.setShader(shader)
    love.graphics.setColor(1,0,0)
    love.graphics.draw(image,0,0)
    love.graphics.setShader()
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