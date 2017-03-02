--[[
    Dinojump

    Based on Chrome's offline jumping dinosaur game.

    MIT License
    (c) DJ Hartman 2017
]]

local Game = require 'src/screens/game'
local game

local dimensions = {
    w = 320,
    h = 480,
}

function love.load()
    love.window.setMode(dimensions.w, dimensions.h)

    -- Seed rng
    math.randomseed(os.time())

    -- Load game
    game = Game.create{
        dimensions = dimensions
    }
    game:load()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end
