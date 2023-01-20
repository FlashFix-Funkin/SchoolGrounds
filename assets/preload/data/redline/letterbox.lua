function createLetterboxing()

	makeLuaSprite('bartop','',0,-1000)
    makeGraphic('bartop',2900,1000,'000000')
    addLuaSprite('bartop',true)

    makeLuaSprite('barbot','',0,725)
    makeGraphic('barbot',2900,1000,'000000')
    addLuaSprite('barbot',true)

    setScrollFactor('bartop',0,0)
    setScrollFactor('barbot',0,0)
    setObjectCamera('bartop','hud')
    setObjectCamera('barbot','hud')

	setObjectOrder('bartop', getObjectOrder('bartop') - 12)
	setObjectOrder('barbot', getObjectOrder('barbot') - 12)

end
function onStepHit()
    if curStep == 16 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end
end

function onCreate()
    createLetterboxing()
end