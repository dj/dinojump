-- Game Screen
local Game = {}
Game.__index = Game

local Dinosaur = require 'src/dinosaur'
local Ground = require 'src/ground'
local Sky = require 'src/sky'
local CactiGenerator = require 'src/cacti-generator'

local dino, ground, sky, cacti
local SPEED = 400

function Game.create(args)
    local game = {}
    setmetatable(game, Game)
    game.dimensions = args.dimensions
    game.score = {
        font = love.graphics.newFont('fonts/I-pixel-u.ttf', 21),
        value = 0,
        x = game.dimensions.w,
        y = 0,
    }
    game.highScore = {
        font = game.score.font,
        value = args.highScore,
        x = 5,
        y = 0,
    }
    game.gameOver = {
        font = love.graphics.newFont('fonts/I-pixel-u.ttf', 30),
        x = game.dimensions.w / 2,
        y = game.dimensions.h / 4,
    }
    game.colors = args.colors
    game.state = 1
    game.states = {
        started = 1,
        gameOver = 2,
        done = 3,
    }
    return game
end

function Game:isOver()
    return self.state == self.states.gameOver
end

function Game:load()
    love.graphics.setBackgroundColor(self.colors.lightBlue)

    -- Instantiate the the road and dinosaur
    ground = Ground.create{
        dimensions = self.dimensions,
        colors = self.colors,
        speed = SPEED,
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

    cacti = CactiGenerator.create{
        dimensions = self.dimensions,
        colors = self.colors,
        count = 5,
        speed = SPEED,
    }

end

function Game:update(dt)
    if self.state == self.states.gameOver then
        return
    end

    self.score.value = self.score.value + (dt * 10)

    cacti:update(dt, dino)
    sky:update(dt)
    ground:update(dt)
    dino:update(dt)

    if cacti.hit then
        self.state = self.states.gameOver
        dino:die()
    end

end

function Game:draw()
    ground:draw()
    sky:draw()
    cacti:draw()
    dino:draw()

    -- Print text overlay
    love.graphics.setFont(self.score.font)
    love.graphics.setColor(self.colors.black)

    -- Print score
    local currentScore = "SCORE: " .. math.floor(self.score.value)
    local x = self.score.x - self.score.font:getWidth(currentScore) - 5
    love.graphics.print(currentScore, x, self.score.y)

    -- Print high score
    love.graphics.print("HIGH: " .. self.highScore.value, self.highScore.x, self.highScore.y)

    -- Print game over
    if self.state == self.states.gameOver then
        local x = self.gameOver.x - (self.gameOver.font:getWidth("GAME OVER") / 2)
        love.graphics.setFont(self.gameOver.font)
        love.graphics.print("GAME OVER", x, self.gameOver.y)
        love.graphics.setFont(self.score.font)
        x = self.gameOver.x - (self.score.font:getWidth("[press r]") / 2)
        love.graphics.print("[press r]", x, self.gameOver.y + 50)
    end

end

return Game
