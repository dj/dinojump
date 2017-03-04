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
    game.score = {
        font = love.graphics.newFont(24),
        value = 0,
        x = game.dimensions.w / 2,
        y = game.dimensions.h / 4,
    }
    game.colors = args.colors
    game.state = 1
    game.states = {
        started = 1,
        done = 2,
    }
    return game
end

function Game:load()
    love.graphics.setBackgroundColor(self.colors.yellow)

    -- Instantiate the the road and dinosaur
    ground = Ground.create{
        dimensions = self.dimensions,
        colors = self.colors,
        speed = 300,
        y = 250
    }

    dino = Dinosaur.create{
        dimensions = self.dimensions,
        colors = self.colors,
        x = 0,
        y = 200
    }

    sky = Sky.create{
        dimensions = self.dimensions,
        colors = self.colors,
    }

    for i = 1, 1 do
        cacti[i] = Cactus.create{
            dimensions = self.dimensions,
            colors = self.colors,
            speed = 300,
            x = math.random(self.dimensions.w, self.dimensions.w * 2),
            y = 200,
        }
    end

end

function Game:update(dt)
    if self.state == self.states.over then
        return
    end

    self.score.value = self.score.value + (dt * 10)

    sky:update(dt)

    for _, cactus in ipairs(cacti) do
        if cactus:isTouching(dino) then
            print("Touching!")
            self.state = self.states.over
            dino:die()
            return
        else
            cactus:update(dt)
        end
    end

    ground:update(dt)
    dino:update(dt)
end

function Game:draw()
    -- Offset the x position of the score so it looks centered
    local x = self.score.x - 5 - (self.score.font:getWidth(math.floor(self.score.value)) / 2)
    love.graphics.print(math.floor(self.score.value), x, self.score.y)
    ground:draw()
    for _, cactus in ipairs(cacti) do
        cactus:draw()
    end
    sky:draw()
    dino:draw()
end

return Game
