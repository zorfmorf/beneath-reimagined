-- Parent class for all buildings

Building = Class{}

-- id handling
local ID_ITERATOR = 1
local buildfont = love.graphics.newFont(12)

function Building:init(x, y)
    self.x = x
    self.y = y
    self.id = ID_ITERATOR
    ID_ITERATOR = ID_ITERATOR + 1
    self.cost = {} -- list of key value pairs?
    self.name = "building"
    self.buildtime = 1
    self.img = nil
end


function Building:instanceof(candidate)
    return self.name == candidate.name
end


-- Some buildings may require updates for visual effects
function Building:update(dt)
    
end


-- drawing the actual building
function Building:draw(sx, sy)
    love.graphics.draw(self.img, sx - grid.w * 0.5, sy, 0, 1, 1, 0, self.img:getHeight() - grid.h)
end


-- draw buildtime. seperate function so that the preview placement drawing is simpler
function Building:drawBuildtime(sx, sy)
    love.graphics.setFont(buildfont)
    love.graphics.draw(Image.t_wip, sx - grid.w * 0.5, sy, 0, 1, 1, 0, self.img:getHeight() - grid.h)
    love.graphics.setColor(Color.buildtime_font)
    love.graphics.print(self.buildtime, sx - grid.w * 0.5 + self.img:getWidth() * 0.5, sy + self.img:getHeight() * 0.5, 0, 1, 1, buildfont:getWidth(tostring(self.buildtime)) * 0.5, buildfont:getHeight() * 0.2)
end
