local moveToPoint = b3.Class("MoveToPoint", b3.Action)
b3.MoveToPoint = moveToPoint

function moveToPoint:ctor(settings)
	b3.Action.ctor(self)

	self.name = "moveToPoint"
	self.title = "moveToPoint"

end

function moveToPoint:tick(tick)

	local point = tick.blackboard:get('point')
	local actor = tick.blackboard:get('actor')
    local d = math.getDirection(actor.x,actor.y,point.x,point.y)
    print(d)

	if point.x == actor.x and point.y == actor.y then
		return b3.SUCCESS
	end
	if d == 'N' then actions.moveN(actor) end
    if d == 'S' then actions.moveS(actor) end
    if d == 'W' then actions.moveW(actor) end
    if d == 'E' then actions.moveE(actor) end
    if d == 'EN' then actions.moveEN(actor) end
    if d == 'ES' then actions.moveES(actor) end
    if d == 'WN' then actions.moveWN(actor) end
    if d == 'WS' then actions.moveWS(actor) end

	return b3.RUNNING
end
