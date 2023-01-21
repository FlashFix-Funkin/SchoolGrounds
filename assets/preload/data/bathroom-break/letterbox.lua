function createLetterboxing()

	makeLuaSprite('bartop','',0,-1000)
    makeGraphic('bartop',1900,1000,'000000')
    addLuaSprite('bartop',true)

    makeLuaSprite('barbot','',0,725)
    makeGraphic('barbot',1900,1000,'000000')
    addLuaSprite('barbot',true)

    setScrollFactor('bartop',0,0)
    setScrollFactor('barbot',0,0)
    setObjectCamera('bartop','hud')
    setObjectCamera('barbot','hud')

	setObjectOrder('bartop', getObjectOrder('bartop') - 12)
	setObjectOrder('barbot', getObjectOrder('barbot') - 12)

end
function onBeatHit()
    if curBeat == 1 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end

    if curBeat == 355 then
        doTweenY('bartopY', 'bartop', -850, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 550, 0.35, 'circOut')
    end

    if curBeat == 512 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end
end

function onCreate()
    createLetterboxing()
end