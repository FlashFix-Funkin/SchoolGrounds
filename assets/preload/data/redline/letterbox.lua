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
	if (curStep > 528 and curStep < 592) or (curStep > 656 and curStep < 720) then
		doTweenY('bartopY', 'bartop', -875, 4, 'circOut')
		doTweenY('barbotY', 'barbot', 600, 4, 'circOut')
	elseif (curStep > 592 and curStep < 656) or (curStep > 720 and curStep < 784) then
		doTweenY('bartopY', 'bartop', -900, 4, 'circOut')
		doTweenY('barbotY', 'barbot', 625, 4, 'circOut')
	end
end

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'letterbox') == true then
		createLetterboxing();
	end
end