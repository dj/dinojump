-- Title Screen
local Title = {}
Title.__index = Title

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
end

function Title:update(dt)
end

function Title:draw()
    local titleColor = self.colors.yellow
    local bgColor = self.colors.purple
    love.graphics.setColor(titleColor)
    love.graphics.setBackgroundColor(bgColor)

    -- Print the title
    love.graphics.print('DINOJUMP', self.text.x, self.text.y)
end

return Title
