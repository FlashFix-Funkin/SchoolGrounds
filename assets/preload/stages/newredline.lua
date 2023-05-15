function onCreatePost()
	makeLuaSprite('backBackG', 'bgs/redline/bgColor', -300, -400);
	scaleObject('backBackG',0.8, 0.8)

	makeLuaSprite('train', 'bgs/redline/train_back', -4000, 0);
	scaleObject('train',0.8,0.8)

	makeLuaSprite('backBars', 'bgs/redline/backBars', -300, -400);
	scaleObject('backBars',0.8, 0.8)

	makeLuaSprite('back', 'bgs/redline/groundBack', -300, -400);
	scaleObject('back',0.8, 0.8)

	makeLuaSprite('front', 'bgs/redline/groundFront', -300, -400);
	scaleObject('front',0.8, 0.8)

	makeLuaSprite('pillars', 'bgs/redline/pillarsFront', -300, -400);
	scaleObject('pillars',0.8, 0.8)

	makeLuaSprite('fgBars', 'bgs/redline/redLine', -300, -400);
	scaleObject('fgBars',0.8, 0.8)

	makeLuaSprite('fgTRASH', 'bgs/redline/nebulaZora', -300, -400);
	setProperty('fgTRASH.flipX', true)
	scaleObject('fgTRASH',0.8, 0.8)

	makeLuaSprite('sickSigns1', 'bgs/redline/signLeft1', -300, -400);
	scaleObject('sickSigns1',0.8, 0.8)

	makeLuaSprite('sickSigns2', 'bgs/redline/signRight1', -300, -400);
	scaleObject('sickSigns2',0.8, 0.8)

	makeLuaSprite('sickSigns3', 'bgs/redline/signRight2', -300, -400);
	scaleObject('sickSigns3',0.8, 0.8)
	
	makeLuaSprite('flashingLights', 'bgs/redline/lightsUpper', -300, -400);
	scaleObject('flashingLights',0.8, 0.8)
	-- by kanye weset!! !!??

    makeLuaSprite('overlay1', 'bgs/redline/lightMiddle', -300, -400);
	scaleObject('overlay1',0.8, 0.8)
	setProperty('overlay1.alpha', 0.1)
	setBlendMode('overlay1', 'add')

    makeLuaSprite('overlay2', 'bgs/redline/lightLeft', -300, -400);
    scaleObject('overlay2',0.8, 0.8)
	setProperty('overlay2.alpha', 0.1)
	setBlendMode('overlay2', 'add')

	makeLuaSprite('overlay3', 'bgs/redline/lightRight', -300, -400);
    scaleObject('overlay3',0.8, 0.8)
	setProperty('overlay3.alpha', 0.1)
	setBlendMode('overlay3', 'add')

	makeLuaSprite('overlay4', 'bgs/redline/graident', -300, -400);
    scaleObject('overlay4',0.8, 0.8)
	setProperty('overlay4.alpha', 0.5)
	setBlendMode('overlay4', 'darken')

	addLuaSprite('backBackG', false);
	addLuaSprite('backBars', false);
	addLuaSprite('back', false);
	addLuaSprite('train', false)
	addLuaSprite('front', false);
	addLuaSprite('pillars', false);
	addLuaSprite('sickSigns1', false);
	addLuaSprite('sickSigns2', false);
	addLuaSprite('sickSigns3', false);
	addLuaSprite('flashingLights', false);
	addLuaSprite('overlay1', true);
	addLuaSprite('overlay2', true);
	addLuaSprite('overlay3', true);
	addLuaSprite('fgTRASH', true);
	addLuaSprite('fgBars', true);
	addLuaSprite('overlay4', true);
	

end
