
state_ingame = Gamestate.new()

local tiles = nil -- contains map
camera = nil -- camera object
local holdmouse = nil -- contains last mouse coordinates if camera is currently dragged

-- focus camera on map position
local function focusMapPos(x, y)
    
    if not camera then camera = Camera(0, 0) end
    
    local sx, sy = convertToScreen(x, y, 0)
    camera:lookAt(sx, sy)
end


function state_ingame:enter()
    updateScreen()
    focusMapPos(0, 0)
    tiles = {}
    for x = 1,grid.xs do
        tiles[x] = {}
        for y = 1,grid.ys do
            tiles[x][y] = { z = 0, tile = 4, build = nil}
        end
    end
end


function state_ingame:update(dt)
    if holdmouse then 
        local mx, my = love.mouse.getPosition()
        camera:move(holdmouse[1] - mx, holdmouse[2] - my)
        holdmouse = {mx, my}
    end
end


function state_ingame:draw()
    camera:attach()
    for x = 1,#tiles,1 do
        for y = 1,#tiles[x] do
            if tiles[x] and tiles[x][y] then
                local sx,sy = convertToScreen(x, y, tiles[x][y].z)
                
                love.graphics.setColor(255, 255, 255, 255)
                if tiles[x][y].selected or x == 8 and y == 2 then
                    love.graphics.setColor(255, 0, 9, 255)
                end
                
                love.graphics.draw(Tile[tiles[x][y].tile], sx - grid.w * 0.5, sy)
                
                if tiles[x][y].build then                    
                    local img = Build[tiles[x][y].build]
                    love.graphics.draw(img, sx - grid.w * 0.5, sy, 0, 1, 1, 0, img:getHeight() - grid.h)
                end
            end
        end
    end
    camera:detach()
end


function state_ingame:mousepressed(x, y, button)
    if button == "l" then
        local mx, my = convertToMap(camera:worldCoords(x, y))
        if tiles[math.floor(mx)] and tiles[math.floor(mx)][math.floor(my)] then
            tiles[math.floor(mx)][math.floor(my)].selected = true
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
