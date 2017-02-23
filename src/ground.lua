-- Ground
local Ground = {}
Ground.__index = Ground

function Ground.create(opts)
    local newGround = {}
    setmetatable(newGround, Ground)
    newGround.screen = opts.screen
    return newGround
end

function Ground:update(dt)
end

function Ground:draw(dt)
    local y = self.screen.h - 60
    love.graphics.line(0,y,320,y)
end

return Ground
