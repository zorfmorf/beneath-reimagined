
Corridor = Class{__includes = Building}


function Corridor:init()
    Building.init(self, x, y)
    self.name = "corridor"
    self.img = Image.t_corridor
end


function Corridor:update(dt)
    
end
