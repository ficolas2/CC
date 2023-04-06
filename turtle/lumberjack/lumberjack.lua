require "turtleUtils"

base = {x=0, y=0, z=0}

rows = 3
columns = 3
spacing = 5

goTo(base.x, base.y, base.z)

for c_row = 1, rows do
    for c_column = 1, columns do
        turtle.forward(5)
    end
end
