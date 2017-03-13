-- Title Screen
local Title = {}
Title.__index = Title

local Ground = require 'src/ground'
local Sky = require 'src/sky'
local ground, sky

function Title.create(args)
    local title = {}
    setmetatable(title, Title)
    title.dimensions = args.dimensions
    title.text = {
        x = title.dimensions.w / 2,
        y = title.dimensions.h / 2 - 100,
        font = love.graphics.newFont('fonts/I-pixel-u.ttf', 40)
    }
    title.subtext = {
        x = title.dimensions.w / 2,
        y = title.dimensions.h / 2 - 50,
        font = love.graphics.newFont('fonts/I-pixel-u.ttf', 20)
    }
    title.colors = args.colors
    return title
end

function Title:load()
    ground = Ground.create{
        dimensions = self.dimensions,
        colors = self.colors,
        speed = 400,
        y = 250
    }

    sky = Sky.create{
        dimensions = self.dimensions,
        colors = self.colors,
    }
end

function Title:update(dt)
    ground:update(dt)
    sky:update(dt)
end

function Title:draw()
    -- Print the title
    ground:draw()
    sky:draw()

    local titleColor = self.colors.black
    local bgColor = self.colors.lightBlue
    love.graphics.setColor(titleColor)
    love.graphics.setBackgroundColor(bgColor)

    love.graphics.setFont(self.text.font)
    love.graphics.print('DINOJUMP', self.text.x - (self.text.font:getWidth('DINOJUMP') / 2), self.text.y)
    love.graphics.setFont(self.subtext.font)
    love.graphics.print('PRESS SPACE', self.subtext.x - (self.subtext.font:getWidth('PRESS SPACE') / 2), self.subtext.y)
end

return Title
