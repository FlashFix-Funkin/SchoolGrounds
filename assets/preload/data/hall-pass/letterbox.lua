local GoOff = false
function createLetterboxing()

	makeLuaSprite('bartop','',0,-900)
    makeGraphic('bartop',1900,1000,'000000')
    addLuaSprite('bartop',true)

    makeLuaSprite('barbot','',0,625)
    makeGraphic('barbot',1900,1000,'000000')
    addLuaSprite('barbot',true)
	
    setScrollFactor('bartop',0,0)
    setScrollFactor('barbot',0,0)
    setObjectCamera('bartop','hud')
    setObjectCamera('barbot','hud')
	
	setObjectOrder('bartop', getObjectOrder('bartop') - 12)
	setObjectOrder('barbot', getObjectOrder('barbot') - 12)
	
end

function onUpdate()
	if curStep >= 896 and curStep <= 1152 and not GoOff then
		GoOff = not GoOff
		doTweenY('bartopY', 'bartop', -850, 19.2, 'circIn') 
		doTweenY('barbotY', 'barbot', 575, 19.2, 'circIn') 
	end
end

function onTweenCompleted(name)
	if name == "bartopY" then
		doTweenY('bartopY2', 'bartop', -900, 0.75, 'circOut')  
	elseif name == "barbotY" then
		doTweenY('barbotY2', 'barbot', 625, 0.75, 'circOut') 
	end
end

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'letterbox') == true then
		createLetterboxing();
	end
end