--[[
    Dinojump

    Based on Chrome's offline jumping dinosaur game.

    MIT License
    (c) DJ Hartman 2017
]]

-- Game objects
local Dinosaur = require 'src/dinosaur'
local Ground = require 'src/ground'
local Sky = require 'src/sky'
local Cactus = require 'src/cactus'

local dino, ground, sky
local cacti = {}

local score = 0
local dimensions = {
    w = 320,
    h = 480,
}

-- Colors
local BG_RGB = {255, 182, 25}

function love.load()
    love.window.setMode(dimensions.w, dimensions.h)
    love.graphics.setBackgroundColor(BG_RGB[1], BG_RGB[2], BG_RGB[3])

    -- Seed rng
    math.randomseed(os.time())

    -- Instantiate the the road and dinosaur
    ground = Ground.create{
        dimensions = dimensions,
        speed = 300,
        y = 250
    }

    dino = Dinosaur.create{
        dimensions = dimensions,
        x = 0,
        y = 200
    }

    sky = Sky.create{
        dimensions = dimensions,
    }

    for i = 1, 1 do
        cacti[i] = Cactus.create{
            dimensions = dimensions,
            speed = 300,
            x = math.random(dimensions.w, dimensions.w * 2),
            y = 200,
        }
    end

end

function love.update(dt)
    score = score + (dt * 10)

    sky:update(dt)

    for _, cactus in ipairs(cacti) do
        if cactus:isTouching(dino) then
            print("Touching!")
        else
            cactus:update(dt)
            print("Miss")
        end
    end

    ground:update(dt)
    dino:update(dt)
end

function love.draw()
    love.graphics.print(math.floor(score))
    ground:draw()
    for _, cactus in ipairs(cacti) do
        cactus:draw()
    end
    sky:draw()
    dino:draw()
end
