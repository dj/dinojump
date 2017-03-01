-- Cactus
local Cactus = {}
Cactus.__index = Cactus

function Cactus.create(args)
    local cactus = {}
    setmetatable(cactus, Cactus)
    cactus.x = args.x
    cactus.y = args.y
    cactus.screen = args.screen
    cactus.speed = args.speed
    cactus.img = love.graphics.newImage('img/cactus.png')

    return cactus
end

function Cactus:update(dt)
    if (self.x < -100) then
        self.x = math.random(self.screen.w, self.screen.w * 2)
    else
        self.x = self.x - (self.speed * dt)
    end
end

function Cactus:draw(dt)
    love.graphics.draw(self.img, self.x, self.y)
end

function Cactus:isTouching(dino)
    return dino.y > 160 and dino.x + 30 > self.x and self.x > -30
end

return Cactus
