local moveToPoint = b3.Class("MoveToPoint", b3.Action)
b3.MoveToPoint = moveToPoint

function moveToPoint:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "moveToPoint"
	self.title = "moveToPoint"
	 self.parameters = {x = 0,y = 0}
	-- self.endTime = settings.endTime or self.parameters.milliseconds
	-- settings = settings or {}
end
colors = {}
colors.backgroud = {255,255,255}
colors.player = {255,0,0}
colors.enemy = {0,255,255}
colors.timer = {255,255,0}

player = {x = 5,y = 5,hp = 8,turn = 100,name = "东方",action = "行动",
		  color = colors.player,skill1={name="长拳",exp=1},skill2={name="罗汉拳",exp=1},skill3={name="通背拳",exp=1},skill4={name="伏虎拳",exp=1}}
enemy = {x = 7,y = 7,hp = 10,turn = 90,name = "赖三",action = "行动",
		 color = colors.enemy}

function moveToPoint:open(tick)
	tick.blackboard:set('player',player,tick.tree.id,self.id)
	tick.blackboard:set('enemy',enemy,tick.tree.id,self.id)
end

function moveToPoint:tick(tick)

	local player = tick.blackboard:get("player",tick.tree.id,self.id)
	local enemy = tick.blackboard:get('enemy',tick.tree.id,self.id)

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
