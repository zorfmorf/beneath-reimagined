-- Container for all game logic related code

-- whether something can be build on the given tile
local function placeable(x, y)
    return tiles[x] and tiles[x][y] and not tiles[x][y].build
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