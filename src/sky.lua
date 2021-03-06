-- Sky
local Sky = {}
Sky.__index = Sky
local cloudImg = love.graphics.newImage('img/cloud.png')

function Sky.create(opts)
    -- Class setup
    local newSky = {}
    setmetatable(newSky, Sky)

    -- Instance variables
    newSky.dimensions = opts.dimensions
    newSky.clouds = {}
    newSky.colors = opts.colors

    for i = 1,5 do
        newSky.clouds[i] = {
            x = math.random(0, newSky.dimensions.w * 2),
            y = math.random(-20, 60),
        }
    end

    return newSky
end

function Sky:update(dt)
    for i, cloud in ipairs(self.clouds) do
        if cloud.x < -64 then
            -- cloud has fallen off the left edge, remove it and generate a new cloud
            self.clouds[i] = {
                x = math.random(self.dimensions.w, self.dimensions.w * 2),
                y = math.random(-20, 60),
            }
        else
            -- move the cloud
            local dx = 20 * -dt
            self.clouds[i] = {
                x = cloud.x + dx,
                y = cloud.y
            }
        end
    end
end

function Sky:draw()
    love.graphics.setColor(self.colors.white)
    for _, cloud in ipairs(self.clouds) do
        love.graphics.draw(cloudImg, cloud.x, cloud.y)
    end
end

return Sky
