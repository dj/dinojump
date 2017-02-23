--[[
    Dinojump

    Based on Chrome's offline jumping dinosaur game.

    MIT License
    (c) DJ Hartman 2017
]]

-- Colors
local BG_RGB = {255, 182, 25}

-- Game objects
local Dinosaur = require 'src/dinosaur'
local Ground = require 'src/ground'

local dino, ground

local screen = {
    w = 320,
    h = 480,
}

function love.load()
    love.window.setMode(screen.w, screen.h)
    love.graphics.setBackgroundColor(BG_RGB[1], BG_RGB[2], BG_RGB[3])

    -- Instantiate the the road and dinosaur
    ground = Ground.create{ screen = screen }
    dino = Dinosaur.create{
        screen = screen,
        x = 0,
        y = 250
    }
end

function love.update(dt)
    ground:update(dt)
    dino:update(dt)
end

function love.draw()
    ground:draw()
    dino:draw()
end
