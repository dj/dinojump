-- Cacti Generator
local CactiGenerator = {}
CactiGenerator.__index = CactiGenerator

local Cactus = require 'src/cactus'

function CactiGenerator.create(args)
    local cg = {}
    setmetatable(cg, CactiGenerator)
    cg.dimensions = args.dimensions
    cg.colors = args.colors
    cg.cacti = {}
    cg.count = args.count
    cg.hit = false

    for i = 1, cg.count do
        cg.cacti[i] = Cactus.create{
            dimensions = cg.dimensions,
            colors = cg.colors,
            speed = 300,
            x = math.random(cg.dimensions.w, cg.dimensions.w * 2),
            y = 200,
        }
    end

    return cg
end

function CactiGenerator:update(dt, dino)
    for _, cactus in ipairs(self.cacti) do
        if cactus:isTouching(dino) then
            self.hit = true
        else
            cactus:update(dt)
        end
    end
end

function CactiGenerator:draw()
    for _, cactus in ipairs(self.cacti) do
        cactus:draw()
    end
end

return CactiGenerator
