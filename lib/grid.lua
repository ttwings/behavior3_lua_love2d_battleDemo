local grid = {}

local gridSize=64
local screenQuad
local gridCanvas


local code=[[
	extern number offx;
	extern number offy;
	extern number gridSize;
	extern number screenW;
	extern number screenH;
	vec4 effect( vec4 color, Image texture, vec2 tc, vec2 sc ){
		if (abs(mod(floor(sc.x-screenW/2)+offx,gridSize))<=1 || 
			abs(mod(floor(sc.y-screenH/2)+offy,gridSize))<=1 ){
			return vec4(0,1,0,0.1);
			
		}
		else {
			return color*Texel(texture,tc);
		}
	}

]]


local shader = love.graphics.newShader(code)

function grid.new(cam)
	grid.cam = cam
	grid.canvas = love.graphics.newCanvas()
	shader:send("screenW",w())
	shader:send("screenH",h())
	shader:send("gridSize",gridSize*grid.cam.scale)
	return grid
end


function grid.draw()
	shader:send("offx",grid.cam.x*grid.cam.scale)
	shader:send("offy",grid.cam.y*grid.cam.scale)
	
	love.graphics.setShader(shader)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("fill", 0, 0, w(), h())
	love.graphics.setShader()
end

return grid