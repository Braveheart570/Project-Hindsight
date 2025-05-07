
Player = {
    x=love.graphics.getWidth()/2,
    y=love.graphics.getHeight()/2,
    r=math.rad(45),
    speed = 50
}

function Player:drawVisionMask()
    love.graphics.setColor({0.2,0.2,0.2})
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",Player.x,Player.y,50)

    local p1 = {}
    local p2 = {}
    local viewAngle = 40
    local length = 1000

    p1.x = (math.cos(Player.r - math.rad(viewAngle/2)) * length) + Player.x
    p1.y = (math.sin(Player.r - math.rad(viewAngle/2)) * length) + Player.y

    p2.x = (math.cos(Player.r + math.rad(viewAngle/2)) * length) + Player.x
    p2.y = (math.sin(Player.r + math.rad(viewAngle/2)) * length) + Player.y

    love.graphics.polygon("fill",{Player.x,Player.y,p1.x,p1.y,p2.x,p2.y})
end



