
local oldTurtle = {}

for k, v in pairs(turtle) do
    oldTurtle[k] = v
end

function doYMovement()
    -- +y movement
    while dy > 0 do
        dy = dy - 1
        while (not turtle.up()) do end
    end

    -- -z movement
    while dy < 0 do
        dy = dy + 1
        while (turtle.down()) do end
    end
end


turtle.forward = function(amount=1)
    for i = 1, amount do
        moved = oldTurtle.forward()
        if (~moved) then
            return false
        end
    end
end

turtle.goTo = function(x, y, z, yFirst = true)
    --must be pointing towards +x direction
    local c_x, c_y, c_z = gps.locate()
    if c_x == nil then
        print("No GPS signal")
        return
    end
    dx, dy, dz = x - c_x, y - c_y, z - c_z

    if (yFirst) then doYMovement() end

    -- +x movement
    while dx > 0 do
        dx = dx - 1
        turtle.forward()
    end

    turtle.turnLeft()

    -- +z movement
    while dz > 0 do
        dz = dz - 1
        turtle.forward()
    end

    turtle.turnLeft()

    -- -x movement
    while dx < 0 do
        dx = dx + 1
        turtle.forward()
    end

    turtle.turnLeft()

    -- -z movement
    while dz < 0 do
        dz = dz + 1
        turtle.forward()
    end

    turtle.turnLeft()

    if (~yFirst) then doYMovement() end

end