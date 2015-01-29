
Laboratory = Class{__includes = Building}

function Laboratory:init()
    self.name = "lab"
end


function Laboratory:update(dt)
    
end


function Laboratory:draw(sx, sy)
    local img = Image.t_lab
    self:superdraw(sx, sy, img)
end
