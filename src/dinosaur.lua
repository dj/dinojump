local anim8 = require 'src/anim8'

-- Dinosaur
local Dinosaur = {}
Dinosaur.__index = Dinosaur

function Dinosaur.create(opts)
    local newDino = {}
    setmetatable(newDino, Dinosaur)
    newDino.dimensions = opts.dimensions
    newDino.x = opts.x
    newDino.y = opts.y
    newDino.width = 64
    newDino.height = 64
    newDino.colors = opts.colors
    newDino.ground = opts.y
    newDino.states = {
        running = 1,
        jumping = 2,
        falling = 3,
        dead = 4,
    }
    newDino.state = newDino.states.running

    local img = love.graphics.newImage('img/dino.png')
    local g = anim8.newGrid(newDino.width, newDino.height, img:getWidth(), img:getHeight())
    newDino.run = anim8.newAnimation(g('1-2', 1), .15)
    newDino.dead = anim8.newAnimation(g(5, 1), 1)
    newDino.img = img
    return newDino
end

function Dinosaur:die()
    self.state = self.states.dead
end

function Dinosaur:hitbox()
    return {
        x = self.x + 10,
        y = self.y + 15,
        width = 30,
        height = self.height - 35,
    }
end

function Dinosaur:isJumping()
    return self.state == self.states.jumping
end

function Dinosaur:isFalling()
    return self.state == self.states.falling
end

function Dinosaur:isRunning()
    return self.state == self.states.running
end

function Dinosaur:update(dt)
    local jumpSpeed = 21
    local gravity = -9
    local ground = self.dimensions.h - 275
    local jumpMaxHeight = ground - jumpSpeed * 12.5

    self.run:update(dt)

    -- TODO: make it so you can't jump before you hit the ground again
    if love.keyboard.isDown("space") then
        if not self:isFalling() then
            self.state = self.states.jumping
            self.y = self.y - jumpSpeed
        end
    end

    -- Jump apex
    if self:isJumping() then
        if self.y < jumpMaxHeight then
            self.state = self.states.falling
        end
    end

    -- Fall if we're not on the ground
    if self.y < self.ground then
        self.y = self.y - gravity

        if not self:isJumping() then
            self.state = self.states.falling
        end
    else
        self.state = self.states.running
    end
end

function Dinosaur:draw()
    -- Draw the image in it's original color by setting color to white
    love.graphics.setColor(self.colors.white)

    if self.state == self.states.dead then
        self.dead:draw(self.img, self.x, self.y)
    else
        self.run:draw(self.img, self.x, self.y)
    end

    -- debug hitbox
    local box = self:hitbox()
    love.graphics.rectangle('line', box.x, box.y, box.width, box.height)

end

return Dinosaur
