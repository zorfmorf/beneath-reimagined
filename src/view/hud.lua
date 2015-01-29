-- Capsulates all hud related code.

local menu_open = {
    build = false
}

local Game = nil

local function init(game)
    Game = game
end


local function update(dt, buildmode)
    
    if not buildmode then
        
        Gui.group.push{grow = "down", pos = {screen.w - 100, 0}}
        if Gui.Button{id = "btn_dig", text = "Dig"} then
            buildmode = Cave()
        end
        if Gui.Button{id = "btn_build", text = "Build"} then
            menu_open.build = not menu_open.build
        end
        Gui.group.pop{}
        
        -- build menu if opened
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
            
            if Gui.Button{id = "btn_build_barracks", text = "Barracks"} then
                buildmode = Barracks()
                menu_open.build = false
            end
            
            if Gui.Button{id = "btn_build_labs", text = "Labs"} then
                buildmode = Laboratory()
                menu_open.build = false
            end
            
            Gui.group.pop{}
        end
        
        -- Turn counter and other stuff
        Gui.group.push{grow = "right", pos = {screen.w - 100, screen.h - 30}}
        if Gui.Button{id = "btn_turn", text = "End Turn"} then
            Game.endTurn()
        end
        Gui.group.pop{}
        
        -- Debug information
        Gui.group.push{grow = "down", pos = {0, 0}}
        Gui.Label{text = "FPS: " .. love.timer.getFPS()}
        Gui.Label{text = "Turn: " .. Game.getTurn()}
        Gui.Label{text = "Energy: " .. Game.getEnergy()}
        Gui.group.pop{}
        
    end
    
    return buildmode
end


local function draw()
    Gui.core.draw()
end


return {
    init = init,
    update = update,
    draw = draw
}