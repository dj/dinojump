-- Title Screen
local Title = {}
Title.__index = Title

local font

function Title.create(args)
    local title = {}
    setmetatable(title, Title)
    title.dimensions = args.dimensions
    title.text = {
        x = title.dimensions.w / 2 - 120,
        y = title.dimensions.h / 2 - 30,
    }
    title.colors = args.colors
    return title
end

function Title:load()
    font = love.graphics.newFont('fonts/I-pixel-U.ttf', 40)
end

function Title:update(dt)
end

function Title:draw()
    love.graphics.setBackgroundColor(self.colors.yellow[1], self.colors.yellow[2], self.colors.yellow[3])
    love.graphics.setFont(font)
    love.graphics.print('DINOJUMP', self.text.x, self.text.y)
end

return Title
