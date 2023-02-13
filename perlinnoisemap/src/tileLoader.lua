local tileLoader = Class:extend()

function tileLoader:new()
    self.water = "assets/water.png"
    self.sand = "assets/sand.png"
    self.field1 = "assets/field 1.png"
    self.field2 = "assets/field 2.png"
    self.meadow = "assets/meadow.png"
    self.rocky = "assets/rocky.png"
    self.lowMountains = "assets/low mountains.png"
    self.highMountains = "assets/high mountains.png"
    self.snow = "assets/snow.png"
    self.snowAndIce = "assets/snow and ice.png" 
    self.cellWidth, self.cellHeight = 32,32

    

end

function tileLoader:returnTile(e)
    if e < 0.1 then
        return self.water
    elseif e < 0.2 then
        return self.sand
    elseif e < 0.3 then
        return self.field1
    elseif e < 0.4 then
        return self.field2
    elseif e < 0.5 then
        return self.meadow
    elseif e < 0.6 then
        return self.rocky
    elseif e < 0.7 then
        return self.lowMountains
    elseif e < 0.8 then
        return self.highMountains
    elseif e < 0.9 then
        return self.snow
    else
        return self.snowAndIce
    end
end




function tileLoader:generateTileFromMap(map, entities)
    for riga, value in ipairs(map) do
        for colonna, t in ipairs(value) do
            local elevation, moisture  = unpack(t)
            
            local tex = love.graphics.newImage(self:returnTile(elevation))
            
            local e = {type = "tile", texture = tex , x = colonna * self.cellWidth, y = riga * self.cellHeight}
            Data:insert(e.x,e.y, e)
        
        end
    end
end

return tileLoader