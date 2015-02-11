
Laboratory = Class{__includes = Building}

function Laboratory:init()
    Building.init(self, x, y)
    self.name = "lab"
    self.img = Image.t_lab
end


function Laboratory:update(dt)
    
end
