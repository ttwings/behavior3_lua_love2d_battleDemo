require 'lib.util'
local actions = require("actions")
local drawObjs = require("drawObjs")
local Input = require "lib/Input"
require( "lib.behavior3" )

colors = {}
colors.backgroud = {255,255,255}
colors.player = {255,0,0}
colors.enemy = {0,255,255}
colors.timer = {255,255,0}

--- 简单调试测试

function traceback()
    for level = 1,math.huge do
        local info = debug.getinfo(level,"Sl")
        if not info then break end
        if info.what == "C" then --  c
            print(level,"C function")
        else
            print(string.format("[%s]:%d",info.short_src,info.currentline))
        end
    end
end

function initGrid(numX,numY,value)
	local g={}
	for y=1,numY do
		g[y]={}
		for x=1,numX do
			g[y][x] = value
		end
	end
	return g
end
local behaviorTree = b3.BehaviorTree.new()
local blackBoard = b3.Blackboard.new()

function love.load()
    local font = love.graphics.newFont("lib/msyh.ttf",12)
    love.graphics.setFont(font)
    input = Input()
    input:bind('f','dpright')
    input:bind('s','dpleft')
    input:bind('e','dpup')
    input:bind('d','dpdown')
    input:bind('i','fup')
    input:bind('k','fdown')
    input:bind('j','fleft')
    input:bind('l','fright')
    input:bind('g','back')
    input:bind('h','start')
    input:bind('r','l1')
    input:bind('u','r1')
    input:bind('w','l2')
    input:bind('o','r2')
    player = {x = 5,y = 5,hp = 8,turn = 100,name = "东方",action = "行动",
                     color = colors.player,skill1={name="长拳",exp=1},skill2={name="罗汉拳",exp=1},skill3={name="通背拳",exp=1},skill4={name="伏虎拳",exp=1}}
    enemy = {x = 7,y = 7,hp = 10,turn = 90,name = "赖三",action = "行动",
                    color = colors.enemy}


    player.id = math.createID()
    enemy.id = math.createID()

    timer = {turn = 0,name = "时间",color = colors.timer,
    timeLineLong = 600,timeLineX = 70,timeLineY = 40,timeLineW = 5,timeLineName = "时间轴"}

    actions1 = {"前进","后退","左闪","右闪","防御","使用轻功","使用内功","使用招式"}

   	msg = {}

   	temperature = {t0=math.random(-20,20),tMax = 50,tMin = -50,actorTmax = 25,actorTmin = -10,state = {'hot','good','cold'}}
    -- 简单调试工具
    -- traceback()
    print("------------------------------------------------")
    print("TreeID:"..behaviorTree.id)
    print("TreeTitle:"..behaviorTree.title)
    print("TreeDesc:"..behaviorTree.description)
    behaviorTree:load('lib/behavior3/jsons/behavior3.json', {})

end

function love.draw()
	drawObjs.timerLine(timer)
	-- player turn
    drawObjs.actor(player)
    drawObjs.actor(enemy)
    drawObjs.message(msg)
    -- print actor
    drawObjs.actorState(player,600,40,20)
    drawObjs.actorState(enemy,700,40,20)
    -- temperature
    drawObjs.temperature(temperature,760,500)
end

function love.update(dt)
    if player.turn > timer.turn then
        timer.turn = timer.turn + 1
        if player.turn == timer.turn then
            table.insert(msg,player.name .. ":"..player.action)
        end
        if enemy.turn == timer.turn then
            table.insert(msg,enemy.name .. ":"..enemy.action)
            enemy.turn = timer.turn + math.random(1,10)

            behaviorTree:tick(enemy.id, blackBoard)
        end
    end

    if player.turn == timer.turn then
    	if input:pressed('dpup') then
    		actions.moveN(player)
    	end
    	if input:pressed('dpdown') then
    		actions.moveS(player)
    	end
    	if input:pressed('dpleft') then
    		actions.moveW(player)
    	end
    	if input:pressed('dpright') then
    		actions.moveE(player)
    	end

    	if input:pressed('fup')then
    		actions.attack1(player,enemy)
    	end
    	if input:pressed('fleft')then
    		actions.attack2(player,enemy)
    	end
    	if input:pressed('fdown')then
    		actions.attack3(player,enemy)
    	end
    	if input:pressed('fright')then
    		actions.attack4(player,enemy)
    	end

    	if input:down('l1') and input:pressed('fup')then
    		actions.attack5(player,enemy)
    	end
    	if input:down('l1') and input:pressed('fleft')then
    		actions.attack6(player,enemy)
    	end
    	if input:down('l1') and input:pressed('fdown')then
    		actions.attack7(player,enemy)
    	end
    	if input:down('l1') and input:pressed('fright')then
    		actions.attack8(player,enemy)
    	end

    	if input:down('r1') and input:pressed('dpup')then
    		actions.runN(player,enemy)
    	end
    	if input:down('r1') and input:pressed('dpleft')then
    		actions.runW(player,enemy)
    	end
    	if input:down('r1') and input:pressed('dpdown')then
    		actions.runS(player,enemy)
    	end
    	if input:down('r1') and input:pressed('dpright')then
    		actions.runE(player,enemy)
    	end
	end
end



