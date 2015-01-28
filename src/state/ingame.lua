
state_ingame = Gamestate.new()

tiles = nil -- contains map
local camera = nil -- camera object
local holdmouse = nil -- contains last mouse coordinates if camera is currently dragged

-- focus camera on map position
local function focusMapPos(x, y)
    local sx, sy = convertToScreen(x, y, 0)
    camera:lookAt(sx, sy)
end


-- if not nil, it contains the building the player wants to build
local buildmode = nil

local menu_open = {
    build = false
}


-- Called once whenever entering state
function state_ingame:enter()
    
    -- update screen and camera coordinates
    updateScreen()
    camera = Camera(0, 0)
    focusMapPos(5, 5)
    
    -- generate/load tile grid
    -- TODO: remove placeholder grid and load from map file/generator
    tiles = {}
    for x = 1,grid.xs do
        tiles[x] = {}
        for y = 1,grid.ys do
            tiles[x][y] = { z = 0, tile = 4, build = nil}
        end
    end
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
    
    -- update hud
    Gui.group.push{grow = "down", pos = {screen.w - 100, 0}}
    
    if Gui.Button{id = "btn_build", text = "Build"} then
        menu_open.build = not menu_open.build
    end
    
    Gui.group.pop{}
    
    if menu_open.build then
        Gui.group.push{grow = "down", pos = {screen.w - 200, 0}}
        
        if Gui.Button{id = "btn_build_corridor", text = "Corridor"} then
            buildmode = Corridor()
            menu_open.build = false
        end
        
        if Gui.Button{id = "btn_build_housing", text = "Housing"} then
            buildmode = Housing()
            menu_open.build = false
        end
        
        Gui.Button{id = "btn_build_barracks", text = "Barracks"}
        
        Gui.Button{id = "btn_build_labs", text = "Labs"}
        
        Gui.group.pop{}
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
                
                love.graphics.setColor(Color.default)
                if tiles[x][y].selected then
                    love.graphics.setColor(255, 0, 9, 255)
                end
                
                love.graphics.draw(Tile[tiles[x][y].tile], sx - grid.w * 0.5, sy)
                --love.graphics.line(sx, sy, sx + grid.w * 0.5, sy + grid.h * 0.5, sx, sy + grid.h, sx - grid.w * 0.5, sy + grid.h * 0.5, sx, sy)
                
                if tiles[x][y].build then
                    tiles[x][y].build:draw(sx, sy)
                end
            end
        end
    end
    
    -- draw build preview if in buildmode
    if buildmode then
        local mx, my = convertToMap(camera:worldCoords(love.mouse.getPosition()))
        mx = math.floor(mx)
        my = math.floor(my)
        
        love.graphics.setColor(Color.nbuildable)
        if Logic.placeable(mx, my) then
            love.graphics.setColor(Color.buildable)
        end
        buildmode:draw(convertToScreen(mx, my))
    end
    
    camera:detach()
    
    -- draw hud
    if not buildmode then Gui.core.draw() end
end


function state_ingame:mousepressed(x, y, button)
    if button == "l" then
        local mx, my = convertToMap(camera:worldCoords(x, y))
        mx = math.floor(mx)
        my = math.floor(my)
        if Logic.placeable(mx, my) then
            Logic.place(mx, my, buildmode)
            buildmode = nil
        end
    end
    if button == "r" then
        if buildmode then
            buildmode = nil
        else
            holdmouse = { x, y}
        end
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
