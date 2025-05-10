

  -- loads files as a string
 function LoadFile(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end


-- circle vs circle collision detection
function CircleCircleCollision(firstX,firstY,firstSize,secondX,secondY,SecondSize)

    local deltaX = firstX - secondX
    local deltaY = firstY - secondY

    local dist = math.sqrt(deltaX*deltaX+deltaY*deltaY)

    if dist < SecondSize + firstSize then
        return true
    else
        return false
    end

end

-- circle vs box collision detection
function CheckCollisionWithCircle(bx,by,bw,bh,cx,cy,cr)

    local closestX = math.max(bx, math.min(cx, bx + bw))
    local closestY = math.max(by, math.min(cy, by + bh))


    --print(closestX.." - "..closestY)

    local dx = cx - closestX
    local dy = cy - closestY


    return (dx * dx + dy * dy) < (cr * cr)

end

-- overlap sound in itself
function restartSound(sound)
    if(sound:isPlaying() == true)then
        sound:stop()
    end
    sound:play()
end