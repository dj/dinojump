-- Game Screen
local Game = {}
Game.__index = Game

local Dinosaur = require 'src/dinosaur'
local Ground = require 'src/ground'
local Sky = require 'src/sky'
local Cactus = require 'src/cactus'

local dino, ground, sky
local cacti = {}

function Game.create(args)
    local game = {}
    setmetatable(game, Game)
    game.dimensions = args.dimensions
    game.score = 0
    game.colors = args.colors
    return game
end

function Game:load()
    -- BG Color
    love.graphics.setBackgroundColor(self.colors.yellow[1], self.colors.yellow[2], self.colors.yellow[3])

    -- Instantiate the the road and dinosaur
    ground = Ground.create{
        dimensions = self.dimensions,
        speed = 300,
        y = 250
    }

    dino = Dinosaur.create{
        dimensions = self.dimensions,
        x = 0,
        y = 200
    }

    sky = Sky.create{
        dimensions = self.dimensions,
    }

    for i = 1, 1 do
        cacti[i] = Cactus.create{
            dimensions = self.dimensions,
            speed = 300,
            x = math.random(self.dimensions.w, self.dimensions.w * 2),
            y = 200,
        }
    end

end

function Game:update(dt)
    self.score = self.score + (dt * 10)

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

function Game:draw()
    love.graphics.print(math.floor(self.score))
    ground:draw()
    for _, cactus in ipairs(cacti) do
        cactus:draw()
    end
    sky:draw()
    dino:draw()
end

return Game
