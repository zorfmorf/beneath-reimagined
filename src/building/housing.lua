
Housing = Class{__includes = Building}

function Housing:init()
    self.name = "housing"
end


function Housing:update(dt)
    
end


function Housing:draw(sx, sy)
    local img = Image.t_housing
    self:superdraw(sx, sy, img)
end
