
state_ingame = Gamestate.new()

local tiles = nil
local camera = nil

-- focus camera on map position
local function focusCamera(x, y)
    
    if not camera then camera = Camera(0, 0) end
    
    local sx, sy = convertToScreen(x, y, 0)
    camera:lookAt(sx, sy)
end


function state_ingame:enter()
    updateScreen()
    focusCamera(4, 4)
    tiles = {}
    for x = 1,grid.xs do
        tiles[x] = {}
        for y = 1,grid.ys do
            tiles[x][y] = { z = 0, tile = math.random(1,2)}
        end
    end
    tiles[3][4].z = 1
end


function state_ingame:update(dt)
    
end


function state_ingame:draw()
    camera:attach()
    for x = 1,#tiles,1 do
        for y = 1,#tiles[x] do
            if tiles[x] and tiles[x][y] then
                local sx,sy = convertToScreen(x, y, tiles[x][y].z)
                if tiles[x][y].tile == 1 then
                    love.graphics.draw(Image.tile, sx - grid.w * 0.5, sy)
                else
                    love.graphics.draw(Image.grass, sx - grid.w * 0.5, sy)
                end
            end
        end
    end
    camera:detach()
end


function state_ingame:mousepressed(x, y, button)
    if button == "l" then
        local mx, my = convertToMap(x, y)
        print(mx, my)
    end
end
