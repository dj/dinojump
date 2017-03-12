--[[
    Dinojump

    Based on Chrome's offline jumping dinosaur game.

    MIT License
    (c) DJ Hartman 2017
]]

local Game = require 'src/screens/game'
local Title = require 'src/screens/title'

local game, title, currentScreen, font
local started = false

local dimensions = {
    w = 320,
    h = 480,
}

local colors = {
    yellow = {255, 182, 25},
    violet = {184, 0, 255},
    purple = {86, 6, 114},
    lightGreen = {20, 204, 123},
    darkGreen = {9, 178, 104},
    black = {25, 25, 25},
    white = {255, 255, 255},
    lightBlue = {27, 174, 204},
}

function love.load()
    love.window.setMode(dimensions.w, dimensions.h)

    -- Seed rng
    math.randomseed(os.time())

    title = Title.create{
        dimensions = dimensions,
        colors = colors,
    }

    -- Load game
    game = Game.create{
        dimensions = dimensions,
        colors = colors,
    }

    -- Set the first screen
    currentScreen = title
    currentScreen:load()
end

function love.update(dt)
    currentScreen:update(dt)

    -- Start the game
    if not started and love.keyboard.isDown("space") then
        started = true
        currentScreen = nil
        currentScreen = game
        currentScreen:load()
    end

    if currentScreen == game and currentScreen:isOver() and love.keyboard.isDown("r") then
        currentScreen = nil
        game = nil
        game = Game.create{
            dimensions = dimensions,
            colors = colors,
        }
        currentScreen = game
        currentScreen:load()
     end
end

function love.draw()
    currentScreen:draw()
end
