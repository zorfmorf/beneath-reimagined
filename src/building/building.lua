-- Parent class for all buildings

Building = Class{}

function Building:init(x, y)
    self.x = x
    self.y = y
    self.cost = {} -- list of key value pairs?
end

-- Some buildings may require updates for visual effects
function Building:update(dt)
    
end

-- drawing the actual building
function Building:superdraw(sx, sy, img)
    love.graphics.draw(img, sx - grid.w * 0.5, sy, 0, 1, 1, 0, img:getHeight() - grid.h)
end