
Cave = Class{__includes = Building}

function Cave:init(x, y)
    Building.init(self, x, y)
    self.name = "cave"
    self.buildtime = 10
    self.img = Image.t_cave
end


function Cave:update(dt)
    
end
