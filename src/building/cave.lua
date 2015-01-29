
Cave = Class{__includes = Building}

function Cave:init()
    self.name = "cave"
end


function Cave:update(dt)
    
end


function Cave:draw(sx, sy)
    local img = Image.t_cave
    self:superdraw(sx, sy, img)
end
