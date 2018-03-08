require 'lib.behavior3.core.Action'

local findWanderPoint = b3.Class("FindWanderPoint", b3.Action)
b3.FindWanderPoint = findWanderPoint

function findWanderPoint:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "FindWanderPoint"
	self.title = "FindWanderPoint"
	self.parameters = {x=self.x,y=self.y,radius=100}
	self.x = settings.x
	self.y = settings.y
	self.radius = settings.radius or 100
end

function findWanderPoint:open(tick)
	local point = {x = self.x,y=self.y}

	tick.blackboard:set('point',point,tick.tree.id,self.id)
end

function findWanderPoint:tick(tick)
	local player = tick.blackboard:get("player")
	local enemy = tick.blackboard:get("enemy")

	if (player.x - enemy.x)^2 + (player.y - enemy.y)^2 < self.radius^2 then
		return b3.SUCCESS
	end

	-- return b3.RUNNING
end