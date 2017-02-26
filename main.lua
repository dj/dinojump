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
local Sky = require 'src/sky'

local dino, ground, sky

local screen = {
    w = 320,
    h = 480,
}

function love.load()
    love.window.setMode(screen.w, screen.h)
    love.graphics.setBackgroundColor(BG_RGB[1], BG_RGB[2], BG_RGB[3])

    -- Seed rng
    math.randomseed(os.time())

    -- Instantiate the the road and dinosaur
    ground = Ground.create{ 
        screen = screen,
        y = 250
    }
    dino = Dinosaur.create{
        screen = screen,
        x = 0,
        y = 200
    }
    sky = Sky.create{
        screen = screen,
    }
end

function love.update(dt)
    sky:update(dt)
    ground:update(dt)
    dino:update(dt)
end

function love.draw()
    ground:draw()
    sky:draw()
    dino:draw()
end
