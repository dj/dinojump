-- Cacti Generator
local CactiGenerator = {}
CactiGenerator.__index = CactiGenerator

local Cactus = require 'src/cactus'

function CactiGenerator.create(args)
    local cg = {}
    setmetatable(cg, CactiGenerator)
    cg.dimensions = args.dimensions
    cg.colors = args.colors
    cg.speed = args.speed
    cg.cacti = {}
    cg.count = args.count
    cg.hit = false
    cg.lastX = 0
    cg.padding = 250

    -- Generate the initial cacti
    for i = 1, cg.count do
        cg.cacti[i] = Cactus.create{
            dimensions = cg.dimensions,
            colors = cg.colors,
            speed = cg.speed,
            x = math.random(cg.lastX + cg.padding, cg.lastX + cg.padding * 3),
            y = 200,
        }
        cg.lastX = cg.cacti[i].x
    end

    return cg
end

function CactiGenerator:update(dt, dino)
    for _, cactus in ipairs(self.cacti) do
        if cactus:isTouching(dino) then
            self.hit = true
        else
            cactus:update(dt, self.lastX, self.padding)
        end
    end
end

function CactiGenerator:draw()
    for _, cactus in ipairs(self.cacti) do
        cactus:draw()
    end
end

return CactiGenerator
