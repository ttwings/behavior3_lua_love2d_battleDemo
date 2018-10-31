drawObjs = {}
function drawObjs.actor(player)
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill",player.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY,5,5)
    love.graphics.print(player.name,player.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY + 10)
    love.graphics.print(player.turn,player.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY + 20)
    love.graphics.rectangle("fill",player.x*32,player.y*32,32,32)
end
function drawObjs.message(message)
    love.graphics.setColor(1,1,1)
    for i=#message,1,-1 do
        love.graphics.print(i..":"..message[i],10,400+18*(#message-i))
    end
end
function drawObjs.timerLine(timer)
	    -- turn line
    love.graphics.setLineWidth(timer.timeLineW)
    love.graphics.setColor(255,255,255)
    love.graphics.line(timer.timeLineX,timer.timeLineY,timer.timeLineLong + timer.timeLineX,timer.timeLineY)
    love.graphics.print(timer.timeLineName,timer.timeLineX - #timer.timeLineName*8,timer.timeLineY - 10)
    -- timer turn
    love.graphics.setColor(1,1,0)
    love.graphics.rectangle("fill",timer.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY - 5,5,5)
    love.graphics.print(timer.name,timer.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY - 20)
    love.graphics.print(timer.turn,timer.turn%timer.timeLineLong + timer.timeLineX,timer.timeLineY - 30)

end
function drawObjs.actorState(actor,x,y,h)
    local i = 0
    local h = h or 20
    for k,v in pairs(actor) do
        if type(v) ~= "table" then
            love.graphics.print(k..":"..v,x,y+i*h)
            i = i + 1
        end
    end
end

function drawObjs.grid(grid,offx,offy)
	local offx = offx or 0
	local offy = offy or 0
	love.graphics.setLineWidth(0.5)
	love.graphics.setColor(32/255, 56/255, 125/255)
	for x=1,#grid[1] do
		for y=1,#grid do
			if grid[y][x] == 'x' then
				love.graphics.setColor(32/255, 56/255, 125/255)
			end
			if grid[y][x] == 'y' then
				love.graphics.setColor(125/255, 56/255, 125/255)
			end
			love.graphics.rectangle('fill', (x+offx)*32, (y+offy)*32, 30, 30)
			-- love.graphics.print(grid[y][x], (x+offx)*32, (y+offy)*32)
		end
	end
end


function drawObjs.temperature(t,x,y)
	-- local t0= math.random(-30,30)
	-- local tMax = 50
	-- local tMin = -50
	local tLenght = t.tMax - t.tMin
	-- local actorTmax = 25
	-- local actorTmin = 19
	-- local state = 'good'
	local w = 8
	local h = t.tMax - t.tMin
	local y1 = y
	local h1 = t.tMax-t.actorTmax
	local y2 = y + h1
	local h2 = t.actorTmax - t.actorTmin
	local y3 = y2 + h2
	local h3 = t.actorTmin - t.tMin
	-- out side temperature
	local y0 = y + t.tMax - t.t0
	love.graphics.setLineWidth(1)
	love.graphics.rectangle("line",x,y,w,h)
	-- part1
	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle('fill',x+1,y1,w-1,h1)
	-- part2
	love.graphics.setColor(0.5,0.5,0.5)
	love.graphics.rectangle('fill',x+1,y2,w-1,h2)
	-- part3
	love.graphics.setColor(0,0,1)
	love.graphics.rectangle('fill',x+1,y3,w-1,h3)
	-- part 0  outside temperature
	love.graphics.setColor(1,1,1)
	love.graphics.rectangle('fill',x,y0,w-1,1)
	-- state
	local state = ''
	if t.t0 < t.actorTmin then
	    state = t.state[3]
	end
	if t.t0 > t.actorTmax then
		state = t.state[1]
	end
	if t.t0 >= t.actorTmin and t.t0 <= t.actorTmax then
		state = t.state[2]
	end
	love.graphics.print(state,x,y-20)
end

return drawObjs