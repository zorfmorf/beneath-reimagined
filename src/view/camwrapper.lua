
local cam = require "lib.hump.camera"

local camera = nil -- camera object
local holdmouse = nil -- contains last mouse coordinates if camera is currently dragged
local movecollector = {0,0} -- collect camera movement and only apply it if its greater than 1 pixel to avoid pixel tearing


local function init()
    camera = cam(0, 0)
end

-- focus camera on map position
local function focusMapPos(x, y)
    local sx, sy = convertToScreen(x, y, 0)
    camera:lookAt(sx, sy)
end


local function attach()
    camera:attach()
end


local function detach()
    camera:detach()
end


local function worldCoords(x, y)
    return camera:worldCoords(x, y)
end


local function startDrag(x, y)
    holdmouse = {x,y}
    movecollector = {0,0}
end


local function endDrag()
    holdmouse = nil
end


local function update(dt)
    
    -- TODO cleanup
    
    local mx, my = love.mouse.getPosition()
    
    if holdmouse then
        movecollector[1] = movecollector[1] + holdmouse[1] - mx
        movecollector[2] = movecollector[2] + holdmouse[2] - my
        holdmouse = {mx, my}
    end
    
    if CAMERA_SIDE_MOV and love.window.hasMouseFocus() then
        local xt = math.floor(screen.w / CAMERA_THRESHOLD)
        local yt = math.floor(screen.h / CAMERA_THRESHOLD)
        
        if mx < xt then movecollector[1] = movecollector[1] - CAMERA_SPEED * dt end
        if mx > screen.w - xt then movecollector[1] = movecollector[1] + CAMERA_SPEED * dt end
        if my < yt then movecollector[2] = movecollector[2] - CAMERA_SPEED * dt end
        if my > screen.h - yt then movecollector[2] = movecollector[2] + CAMERA_SPEED * dt end
    end
    
    if movecollector[1] > 1 then
        camera:move(math.floor(movecollector[1]), 0)
        movecollector[1] = movecollector[1] - math.floor(movecollector[1])
    end
    
    if movecollector[1] < -1 then
        camera:move(math.ceil(movecollector[1]), 0)
        movecollector[1] = movecollector[1] - math.ceil(movecollector[1])
    end
    
    if movecollector[2] > 1 then
        camera:move(0, math.floor(movecollector[2]))
        movecollector[2] = movecollector[2] - math.floor(movecollector[2])
    end
    
    if movecollector[2] < -1 then
        camera:move(0, math.ceil(movecollector[2]))
        movecollector[2] = movecollector[2] - math.ceil(movecollector[2])
    end
    
end

return {
    init = init,
    focusMapPos = focusMapPos,
    worldCoords = worldCoords,
    startDrag = startDrag,
    endDrag = endDrag,
    update = update,
    detach = detach,
    attach = attach
}