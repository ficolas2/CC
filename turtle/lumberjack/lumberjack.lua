require "turtleUtils"

base = {x=0, y=0, z=0}

rows = 2
columns = 2
spacing = 5

goTo(base.x, base.y, base.z)

function placeSappling()
    turtle.select(1)
    turtle.placeDown()
end

function tree()
    if (turtle.detect()) then
        turtle.dig()
        turtle.forward()
        turtle.digDown()
        placeSappling()
        while (turtle.digUp()) do turtle.up() end
        while (turtle.down()) do end
    else
        turtle.forward()
        placeSappling()
    end
end

function makePass()
    for c_row = 1, rows do
        for c_column = 1, columns do
            turtle.forward(spacing)
            tree()
        end
        turtle.forward()
        turtle.turnRight()
        turtle.forward(spacing)
        turtle.turnRight()
    
    end
end

makePass()
makePass()