local skills = require("skills")
actions = {}

function rollDice(N,S,A)
    -- roll N ,S number dice
    local A = A or 0
    value = 0
    for i=1,N do
        value = value + math.random(S)
    end
    return value+A
end

function skillAttack(skill)
	local damage = rollDice(skill.dN,skill.dS,skill.dA)
	return damage
end

function actions.moveN(actor)
	actor.action = "向北移动"
	actor.y = actor.y - 1
	actor.turn = actor.turn + 20
end

function actions.moveS(actor)
	actor.action = "向南移动"
	actor.y = actor.y + 1
	actor.turn = actor.turn + 20
end

function actions.moveW(actor)
	actor.action = "向西移动"
	actor.x = actor.x - 1
	actor.turn = actor.turn + 20
end

function actions.moveE(actor)
	actor.action = "向东移动"
	actor.x = actor.x + 1
	actor.turn = actor.turn + 20
end

function actions.moveEN(actor)
	actor.action = "向东北移动"
	actor.x = actor.x + 1
	actor.y = actor.y - 1
	actor.turn = actor.turn + 20
end

function actions.moveES(actor)
	actor.action = "向东南移动"
	actor.x = actor.x + 1
	actor.y = actor.y + 1
	actor.turn = actor.turn + 20
end

function actions.moveWN(actor)
	actor.action = "向西北移动"
	actor.x = actor.x - 1
	actor.y = actor.y - 1
	actor.turn = actor.turn + 20
end

function actions.moveWS(actor)
	actor.action = "向西南移动"
	actor.x = actor.x - 1
	actor.y = actor.y + 1
	actor.turn = actor.turn + 20
end


function actions.runN(actor)
	actor.action = "向北闪"
	actor.y = actor.y - 2
	actor.turn = actor.turn + 20
end

function actions.runS(actor)
	actor.action = "向南闪"
	actor.y = actor.y + 2
	actor.turn = actor.turn + 20
end

function actions.runW(actor)
	actor.action = "向西闪"
	actor.x = actor.x - 2
	actor.turn = actor.turn + 20
end

function actions.runE(actor)
	actor.action = "向东闪"
	actor.x = actor.x + 2
	actor.turn = actor.turn + 20
end

function attackMsg(target,skill,exp)
	local s = skill
	local msg = string.format("使用招式%s对%s造成%d点%s,%s熟练度变为%d",s.name,target.name,skillAttack(s),s.dT,s.name,exp)
	return msg
end

function actions.attack(actor,target)
	local s = skills[actor.skill1.name]
	actor.turn = actor.turn + s.turn
	actor.skill1.exp = actor.skill1.exp + 1
	local exp = actor.skill1.exp
	actor.action = attackMsg(target,s,exp)
end

function actions.attack1(actor,target)
	local s = skills[actor.skill1.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill1.exp = actor.skill1.exp + 1
end

function actions.attack2(actor,target)
	local s = skills[actor.skill2.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill2.exp = actor.skill2.exp + 1
end

function actions.attack3(actor,target)
	local s = skills[actor.skill3.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill3.exp = actor.skill3.exp + 1
end

function actions.attack4(actor,target)
	local s = skills[actor.skill4.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill4.exp = actor.skill4.exp + 1
end

function actions.attack5(actor,target)
	local s = skills[actor.skill4.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill4.exp = actor.skill4.exp + 1
end
function actions.attack6(actor,target)
	local s = skills[actor.skill4.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill4.exp = actor.skill4.exp + 1
end
function actions.attack7(actor,target)
	local s = skills[actor.skill4.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill4.exp = actor.skill4.exp + 1
end
function actions.attack8(actor,target)
	local s = skills[actor.skill4.name]
	actor.action = attackMsg(target,s)
	actor.turn = actor.turn + 20
	actor.skill4.exp = actor.skill4.exp + 1
end

function actions.deffence(actor)
	actor.action = "开始防御"
	actor.turn = actor.turn + 15
end

function actions.wait(actor,turn)
	local turn = turn or 10
	actor.action = "等待"
	actor.turn = actor.turn + turn
end

function actions.use(actor)
	actor.action = "使用"
	actor.turn = actor.turn + 3
end

return actions