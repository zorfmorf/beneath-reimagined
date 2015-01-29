-- Container for all game logic related code

local function tile(x, y)
    if tiles[x] and tiles[x][y] then return tiles[x][y] end
    return nil
end


-- whether something can be build on the given tile
local function placeable(x, y, candidate)
    if candidate:instanceof(Cave()) then
        if not tile(x,y) or tile(x,y).build then return false end
        if tile(x-1,y) and tile(x-1,y).build and tile(x-1,y).build:instanceof(Cave()) then return true end
        if tile(x+1,y) and tile(x+1,y).build and tile(x+1,y).build:instanceof(Cave()) then return true end
        if tile(x,y-1) and tile(x,y-1).build and tile(x,y-1).build:instanceof(Cave()) then return true end
        if tile(x,y+1) and tile(x,y+1).build and tile(x,y+1).build:instanceof(Cave()) then return true end
        return false
    end
    return tiles[x] and tiles[x][y] and tiles[x][y].build and tiles[x][y].build:instanceof(Cave())
end


-- places the building and handles all relevant effects
local function place(x, y, build)
    build.x = x
    build.y = y
    tiles[x][y].build = build
end


return {
    placeable = placeable,
    place = place
}