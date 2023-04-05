require "stringUtils"
 
floors = {"Main", "Iron", "Gold"}
currentFloor = 2
 
buttonSize = 13
 
pressed = 0
 
rednet.open("front")
 
monitor = peripheral.wrap("right")
 
monitor.setTextScale(0.5)
 
function redraw()
    monitor.setBackgroundColor(colors.lightGray)
    monitor.setTextColor(colors.black)
    monitor.clear()
    for i=1, #floors, 1 do
        if (i == currentFloor) then
            monitor.setBackgroundColor(colors.orange)
        elseif (i == pressed) then
            monitor.setBackgroundColor(colors.green)
        else
            monitor.setBackgroundColor(colors.white)
        end
        monitor.setCursorPos(2, (i-1) * 4 + 2)
        monitor.write("             ")
        monitor.setCursorPos(2, (i-1) * 4 + 3)
        local remaining = buttonSize - string.len(floors[i])
        for i=1, math.floor(remaining/2), 1 do
            monitor.write(" ")
        end
        remaining = remaining - math.floor(remaining/2)
        
        monitor.write(floors[i])
        for i=1, remaining, 1 do
            monitor.write(" ")
        end
        
        monitor.setCursorPos(2, (i-1) * 4+4)
        monitor.write("             ")
    end
end
 
redraw()
 
function checkButton()
 
    local event, button, x, y = os.pullEvent("monitor_touch")
    
    if (x<2 or x>14) then return end
    if (y%4==1)      then return end
        
    floor = math.floor((y - 1)/4) + 1
    
    if (floors[floor] == nil) then return end
    
    term.write(floors[floor])
    
    pressed = floor
    redraw()
    
    updateFloor(currentFloor, floor)
    rednet.broadcast(currentFloor .. "," .. floor)
end
 
function updateFloor(fromFloor, toFloor)
    term.write("a")
    if (toFloor ~= currentFloor) then
        redstone.setAnalogOutput("left", 0)
        return 
    end
    term.write("b")
    
    if (fromFloor<currentFloor) then
        redstone.setAnalogOutput("left", 2)
    elseif (fromFloor>currentFloor) then
        redstone.setAnalogOutput("left", 3)
    else
        redstone.setAnalogOutput("left", 15)
    end
    
    pressed = toFloor
    redraw()
end
 
function monitorThread()
    while (true) do
        checkButton()
    end
end
 
function checkNetwork()
    local senderId, message, protocol = rednet.receive()
    
    splitMessage = split(message, ",")
    fromFloor = splitMessage[1]
    toFloor = splitMessage[2]
    
    term.write(fromFloor .. " " .. toFloor .. " | ")
    
    updateFloor(tonumber(fromFloor), tonumber(toFloor))
end
 
function networkThread()
    while (true) do
        checkNetwork()
    end
end
 
parallel.waitForAll(monitorThread, networkThread)