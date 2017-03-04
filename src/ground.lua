-- Ground
local Ground = {}
Ground.__index = Ground

function Ground.create(opts)
    -- Class setup
    local newGround = {}
    setmetatable(newGround, Ground)

    -- Instance variables
    newGround.dimensions = opts.dimensions
    newGround.colors = opts.colors
    newGround.y = opts.y
    newGround.lines = {}
    newGround.speed = opts.speed

    for i = 1,30 do
        newGround.lines[i] = {
            x = math.random(0, newGround.dimensions.w * 2), 
            y = math.random(newGround.y + 5, newGround.y + 25),
            l = math.random(1,3)
        }
    end

    return newGround
end

function Ground:update(dt)
    for i, line in ipairs(self.lines) do
        if line.x < 0 then
            -- line has fallen off the left edge, remove it and generate a new line
            self.lines[i] = {
                x = math.random(self.dimensions.w, self.dimensions.w * 2),
                y = math.random(self.y + 5, self.y + 25),
                l = math.random(1,3)
            }
        else
            -- move the line
            local dx = self.speed * -dt
            self.lines[i] = {
                x = line.x + dx,
                y = line.y,
                l = line.l
            }
        end
    end
end

function Ground:draw(dt)
    local lineColor = self.colors.black
    love.graphics.setColor(lineColor)
    -- This is the ground
    love.graphics.setLineWidth(1)
    love.graphics.line(0,self.y,320,self.y)

    love.graphics.setLineWidth(2)
    for _, line in ipairs(self.lines) do
        love.graphics.line(line.x, line.y, line.x + line.l, line.y)
    end
end

return Ground
