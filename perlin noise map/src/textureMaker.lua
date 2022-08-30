local textureMaker = Class:extend()

function textureMaker:new(img)

    local iteration = 200
    local iga = require("libs.iga")
    local imgdata = love.image.newImageData(img)
    local ow, oh = imgdata:getWidth(), imgdata:getHeight()
    iga:geninit(imgdata, ow,oh,ow, oh, 3)
    
	for i=1, iteration do
		iga:genstep()
	end
    self.imagedata = love.image.newImageData(ow,oh)
	for x=0, ow-1 do
		for y=0,ow-1 do
			local k = iga:getColours()[x+y*ow]
			if k and k > 0 then
				local c = string.format("%09d",tostring(k))
				local r,g,b = string.sub(c,1, 3), string.sub(c,4, 6), string.sub(c,7, 9)
                self.imagedata:setPixel(x,y,tonumber(r)/255,tonumber(g)/255,tonumber(b)/255)
			end
		end
	end
end




return textureMaker