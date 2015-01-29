
state_ingame = Gamestate.new()

tiles = nil -- contains map

Hud = require "src.view.hud"
Game = require "src.game.gamestate"
Camera = require "src.view.camwrapper"
Logic = require "src.game.logic"

require "src.building.building"
require "src.building.corridor"
require "src.building.housing"
require "src.building.barracks"
require "src.building.lab"
require "src.building.cave"


-- if not nil, it contains the building the player wants to build
local buildmode = nil


-- Called once whenever entering state
function state_ingame:enter()
    
    -- update screen and camera coordinates
    updateScreen()
    Camera.init()
    Camera.focusMapPos(5, 5)
    Game.init()
    Hud.init(Game)
    
    -- generate/load tile grid
    -- TODO: remove placeholder grid and load from map file/generator
    tiles = {}
    for x = 1,grid.xs do
        tiles[x] = {}
        for y = 1,grid.ys do
            tiles[x][y] = { z = 0, tile = 4, build = nil}
        end
    end
    tiles[5][5].build = Cave()
end


-- Everything is updated here
function state_ingame:update(dt)
    
    Camera.update(dt)
    buildmode = Hud.update(dt, buildmode)
    
end


-- All draw calls go in here
function state_ingame:draw()
    
    -- draw game world
    Camera.attach()
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
        local mx, my = convertToMap(Camera.worldCoords(love.mouse.getPosition()))
        mx = math.floor(mx)
        my = math.floor(my)
        
        love.graphics.setColor(Color.nbuildable)
        if Logic.placeable(mx, my, buildmode) then
            love.graphics.setColor(Color.buildable)
        end
        buildmode:draw(convertToScreen(mx, my))
    end
    
    Camera.detach()
    Hud.draw()
end


function state_ingame:mousepressed(x, y, button)
    if button == "l" then
        if buildmode then
            local mx, my = convertToMap(Camera.worldCoords(x, y))
            mx = math.floor(mx)
            my = math.floor(my)
            if Logic.placeable(mx, my, buildmode) then
                Logic.place(mx, my, buildmode)
                buildmode = nil
            end
        end
    end
    if button == "r" then
        if buildmode then
            buildmode = nil
        else
            Camera.startDrag(x, y)
        end
    end
    if button == "wu" then
        --Camera.zoom(2)
    end
    if button == "wd" then
        --Camera.zoom(0.5)
    end
end


function state_ingame:mousereleased(x, y, button)
    if button == "r" then
        Camera.endDrag()
    end
end
