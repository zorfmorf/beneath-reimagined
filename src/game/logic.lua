-- Container for all game logic related code

local function tile(x, y)
    if tiles[x] and tiles[x][y] then return tiles[x][y] end
    return nil
end


-- if the given tile would work as a connecting tile
-- so a finished cave or a building (constructing or finished)
local function connectionExists(x, y)
    local t = tile(x, y)
    if t and t.build then
        local b = builds[tiles[x][y].build]
        return not b:instanceof(Cave()) or b.buildtime <= 0
    end
    return false
end

-- whether something can be build on the given tile
-- caves need an empty tile that connects to other tiles
-- buildings need to be placed on a finished cave
local function placeable(x, y, candidate)
    local t = tile(x, y)
    if candidate:instanceof(Cave()) then
        if not t or t.build then return false end
        if connectionExists(x-1,y) then return true end
        if connectionExists(x+1,y) then return true end
        if connectionExists(x,y-1) then return true end
        if connectionExists(x,y+1) then return true end
        return false
    end
    return t and t.build and builds[t.build]:instanceof(Cave()) and builds[t.build].buildtime <= 0
end


-- calculate build time for build
local function calculateBuildTime(build) 
    -- TODO: adjust buildtime depending on research and shit
end


-- places the building and handles all relevant effects
local function place(x, y, build)
    build.x = x
    build.y = y
    tiles[x][y].build = build.id
    builds[build.id] = build
    calculateBuildTime(build)
end


-- called when a building is finished
local function buildFinished(build)
    
end


local function endTurn()
    -- update buildtimers
    for i,build in pairs(builds) do
        if build.buildtime > 0 then 
            build.buildtime = build.buildtime - 1
            if build.buildtime <= 0 then buildFinished(build) end
        end
    end
    -- create placeholder end of turn message
    Message.dismiss_all()
    Message.new{title="Turn "..Game.getTurn().." has ended", mssg="Congratulations on this outstanding achievement commander."}
end


return {
    placeable = placeable,
    place = place,
    buildFinished = buildFinished,
    endTurn = endTurn
}