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