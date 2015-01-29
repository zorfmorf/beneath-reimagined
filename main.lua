
Gamestate = require "lib.hump.gamestate"
Class = require "lib.hump.class"
Gui = require "lib.quickie"
Color = require "src.view.color"
require "src.view.coordinates"
require "src.misc.gradient"
require "src.misc.settings"
require "src.state.ingame"

-- Creates a proxy via rawset.
-- Credit goes to vrld: https://github.com/vrld/Princess/blob/master/main.lua
local function Proxy(f)
	return setmetatable({}, {__index = function(self, k)
		local v = f(k)
		rawset(self, k, v)
		return v
	end})
end

color = {
    white = {255, 255, 255, 255},
    black = {0, 0, 0, 255},
    transp = {0, 0, 0, 190}
}

-- load ressources
Image = Proxy(function(k) return love.graphics.newImage('img/' .. k .. '.png') end)
require "src.misc.tiles"

function updateScreen()
    screen = {
        w = love.graphics.getWidth(),
        h = love.graphics.getHeight()
    }
end

function love.load()
    math.randomseed(os.time())
    Gamestate.registerEvents()
    Gamestate.switch(state_ingame)
    Gui.core.style = require "src.view.style" --load unique style
end


function love.update(dt)
    
end


function love.draw()
    
end


function love.keypressed(key, isrepeat)
    if key == "escape" then love.event.push("quit") end
end
