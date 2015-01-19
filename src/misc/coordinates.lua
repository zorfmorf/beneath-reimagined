--[[
--  Coordinate conversions necessary to handle 2.5d perspective and map coordinates.
--  
--  Map coordinates are used for all game logic. Math.floor on an object's map coords
--  will give you the object's tile position coords (which are also the tile's grid index)
--  
--  Screen coordinates are coordinates used for drawing on the screen and depend on the
--  change with the texture size.
--  
--  However, there is a third component, the hump.camera library which is used to handle
--  the camera position. So if you want to know map coordinates for something on the screen
--  you need to to do two calls: convertToMap(camera:worldCoords(x,y))
]]--

-- contains all variables related to 2.5d perspective drawing
grid = {
    w = 128, -- tile width
    h = 64, -- tile height
    z = 78, -- tile z height (game may not use layered terrain but it is supported.
    xs = 20, -- map width
    ys = 20 -- map height
}


-- Convert screen coordinates to map coordinates
-- inverse to convertToScreen
-- CAUTION: when calling make sure not to call with camera coordinates!
-- z is currently ignored because z-layers are not fully implemented/supported
function convertToMap(x, y, z)
    local mx = y / grid.h + x / grid.w
    local my = y / grid.h - x / grid.w
    return mx, my
end


-- Convert map coordinates (object grid) to coordinates used to draw on screen
-- inverse to convertToMap
function convertToScreen(x, y, z)
    local sx = (x - y) * grid.w * 0.5
    local sy = (x + y) * grid.h * 0.5 - z * grid.z
    return sx, sy
end
