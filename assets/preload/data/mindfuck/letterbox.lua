--[[function createLetterboxing()

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
function onUpdatePost()
    setProperty('defaultCamZoom', 0.7)
    if (curStep >= 624 and curStep < 639) or (curStep >= 1919 and curStep < 1960) then
        setProperty('defaultCamZoom', 0.9)
    end
    if curStep > 1960 then
        setProperty('defaultCamZoom', 0.6)
    end
end
function onStepHit()
    if curStep == 622 then
        doTweenY('bartopY', 'bartop', -775, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 500, 0.35, 'circOut')
    end
    if curStep == 638 then
        doTweenY('bartopY', 'bartop', -900, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 625, 0.35, 'circOut')
    end
    if curStep == 1919 then
        doTweenY('bartopY', 'bartop', -725, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 550, 0.35, 'circOut')
    end
    if curStep == 1960 then
        doTweenY('bartopY', 'bartop', -2000, 0.35, 'circOut')
        doTweenY('barbotY', 'barbot', 2000, 0.35, 'circOut')
    end

    if curStep == 1960 then
        doTweenZoom('zomfinal', 'camGame', 0.6, 0.25, 'circOut')
    end
end

function onCreate()
    createLetterboxing()
end]]