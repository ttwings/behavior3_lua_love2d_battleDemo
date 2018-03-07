local moveToPoint = b3.Class("MoveToPoint", b3.Action)
b3.MoveToPoint = moveToPoint

function moveToPoint:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "moveToPoint"
	self.title = "moveToPoint"
	-- self.parameters = {milliseconds = 0,}
	-- self.endTime = settings.endTime or self.parameters.milliseconds
	-- settings = settings or {}
end

function moveToPoint:tick(tick)
	-- local currTime = os.time()
	local player = tick.blackboard:get("player")
	local enemy = tick.blackboard:get('enemy')
	-- if not startTime or startTime == 0 then
	-- 	startTime = currTime
	-- 	tick.blackboard:set("startTime", currTime, tick.tree.id, self.id)
	-- end
	-- --- 添加时间
	-- self.endTime = startTime + self.parameters.milliseconds
	-- if currTime - startTime > self.endTime then
	-- 	return b3.SUCCESS
	-- end
	-- self.x = self.x + math.random( -1, 1 )
	-- self.y = self.y + math.random( -1,1)
    local d = math.getDirection(enemy.x,enemy.y,player.x,player.y)
    if d == 'N' then actions.moveN(enemy) end
    if d == 'S' then actions.moveS(enemy) end
    if d == 'W' then actions.moveW(enemy) end
    if d == 'E' then actions.moveE(enemy) end
	if player.x == enemy.x and player.y == enemy.y then
		return b3.SUCCESS
	end

	return b3.RUNNING
end

function moveToPoint:execute( ... )
	-- body
end