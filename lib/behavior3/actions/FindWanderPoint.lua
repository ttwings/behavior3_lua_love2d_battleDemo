require 'lib.behavior3.core.Action'

local findWanderPoint = b3.Class("FindWanderPoint", b3.Action)
b3.FindWanderPoint = findWanderPoint

function findWanderPoint:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "FindWanderPoint"
	self.title = "FindWanderPoint"
	self.parameters = {x=self.x,y=self.y,radius=100}
	-- self.x = settings.x or 100
	-- self.y = settings.y or 100
	self.radius = settings.radius or 100
end

function findWanderPoint:tick(tick)
	local player = tick.blackboard:get("player")
	local enemy = tick.blackboard:get("enemy")

	if (player.x - enemy.x)^2 + (player.y - enemy.y)^2 < self.radius^2 then
		return b3.SUCCESS
	end

	-- return b3.RUNNING
end