
Gate = Class{__includes = Building}


function Gate:init()
    Building.init(self, x, y)
    self.name = "gate"
    self.img = Image.t_gate
end


function Gate:update(dt)
    
end
