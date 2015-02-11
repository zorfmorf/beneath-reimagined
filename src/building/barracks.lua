
Barracks = Class{__includes = Building}

function Barracks:init()
    Building.init(self, x, y)
    self.name = "barracks"
    self.img = Image.t_barracks
end


function Barracks:update(dt)
    
end
