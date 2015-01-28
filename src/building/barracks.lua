
Barracks = Class{__includes = Building}

function Barracks:init()
    
end


function Barracks:update(dt)
    
end


function Barracks:draw(sx, sy)
    local img = Image.t_barracks
    self:superdraw(sx, sy, img)
end
