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
local Cactus = require 'src/cactus'

local dino, ground, sky
local cacti = {}
local score = 0;
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
        speed = 300,
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

    for i = 1, 1 do
        cacti[i] = Cactus.create{
            screen = screen,
            speed = 300,
            x = math.random(screen.w, screen.w * 2),
            y = 200,
        }
    end

end

function love.update(dt)
    score = score + (dt * 10)

    sky:update(dt)

    for _, cactus in ipairs(cacti) do
        cactus:update(dt)
        if cactus:isTouching(dino) then
            print("Touching!")
        else
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
