
local turn = nil
local energy = nil

local function init()
    turn = 1
    energy = 0
end





local function endTurn()
    turn = turn + 1
end


-- getter functions ( yes we sadly need them if we encapsulate like this)
local function getTurn()
    return turn
end


local function getEnergy()
    return energy
end


return {
    init = init,
    endTurn = endTurn,
    getTurn = getTurn,
    getEnergy = getEnergy
}