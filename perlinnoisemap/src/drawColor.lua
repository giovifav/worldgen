
local function biome(e, m)
    local c = require("libs.colors")
    
    local ocean = c.cadetblue
    local beach = c.khaki1
    local scorched = c.ivory3
    local bare = c.ivory2
    local tundra = c.tan3 
    local temperate_desert = c.sandybrown
    local grassland = c.palegreen4
    local temperate_deciduous_forest = c.olivedrab
    local temperate_rain_forest = c.springgreen4
    local subtropical_desert = c.orange3
    local tropical_seasonal_forest = c.olivedrab1
    local tropical_rain_forest = c.olivedrab4
    local snow = c.mintcream
    local taiga = c.mediumseagreen
    local shrubland = c.palegreen3
  
    if e < 0.12 then
      return ocean
    elseif e < 0.15 then
      return beach
    elseif e > 0.8 then
      if m < 0.1 then return scorched -- tipo pietre grigie
      elseif m < 0.2 then return bare
      elseif m < 0.5 then return tundra
      else return snow
      end
    elseif e > 0.6 then
      if m < 0.33 then return temperate_desert
      elseif m < 0.66 then return shrubland
      else return taiga
      end
    elseif e > 0.3 then
      if m < 0.16 then return temperate_desert
      elseif m < 0.50 then return grassland
      elseif m < 0.83 then return temperate_deciduous_forest
      else return temperate_rain_forest
      end
    elseif e < 0.3 then
      if m < 0.16 then return subtropical_desert
      elseif m < 0.33 then return grassland
      elseif m < 0.66 then return tropical_seasonal_forest
      else return tropical_rain_forest
      end
    end
  end
  
  function generator:drawPoints()
    for riga, value in ipairs(self.map) do
      for colonna, c in ipairs(value) do
        
          love.graphics.setColor(c[3][1],c[3][2],c[3][3], 1)
          
          love.graphics.points(colonna, riga)
     
      
      end
      
    end
    
  end