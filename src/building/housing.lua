
Housing = Class{__includes = Building}

function Housing:init()
    Building.init(self, x, y)
    self.name = "housing"
    self.img = Image.t_housing
end


function Housing:update(dt)
    
end
