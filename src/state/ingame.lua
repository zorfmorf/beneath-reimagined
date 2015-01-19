
state_ingame = Gamestate.new()

local tiles = nil -- contains map
local camera = nil -- camera object
local holdmouse = nil -- contains last mouse coordinates if camera is currently dragged

-- focus camera on map position
local function focusMapPos(x, y)
    local sx, sy = convertToScreen(x, y, 0)
    camera:lookAt(sx, sy)
end


-- Called once whenever entering state
function state_ingame:enter()
    
    -- update screen and camera coordinates
    updateScreen()
    camera = Camera(0, 0)
    focusMapPos(0, 0)
    
    -- generate/load tile grid
    -- TODO: remove placeholder grid and load from map file/generator
    tiles = {}
    for x = 1,grid.xs do
        tiles[x] = {}
        for y = 1,grid.ys do
            tiles[x][y] = { z = 0, tile = 4, build = nil}
        end
    end
    tiles[2][2].tile = 5
    tiles[2][1].tile = 9
    tiles[3][1].tile = 6
    tiles[4][3].tile = 10
    tiles[4][2].tile = 7
    tiles[3][3].tile = 8
    tiles[2][3].tile = 11
    tiles[4][1].tile = 12
    tiles[3][2].tile = 13
end


-- Everything is updated here
function state_ingame:update(dt)
    -- todo: update objects
    
    -- move camera if user is currently dragging
    if holdmouse then 
        local mx, my = love.mouse.getPosition()
        camera:move(holdmouse[1] - mx, holdmouse[2] - my)
        holdmouse = {mx, my}
    end
end


-- All draw calls go in here
function state_ingame:draw()
    
    -- draw game world
    camera:attach()
    love.graphics.setDefaultFilter("nearest", "nearest")
    for x = 1,#tiles,1 do
        for y = 1,#tiles[x] do
            if tiles[x] and tiles[x][y] then
                local sx,sy = convertToScreen(x, y, tiles[x][y].z)
                
                love.graphics.setColor(255, 255, 255, 255)
                if tiles[x][y].selected then
                    love.graphics.setColor(255, 0, 9, 255)
                end
                
                love.graphics.draw(Tile[tiles[x][y].tile], sx - grid.w * 0.5, sy)
                --love.graphics.line(sx, sy, sx + grid.w * 0.5, sy + grid.h * 0.5, sx, sy + grid.h, sx - grid.w * 0.5, sy + grid.h * 0.5, sx, sy)
                
                if tiles[x][y].build then
                    local img = Build[tiles[x][y].build]
                    love.graphics.draw(img, sx - grid.w * 0.5, sy, 0, 1, 1, 0, img:getHeight() - grid.h)
                end
            end
        end
    end
    camera:detach()
    
    -- draw hud
    
end


function state_ingame:mousepressed(x, y, button)
    if button == "l" then
        local mx, my = convertToMap(camera:worldCoords(x, y))
        if tiles[math.floor(mx)] and tiles[math.floor(mx)][math.floor(my)] then
            tiles[math.floor(mx)][math.floor(my)].selected = not tiles[math.floor(mx)][math.floor(my)].selected
        end
    end
    if button == "r" then
        holdmouse = { x, y}
    end
    if button == "wu" then
        camera:zoom(2)
    end
    if button == "wd" then
        camera:zoom(0.5)
    end
end


function state_ingame:mousereleased(x, y, button)
    if button == "r" then
        holdmouse = nil
    end
end
