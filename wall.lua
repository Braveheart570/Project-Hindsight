local Object = require "classic"
local Wall = Object:extend()

function Wall:new(x,y,w,h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
end

function Wall:draw()
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end

local function vectorMagSqr(vector)
    return vector[1] * vector[1] + vector[2] * vector[2]
end

local function vectorMag(vector)
    return math.sqrt(vectorMagSqr(vector))
end

local function Clamp(val,min,max)
    if val > max then return max end
    if val < min then return min end
    return val
end

local function Dot (v1,v2)
    return v1[1]*v2[1] + v1[2]*v2[2]
end


local function PointToLineDistance(p1,p2,p3)

    local slope = {
        p2[1]-p1[1],
        p2[2]-p1[2]
    }

    local param = Clamp(Dot({p3[1]- p1[1],p3[2]- p1[2]},slope) / vectorMagSqr(slope),0.0,1.0)

    local nearestPoint = {
        p1[1]+slope[1]*param,
        p1[2]+slope[2]*param
    }

    local returnVector = {p3[1]-nearestPoint[1],p3[2]-nearestPoint[2]}

    return vectorMag(returnVector)

end

function Wall:CheckCollisionWithCircle(cx,cy,cr)

    local closestX = math.max(self.x, math.min(cx, self.x + self.w))
    local closestY = math.max(self.y, math.min(cy, self.y + self.h))

    local dx = cx - closestX
    local dy = cy - closestY

    return (dx * dx + dy * dy) < (cr * cr)

end


return Wall