
function math.Clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end
function love.load()
    width = love.graphics.getDimensions()
    -- import module
    require "diamondsquare"
    love.math.setRandomSeed(love.timer.getTime())
    math.randomseed(os.time())
    for i = 1, math.random(10000) do
        math.random()
    end
    map = diamondsquare.create(width, width)
end

function love.draw()
-- examine each height value
for x = 0, map.w do
    for y = 0, map.h do
        local color = math.Clamp(map[x][y]/(width * 0.5),0,1)
        --color= map[x][y]/width
        love.graphics.setColor(color,color,color,1)
        love.graphics.points(x,y)
    end
end

end

function love.keyreleased(key)
    if key == "space" then
        map = nil

        map = diamondsquare.create(width, width)
    end
end

