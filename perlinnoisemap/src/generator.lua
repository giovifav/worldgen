

local generator = Class:extend()


function generator:new(conf)
  --map seed
  love.math.setRandomSeed(love.timer.getTime())
  local seed = love.math.random(300,1000) / 1000
  
  --moisture seed
  love.math.setRandomSeed(love.timer.getTime())
  local Mseed = love.math.random(300,1000) / 1000
  local cellSize = conf.cellSize or 32
  local height = conf.height or 640
  local width = conf.width or 640
  local frequency = conf.frequency or  2.3
  local redistribution = conf.redistribution or 2.1
  local fudgeFactor = conf.fudgeFactor or 1.2
  
  local function noise(a, b)
   return (love.math.noise(frequency * (a + seed) * seed, frequency * (b + seed) * seed)) / 2 +0.5
  end
  
  local function Mnoise(a, b)
   return (love.math.noise(frequency * (a + Mseed) * Mseed, frequency * (b + Mseed) * Mseed))/ 2 +0.5
  end

  local map = {}

  
  for y = 0, height, 1 do
    map[y] = {}
  
    
    for x = 0, width, 1 do
      
      local nx, ny = x/width , y/ height 
      local elevation =  (1.00 * noise( 1.00 * nx,  1.00 * ny)
           + 0.50 * noise( 2.00 * nx + 5.30 ,  2.00 * ny + 9.10)
           + 0.0 * noise( 4.00 * nx + 18.60,  4.00 * ny + 23.4)
           + 0.13 * noise( 8.00 * nx + 32.45,  8.00 * ny + 41.36)
           + 0.06 * noise(16.00 * nx + 64.30, 16.00 * ny + 71.64)
           + 0.03 * noise(32.00 * nx + 98.00, 32.00 * ny + 112.36))
      elevation = elevation / (1.00 + 0.50 + 0.0 + 0.13 + 0.06 + 0.03)
          
          
      local function distance( x1, y1, x2, y2 )
        local dx = x1 - x2
        local dy = y1 - y2
        return math.sqrt ( dx * dx + dy * dy )
      end    
      -- trasformiamo in un isola
      local distance = distance(x,y,width/2, height/2)/height *2
      
      elevation = (1 + elevation - distance) / 2
      
      elevation = math.pow(elevation * fudgeFactor, redistribution)
      
    
      
      --creaiamo mappa umidità
      local moisture =  (1.00 * Mnoise( 1.00 * nx,  1.00 * ny)
           + 0.50 * Mnoise( 2.00 * nx + 765.30 ,  2.00 * ny + 9423.10)
           + 0.75 * Mnoise( 4.00 * nx + 176.60,  4.00 * ny + 43223.4)
           + 0.33 * Mnoise( 8.00 * nx + 3762.45,  8.00 * ny + 44321.36)
           + 0.33 * Mnoise(16.00 * nx + 6674.30, 16.00 * ny + 714234.64)
           + 0.50 * Mnoise(32.00 * nx + 3762.00, 32.00 * ny + 1423412.36))
      moisture = moisture / (1.00 +0.5 + 0.75 + 0.33 + 0.33 + 0.33 + 0.50)
      
      map[y][x] = {elevation, moisture}
      
      
    end
  end
  self.map = map
  
end



return generator