local anim8 = require 'src/anim8'

-- Dinosaur
local Dinosaur = {}
Dinosaur.__index = Dinosaur

function Dinosaur.create(opts)
    local newDino = {}
    setmetatable(newDino, Dinosaur)
    newDino.screen = opts.screen
    newDino.x = opts.x
    newDino.y = opts.y
    newDino.states = {
        running = 1,
        jumping = 2,
        falling = 3,
    }
    newDino.state = newDino.states.running

    local frameSize = 64
    local sprite = love.graphics.newImage('img/dino.png')
    local g = anim8.newGrid(frameSize, frameSize, sprite:getWidth(), sprite:getHeight())
    newDino.run = anim8.newAnimation(g('1-2', 1), .15)
    newDino.sprite = sprite
    return newDino
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
    local jumpSpeed = 30
    local jumpMaxHeight = 250
    local gravity = -15

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
    if self.y < self.screen.h - 80 then
        self.y = self.y - gravity

        if not self:isJumping() then
            self.state = self.states.falling
        end
    else
        self.state = self.states.running
    end
end

function Dinosaur:draw()
    self.run:draw(self.sprite, self.x, self.y)
end

return Dinosaur
