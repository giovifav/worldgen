

function love.load(args)
  Class = require("libs.classic")
  local CONF = {
    width = 64  ,
    height = 64,
    frequency = 2.4,
    redistribution = 1.3,
    fudgeFactor = 1.19,


  }
  local map = require("src.generator")(CONF)
  local tileLoader = require("src.tileloader")(32)
  Data = require("libs.spatial").new(32)
  camera = require("libs.camera")
  tileLoader:generateTileFromMap(map.map, Data)


  love.math.setRandomSeed(love.timer.getTime())

end



function love.update(dt)
  local left, right, up, down = love.keyboard.isDown("left"), love.keyboard.isDown("right"), love.keyboard.isDown("up"), love.keyboard.isDown("down")
  local camera_speed = 1000
  if left then
      camera:move(-camera_speed, 0)
  elseif right then
      camera:move(camera_speed)
  end 

  if up then
      camera:move(0, -camera_speed)
  elseif down then
      camera:move(0, camera_speed)
  end 
end

function love.draw()
  -- Querying the database for ojecects currently visible on the screen.
  local list, len = Data:queryRect(camera.x, camera.y, love.graphics.getWidth(), love.graphics.getHeight())

  -- Drawing objects
  camera:push()
  for i,v in ipairs(list) do
      love.graphics.draw(v.texture, v.x,v.y)
  end
  camera:pop()


end

function love.keypressed(key)
  if key == "escape" then love.event.push("quit") end
 
end