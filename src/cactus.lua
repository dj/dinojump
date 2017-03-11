-- Cactus
local Cactus = {}
Cactus.__index = Cactus

function Cactus.create(args)
    local cactus = {}
    setmetatable(cactus, Cactus)
    cactus.x = args.x
    cactus.y = args.y
    cactus.dimensions = args.dimensions
    cactus.colors = args.colors
    cactus.speed = args.speed
    cactus.img = love.graphics.newImage('img/cactus.png')

    return cactus
end

function Cactus:hitbox()
    return {
        x = self.x + (self.img:getWidth() / 3),
        y = self.y + 20,
        width = (self.img:getWidth() / 3),
        height = self.img:getWidth() - 20,
    }
end

function Cactus:update(dt, lastX, padding)
    if (self.x < -100) then
        self.x = math.random(lastX + padding, lastX + padding * 3)
    else
        self.x = self.x - (self.speed * dt)
    end
end

function Cactus:draw(dt)
    love.graphics.setColor(self.colors.lightGreen)
    love.graphics.draw(self.img, self.x, self.y)

    -- debug hitbox
    -- local box = self:hitbox()
    -- love.graphics.rectangle('line', box.x, box.y, box.width, box.height)
end

function Cactus:isTouching(dino)
    local box = self:hitbox()
    return box.x < dino:hitbox().x + dino:hitbox().width and box.y <= dino:hitbox().y + dino:hitbox().height and box.x + box.width > dino:hitbox().x
end

return Cactus
