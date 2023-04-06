local oldTurtle = {}

for k, v in pairs(turtle) do
    oldTurtle[k] = v
end

turtle.forward = function(amount)
    if (amount == nil) then amount = 1 end
    if (amount < 0) then
        return turtle.back(-amount)
    end
    for i = 1, amount do

        moved = oldTurtle.forward()
        if (not moved) then
            return false
        end
    end
end

turtle.back = function(amount)
    if (amount == nil) then amount = 1 end
    if (amount < 0) then
        return turtle.forward(-amount)
    end
    for i = 1, amount do

        moved = oldTurtle.back()
        if (not moved) then
            return false
        end
    end
end

turtle.up = function(amount)
    if (amount == nil) then amount = 1 end
    if (amount < 0) then
        return turtle.down(-amount)
    end
    for i = 1, amount do

        moved = oldTurtle.up()
        if (not moved) then
            return false
        end
    end
end

turtle.down = function(amount)
    if (amount == nil) then amount = 1 end
    if (amount < 0) then
        return turtle.up(-amount)
    end
    for i = 1, amount do

        moved = oldTurtle.down()
        if (not moved) then
            return false
        end
    end
end

turtle.goTo = function(x, y, z, yFirst)
    if (yFirst == nil) then yFirst = true end
    --must be pointing towards +x direction
    local c_x, c_y, c_z = gps.locate()
    if c_x == nil then
        print("No GPS signal")
        return
    end
    dx, dy, dz = x - c_x, y - c_y, z - c_z

    if (yFirst) then turtle.up(dy) end

    -- x movement
    turtle.forward(dx)
    turtle.turnLeft()

    -- +z movement
    turtle.forward(dz)
    turtle.turnRight()

    if (not yFirst) then turtle.up(dy) end

end