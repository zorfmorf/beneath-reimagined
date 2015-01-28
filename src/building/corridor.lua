
Corridor = Class{__includes = Building}

function Corridor:init()
    
end


function Corridor:update(dt)
    
end


function Corridor:draw(sx, sy)
    local img = Image.t_corridor
    self:superdraw(sx, sy, img)
end
